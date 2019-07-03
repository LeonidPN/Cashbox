package com.example.cashbox.Presenters;

import android.content.ContentValues;
import android.database.Cursor;
import android.view.View;
import android.widget.TextView;

import com.example.cashbox.Models.Check;
import com.example.cashbox.Models.CheckTable;
import com.example.cashbox.Models.DbHelper;
import com.example.cashbox.R;
import com.example.cashbox.Views.PaymentListAdapter;

import java.util.ArrayList;
import java.util.List;

public class PaymentListPresenter {

    private PaymentListAdapter.PaymentListViewHolder holder;
    private int position;
    private DbHelper dbHelper;

    public PaymentListPresenter(PaymentListAdapter.PaymentListViewHolder holder, int position) {
        this.holder = holder;
        this.position = position;
        dbHelper = new DbHelper(holder.itemView.getContext());
    }

    public void plus() {
        Check check = getElement(position);
        View v = holder.itemView;
        int count = Integer.parseInt(check.getCount());
        if (count < 1000000) {
            check.setCount((count + 1) + "");
            ((TextView) v.findViewById(R.id.editTextCount)).setText(check.getCount());
            ContentValues cv = new ContentValues(4);
            cv.put(CheckTable.COLUMN.NAME, check.getName());
            cv.put(CheckTable.COLUMN.PRICE, check.getPrice());
            cv.put(CheckTable.COLUMN.COUNT, check.getCount());
            cv.put(CheckTable.COLUMN.ARTICLE, check.getArticle());
            dbHelper.getWritableDatabase().update(CheckTable.TABLE, cv, CheckTable.COLUMN.ID + "=" + check.getId(), null);
            List<Check> checkList = getList();
            int sum = 0;
            for (int i = 0; i < checkList.size(); i++) {
                sum += Integer.parseInt(checkList.get(i).getPrice()) * Integer.parseInt(checkList.get(i).getCount());
            }
            ((TextView) v.getRootView().findViewById(R.id.textViewSum)).setText(sum + "");
        }
    }

    public void minus() {
        Check check = getElement(position);
        View v = holder.itemView;
        int count = Integer.parseInt(check.getCount());
        if (count > 1) {
            check.setCount((count - 1) + "");
            ((TextView) v.findViewById(R.id.editTextCount)).setText(check.getCount());
            ContentValues cv = new ContentValues(4);
            cv.put(CheckTable.COLUMN.NAME, check.getName());
            cv.put(CheckTable.COLUMN.PRICE, check.getPrice());
            cv.put(CheckTable.COLUMN.COUNT, check.getCount());
            cv.put(CheckTable.COLUMN.ARTICLE, check.getArticle());
            dbHelper.getWritableDatabase().update(CheckTable.TABLE, cv, CheckTable.COLUMN.ID + "=" + check.getId(), null);
            List<Check> checkList = getList();
            int sum = 0;
            for (int i = 0; i < checkList.size(); i++) {
                sum += Integer.parseInt(checkList.get(i).getPrice()) * Integer.parseInt(checkList.get(i).getCount());
            }
            ((TextView) v.getRootView().findViewById(R.id.textViewSum)).setText(sum + "");
        }
    }

    private Check getElement(int position) {
        Cursor c = dbHelper.getReadableDatabase().query(CheckTable.TABLE, null, null, null, null, null, null);
        Check check = new Check();
        int idColIndex = c.getColumnIndex(CheckTable.COLUMN.ID);
        int nameColIndex = c.getColumnIndex(CheckTable.COLUMN.NAME);
        int priceColIndex = c.getColumnIndex(CheckTable.COLUMN.PRICE);
        int countColIndex = c.getColumnIndex(CheckTable.COLUMN.COUNT);
        int articleColIndex = c.getColumnIndex(CheckTable.COLUMN.ARTICLE);
        if (c.moveToPosition(position)) {
            check = new Check(c.getInt(idColIndex), c.getString(nameColIndex), c.getString(priceColIndex),
                    c.getString(countColIndex), c.getString(articleColIndex));
        }
        c.close();
        return check;
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
