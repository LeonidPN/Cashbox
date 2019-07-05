package com.example.cashbox.Presenters;

import android.content.res.Resources;
import android.database.Cursor;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import androidx.recyclerview.widget.RecyclerView;

import com.example.cashbox.ExceptionCallback;
import com.example.cashbox.FiscalCoreServiceConnection;
import com.example.cashbox.IToast;
import com.example.cashbox.Models.Check;
import com.example.cashbox.Models.CheckPayBack;
import com.example.cashbox.Models.CheckPayBackTable;
import com.example.cashbox.Models.CheckTable;
import com.example.cashbox.Models.DbHelper;
import com.example.cashbox.R;
import com.example.cashbox.Views.PayBackActivity;
import com.example.cashbox.Views.PayBackListAdapter;
import com.example.cashbox.Views.PaymentActivity;
import com.multisoft.drivers.fiscalcore.IFiscalCore;

import java.util.ArrayList;
import java.util.List;

public class PayBackPresenter implements IToast {

    private PayBackActivity view;
    private DbHelper dbHelper;
    private int position;

    private static final String LANG_DEFAULT = "Ru-ru";
    private static final String ENVIRONMENT = "";
    private static final String TAG = "PayBackActivity";
    private static final int RECTYPE_PAYBACK = 3;
    private static final int PAY_TYPE_CASH = 0;

    private FiscalCoreServiceConnection _connection;
    ExceptionCallback _callback = new ExceptionCallback();

    public PayBackPresenter(PayBackActivity view) {
        this.view = view;
        dbHelper = new DbHelper(view);
    }

    public void initialize() {
        _connection = new FiscalCoreServiceConnection(view);
        _connection.Initialize(LANG_DEFAULT, ENVIRONMENT, this);
    }


    public void payBack() {
        try {
            CheckPayBack checkPayBack = getList().get(position);
            IFiscalCore core = getCore();
            core.SetTaxationUsing(1, _callback);
            _callback.Complete();
            core.OpenRec(RECTYPE_PAYBACK, _callback);
            _callback.Complete();
            core.SetItemTaxes(5, _callback);
            core.SetShowTaxes(true, _callback);
            _callback.Complete();
            core.PrintRecItem("1", checkPayBack.getSum(), "Возврат чека" + checkPayBack.getNumber(), "", _callback);
            _callback.Complete();
            core.PrintRecTotal(_callback);
            _callback.Complete();
            String total = core.GetRecTotal(_callback);
            _callback.Complete();
            core.PrintRecItemPay(PAY_TYPE_CASH, total, view.getString(R.string.cash), _callback);
            _callback.Complete();
            core.CloseRec(_callback);
            _callback.Complete();
            dbHelper.getWritableDatabase().delete(CheckPayBackTable.TABLE, CheckPayBackTable.COLUMN.ID + " = " + checkPayBack.getId(),
                    null);
        } catch (Exception e) {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
        view.finish();
    }

    public List<CheckPayBack> getCheckPayBackList() {
        return getList();
    }

    public void cancel() {
        dbHelper.getWritableDatabase().delete(CheckTable.TABLE, null, null);
        try {
            IFiscalCore core = getCore();
            if (core.GetRecState(_callback) == 0) {
                core.RecVoid(_callback);
                _callback.Complete();
            }
        } catch (Exception e) {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
        view.finish();
    }

    public void destroy() {
        try {
            IFiscalCore core = getCore();
            if (core.GetRecState(_callback) == 0) {
                core.RecVoid(_callback);
                _callback.Complete();
            }
        } catch (Exception e) {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
        dbHelper.close();
        _connection.Uninitialize();
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

    private List<CheckPayBack> getList() {
        Cursor c = dbHelper.getReadableDatabase().query(CheckPayBackTable.TABLE, null, null, null, null, null, null);
        List<CheckPayBack> checkPayBackList = new ArrayList<>();
        int idColIndex = c.getColumnIndex(CheckPayBackTable.COLUMN.ID);
        int sumColIndex = c.getColumnIndex(CheckPayBackTable.COLUMN.SUM);
        int numberColIndex = c.getColumnIndex(CheckPayBackTable.COLUMN.NUMBER);
        int dateColIndex = c.getColumnIndex(CheckPayBackTable.COLUMN.DATE);
        while (c.moveToNext()) {
            checkPayBackList.add(new CheckPayBack(c.getInt(idColIndex), c.getString(sumColIndex), c.getString(numberColIndex),
                    c.getString(dateColIndex)));
        }
        c.close();
        return checkPayBackList;
    }

    public void setPosition(int position) {
        this.position = position;
        ((RecyclerView) view.findViewById(R.id.recyclerView)).getAdapter().notifyDataSetChanged();
    }

    public int getPosition() {
        return position;
    }
}
