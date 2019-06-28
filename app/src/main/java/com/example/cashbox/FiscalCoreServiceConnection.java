package com.example.cashbox;

import android.content.ComponentName;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;

import com.multisoft.drivers.fiscalcore.IExceptionCallback;
import com.multisoft.drivers.fiscalcore.IFiscalCore;

public class FiscalCoreServiceConnection extends ContextWrapper implements ServiceConnection
{
    final static String TAG = "FCServiceConnection";
    final static String REMOTE_SERVICE_ACTION_NAME = "com.multisoft.drivers.fiscalcore.IFiscalCore";
    final static String REMOTE_SERVICE_PACKAGE_NAME = "com.multisoft.drivers.fiscalcore";
    final static String REMOTE_SERVICE_COMPONENT_NAME = "com.multisoft.fiscalcore";
    private IToast _toaster;
    private IFiscalCore _core;

    public FiscalCoreServiceConnection(Context base)
    {
        super(base);
    }

    public void Initialize(String lang, String env, IToast toaster)
    {
        _toaster = toaster;
        Intent intent = new Intent();
        intent.setPackage(REMOTE_SERVICE_PACKAGE_NAME);
        intent.setAction(REMOTE_SERVICE_ACTION_NAME);
        ComponentName cn = new ComponentName(REMOTE_SERVICE_PACKAGE_NAME, REMOTE_SERVICE_COMPONENT_NAME);
        intent.setComponent(cn);

        Bundle _bundle = new Bundle();
        _bundle.putString("lang", lang);
        _bundle.putString("env", env);
        intent.putExtras(_bundle);

        startService(intent);
        if (bindService(intent, this, Context.BIND_AUTO_CREATE))
        {
            Log.i(TAG, "Service bound successfully");
        }
    }

    public void Uninitialize()
    {
        unbindService(this);
    }

    String errmsg;
    private final IExceptionCallback.Stub mCallback = new IExceptionCallback.Stub()
    {
        public void HandleException(int errCode, String message, int extErrCode, String stackTrace)
        {
            errmsg = message;
        }
    };

    @Override
    public void onServiceConnected(ComponentName name, IBinder service)
    {
        Log.i(TAG, "onServiceConnected");
        _core = IFiscalCore.Stub.asInterface(service);

        _toaster.Toast(R.string.connected, true);
    }

    @Override
    public void onServiceDisconnected(ComponentName name)
    {
        Log.i(TAG, "onServiceDisconnected");

        _toaster.Toast(R.string.disconnected, true);
    }

    public IFiscalCore GetCore()
    {
        return _core;
    }

}
