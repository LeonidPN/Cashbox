package com.example.cashbox;

import com.multisoft.drivers.fiscalcore.IExceptionCallback;

public class ExceptionCallback extends IExceptionCallback.Stub
{
    private final int Uninitialized = 0xFF;
    private String msg;
    private int err = Uninitialized;
    //private int exterr;
    //private String trace;

    @Override
    public void HandleException(int errCode, String message, int extErrCode, String stackTrace)  {
        msg = message;
        err = errCode;
        //exterr = extErrCode;
        //trace = stackTrace;
    }

    public void Complete() throws Exception {
        if(err != Uninitialized)
        {
            //FiscalCoreException e = new FiscalCoreException(msg, err, exterr, trace);
            Exception e = new Exception(msg);
            err = Uninitialized;
            throw e;
        }
    }
}
