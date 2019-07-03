package com.example.cashbox.Presenters;

import android.content.ContentValues;
import android.content.res.Resources;
import android.database.Cursor;
import android.util.Log;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.recyclerview.widget.RecyclerView;

import com.example.cashbox.ExceptionCallback;
import com.example.cashbox.FiscalCoreServiceConnection;
import com.example.cashbox.IToast;
import com.example.cashbox.Models.Check;
import com.example.cashbox.Models.CheckTable;
import com.example.cashbox.Models.DbHelper;
import com.example.cashbox.R;
import com.example.cashbox.Views.PaymentActivity;
import com.example.cashbox.Views.PaymentListAdapter;
import com.multisoft.drivers.fiscalcore.IFiscalCore;

import java.util.ArrayList;
import java.util.List;

public class PaymentPresenter implements IToast {

    private PaymentActivity view;
    private DbHelper dbHelper;

    private static final String LANG_DEFAULT = "Ru-ru";
    private static final String ENVIRONMENT = "";
    private static final String TAG = "PaymentActivity";
    private static final int RECTYPE_PAY = 1;
    private static final int RECTYPE_PAYBACK = 3;
    private static final int PAY_TYPE_CASH = 0;
    private static final int PAY_TYPE_ELECTRON = 1;

    private FiscalCoreServiceConnection _connection;
    ExceptionCallback _callback = new ExceptionCallback();

    public PaymentPresenter(PaymentActivity view) {
        this.view = view;
        dbHelper = new DbHelper(view);
    }

    public void initialize() {
        _connection = new FiscalCoreServiceConnection(view);
        _connection.Initialize(LANG_DEFAULT, ENVIRONMENT, this);
        List<Check> checkList = getList();
        int sum = 0;
        for (int i = 0; i < checkList.size(); i++) {
            sum += Integer.parseInt(checkList.get(i).getPrice()) * Integer.parseInt(checkList.get(i).getCount());
        }
        ((TextView) view.findViewById(R.id.textViewSum)).setText(sum + "");
    }

    public void add() {
        try {
            ContentValues cv = new ContentValues(4);
            cv.put(CheckTable.COLUMN.NAME, "1");
            cv.put(CheckTable.COLUMN.PRICE, "100");
            cv.put(CheckTable.COLUMN.COUNT, "1");
            cv.put(CheckTable.COLUMN.ARTICLE, "");
            dbHelper.getWritableDatabase().insert(CheckTable.TABLE, null, cv);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        List<Check> checkList = getList();
        int sum = 0;
        for (int i = 0; i < checkList.size(); i++) {
            sum += Integer.parseInt(checkList.get(i).getPrice()) * Integer.parseInt(checkList.get(i).getCount());
        }
        ((RecyclerView) view.findViewById(R.id.recyclerView)).setAdapter(new PaymentListAdapter(checkList));
        ((TextView) view.findViewById(R.id.textViewSum)).setText(sum + "");
    }

    public void pay() {
        try {
            int paySum = 0;
            String sumCash = ((EditText) view.findViewById(R.id.editTextSumCash)).getText().toString();
            String sumElectron = ((EditText) view.findViewById(R.id.editTextSumElectron)).getText().toString();
            int cash = sumCash.equals(null) || sumCash.equals("") ? 0 : Integer.parseInt(sumCash);
            int electron = sumElectron.equals(null) || sumElectron.equals("") ? 0 : Integer.parseInt(sumElectron);
            paySum = cash + electron;
            if (Integer.parseInt(((TextView) view.findViewById(R.id.textViewSum)).getText().toString()) <= paySum) {
                IFiscalCore core = getCore();
                core.SetTaxationUsing(1, _callback);
                _callback.Complete();
                core.OpenRec(RECTYPE_PAY, _callback);
                _callback.Complete();
                List<Check> checkList = getList();
                for (int i = 0; i < checkList.size(); i++) {
                    core.SetItemTaxes(5, _callback);
                    core.SetShowTaxes(true, _callback);
                    _callback.Complete();
                    core.PrintRecItem(checkList.get(i).getCount(), checkList.get(i).getPrice(),
                            checkList.get(i).getName(), checkList.get(i).getArticle(), _callback);
                    _callback.Complete();
                }
                core.PrintRecTotal(_callback);
                _callback.Complete();
                core.PrintRecItemPay(PAY_TYPE_CASH, cash + "", view.getString(R.string.cash), _callback);
                _callback.Complete();
                core.PrintRecItemPay(PAY_TYPE_ELECTRON, electron + "", view.getString(R.string.electron), _callback);
                _callback.Complete();
                int total = Integer.parseInt(((TextView) view.findViewById(R.id.textViewSum)).getText().toString());
                _callback.Complete();
                core.PrintRecItemPay(PAY_TYPE_CASH, (total - paySum) + "", "Сдача", _callback);
                _callback.Complete();
                core.CloseRec(_callback);
                _callback.Complete();
                dbHelper.getWritableDatabase().delete(CheckTable.TABLE, null, null);
                view.finish();
            } else {
                Toast.makeText(view.getApplicationContext(), "Недостаточно средств", Toast.LENGTH_SHORT).show();
            }
        } catch (Exception e) {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    public List<Check> getCheckList() {
        return getList();
    }

    public void cancel() {
        dbHelper.getWritableDatabase().delete(CheckTable.TABLE, null, null);
        try {
            IFiscalCore core = getCore();
            core.RecVoid(_callback);
            _callback.Complete();
        } catch (Exception e) {
            Toast.makeText(view.getApplicationContext(), e.getMessage(), Toast.LENGTH_SHORT).show();
        }
        view.finish();
    }

    public void payBack() {
        try {
            IFiscalCore core = getCore();
            core.SetTaxationUsing(1, _callback);
            _callback.Complete();
            core.OpenRec(RECTYPE_PAYBACK, _callback);
            _callback.Complete();
            List<Check> checkList = getList();
            for (int i = 0; i < checkList.size(); i++) {
                core.SetItemTaxes(5, _callback);
                core.SetShowTaxes(true, _callback);
                _callback.Complete();
                core.PrintRecItem(checkList.get(i).getCount(), checkList.get(i).getPrice(),
                        checkList.get(i).getName(), checkList.get(i).getArticle(), _callback);
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
        dbHelper.getWritableDatabase().delete(CheckTable.TABLE, null, null);
        view.finish();
    }

    public void destroy() {
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

    private List<Check> getList() {
        Cursor c = dbHelper.getReadableDatabase().query(CheckTable.TABLE, null, null, null, null, null, null);
        List<Check> checkList = new ArrayList<>();
        int idColIndex = c.getColumnIndex(CheckTable.COLUMN.ID);
        int nameColIndex = c.getColumnIndex(CheckTable.COLUMN.NAME);
        int priceColIndex = c.getColumnIndex(CheckTable.COLUMN.PRICE);
        int countColIndex = c.getColumnIndex(CheckTable.COLUMN.COUNT);
        int articleColIndex = c.getColumnIndex(CheckTable.COLUMN.ARTICLE);
        while (c.moveToNext()) {
            checkList.add(new Check(c.getInt(idColIndex), c.getString(nameColIndex), c.getString(priceColIndex),
                    c.getString(countColIndex), c.getString(articleColIndex)));
        }
        c.close();
        return checkList;
    }
}
