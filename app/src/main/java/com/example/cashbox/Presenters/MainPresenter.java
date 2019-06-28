package com.example.cashbox.Presenters;

import android.content.Intent;
import android.content.res.Resources;
import android.util.Log;
import android.widget.Toast;

import com.example.cashbox.ExceptionCallback;
import com.example.cashbox.FiscalCoreServiceConnection;
import com.example.cashbox.IToast;
import com.example.cashbox.R;
import com.example.cashbox.Views.MainActivity;
import com.multisoft.drivers.fiscalcore.IFiscalCore;

public class MainPresenter implements IToast {

    private MainActivity view;

    private static final String LANG_DEFAULT = "Ru-ru";
    private static final String ENVIRONMENT = "";
    private static final String TAG = "MainActivity";
    private static final String CASHIER_NAME = "кассир";

    private FiscalCoreServiceConnection _connection;
    ExceptionCallback _callback = new ExceptionCallback();

    public MainPresenter(MainActivity view){
        this.view=view;
    }

    public void initialize(){
        _connection = new FiscalCoreServiceConnection(view);
        _connection.Initialize(LANG_DEFAULT, ENVIRONMENT, this);
    }

    public void openView(Class c, boolean isPayBack){
        Intent intent = new Intent(view, c);
        intent.putExtra("IS_PAY_BACK", isPayBack);
        view.startActivity(intent);
    }

    @Override
    public void Toast(int messageId, boolean isLong)
    {
        try
        {
            String message = view.getString(messageId);
            Toast.makeText(view, message, isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT).show();
        }
        catch (Resources.NotFoundException e)
        {
            String report = e.getMessage() + "\n";
            report += e.getStackTrace();
            Log.e(TAG, report);
        }
    }

    public  void openShift(){
        try
        {
            IFiscalCore core = getCore();
            core.OpenDay(CASHIER_NAME, _callback);
            _callback.Complete();
        }
        catch (Exception e)
        {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    public  void closeShift(){
        try
        {
            IFiscalCore core = _connection.GetCore();
            if (core == null)
                throw new Exception(view.getString(R.string.service_not_connected));
            core.CloseDay(CASHIER_NAME, _callback);
            _callback.Complete();
        }
        catch (Exception e)
        {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    private IFiscalCore getCore() throws Exception
    {
        IFiscalCore core = _connection.GetCore();
        if (core == null)
            throw new Exception(view.getString(R.string.service_not_connected));
        return core;
    }

    public void destroy(){

    }

}
