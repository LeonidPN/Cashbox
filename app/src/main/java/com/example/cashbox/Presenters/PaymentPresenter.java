package com.example.cashbox.Presenters;

import android.content.res.Resources;
import android.util.Log;
import android.widget.Toast;

import androidx.recyclerview.widget.RecyclerView;

import com.example.cashbox.ExceptionCallback;
import com.example.cashbox.FiscalCoreServiceConnection;
import com.example.cashbox.IToast;
import com.example.cashbox.Models.Product;
import com.example.cashbox.R;
import com.example.cashbox.Views.PaymentActivity;
import com.example.cashbox.Views.PaymentListAdapter;
import com.multisoft.drivers.fiscalcore.IFiscalCore;

import java.util.ArrayList;
import java.util.List;

public class PaymentPresenter implements IToast {

    private PaymentActivity view;
    private List<Product> products;

    private static final String LANG_DEFAULT = "Ru-ru";
    private static final String ENVIRONMENT = "";
    private static final String TAG = "PaymentActivity";
    private static final int RECTYPE_UNFISCAL = 9;
    private static final int PAY_TYPE_CASH = 0;

    private FiscalCoreServiceConnection _connection;
    ExceptionCallback _callback = new ExceptionCallback();

    public PaymentPresenter(PaymentActivity view) {
        this.view = view;
        products = new ArrayList<>();
    }

    public void initialize() {
        _connection = new FiscalCoreServiceConnection(view);
        _connection.Initialize(LANG_DEFAULT, ENVIRONMENT, this);
        try {
            IFiscalCore core = getCore();
            core.OpenRec(RECTYPE_UNFISCAL, _callback);
            _callback.Complete();
        } catch (Exception e) {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    public void add() {
        products.add(new Product(1, "1", 100, 1, ""));
        ((RecyclerView) view.findViewById(R.id.recyclerView)).setAdapter(new PaymentListAdapter(products));
    }

    public void pay() {
        try {
            IFiscalCore core = getCore();
            for (int i = 0; i < products.size(); i++) {
                core.PrintRecItem(products.get(i).getCount() + "", products.get(i).getPrice() + "",
                        products.get(i).getName(), products.get(i).getArticle(), _callback);
                _callback.Complete();
            }
            core.PrintRecTotal(_callback);
            _callback.Complete();
            String total = core.GetRecTotal(_callback);
            _callback.Complete();
            core.PrintRecItemPay(PAY_TYPE_CASH, total, view.getString(R.string.cash), _callback);
            _callback.Complete();
            core.CloseRec(_callback);
            _callback.Complete();
        } catch (Exception e) {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    public void payBack() {

    }

    public List<Product> getProducts() {
        return products;
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
}
