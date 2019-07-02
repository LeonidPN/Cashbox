package com.example.cashbox.Presenters;

import android.content.res.Resources;
import android.util.Log;
import android.widget.Toast;

import com.example.cashbox.ExceptionCallback;
import com.example.cashbox.FiscalCoreServiceConnection;
import com.example.cashbox.IToast;
import com.example.cashbox.Models.DbHelper;
import com.example.cashbox.R;
import com.example.cashbox.Views.CorrectionActivity;
import com.multisoft.drivers.fiscalcore.IFiscalCore;

public class CorrectionPresenter implements IToast {

    private CorrectionActivity view;
    private DbHelper dbHelper;

    private static final String LANG_DEFAULT = "Ru-ru";
    private static final String ENVIRONMENT = "";
    private static final String TAG = "CorrectionActivity";
    private static final int RECTYPE_CORRECTION = 19;

    private FiscalCoreServiceConnection _connection;
    ExceptionCallback _callback = new ExceptionCallback();

    public CorrectionPresenter(CorrectionActivity view) {
        this.view = view;
        dbHelper = new DbHelper(view);
    }

    public void initialize() {
        _connection = new FiscalCoreServiceConnection(view);
        _connection.Initialize(LANG_DEFAULT, ENVIRONMENT, this);
    }

    public void correction() {
        try {
            IFiscalCore core = getCore();
            core.SetTaxationUsing(1, _callback);
            _callback.Complete();
            core.OpenRec(RECTYPE_CORRECTION, _callback);
            _callback.Complete();
            String docName = "1";
            String docNum = "1";
            String docDate = "2017-02-28T19:12:03.000Z";
            int operationType = 9;
            String cash = "1";
            String emoney = "0";
            String advance = "0";
            String credit = "0";
            String other = "0";
            core.FNMakeCorrectionRec(operationType, cash, emoney, advance, credit, other, 1, 0, docName,
                    docDate, docNum, _callback);
            _callback.Complete();
            core.CloseRec(_callback);
            _callback.Complete();
        } catch (Exception e) {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public void Toast(int messageId, boolean isLong) {
        try {
            String message = view.getString(messageId);
            Toast.makeText(view, message, isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT).show();
        } catch (Resources.NotFoundException e) {
            String report = e.getMessage() + "\n";
            report += e.getStackTrace();
            Log.e(TAG, report);
        }
    }

    private IFiscalCore getCore() throws Exception {
        IFiscalCore core = _connection.GetCore();
        if (core == null)
            throw new Exception(view.getString(R.string.service_not_connected));
        return core;
    }

    public void destroy() {
        dbHelper.close();
        try
        {
            IFiscalCore core = getCore();
            if(core.GetRecState(_callback)==0) {
                core.RecVoid(_callback);
                _callback.Complete();
            }
        }
        catch (Exception e)
        {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
        _connection.Uninitialize();
    }

}