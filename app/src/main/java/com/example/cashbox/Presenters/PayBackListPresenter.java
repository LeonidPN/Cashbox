package com.example.cashbox.Presenters;

import android.database.Cursor;

import com.example.cashbox.Models.Check;
import com.example.cashbox.Models.CheckPayBack;
import com.example.cashbox.Models.CheckPayBackTable;
import com.example.cashbox.Models.CheckTable;
import com.example.cashbox.Models.DbHelper;
import com.example.cashbox.Views.PayBackListAdapter;
import com.example.cashbox.Views.PaymentListAdapter;

import java.util.ArrayList;
import java.util.List;

public class PayBackListPresenter {

    private PayBackListAdapter.PayBackListViewHolder holder;
    private int position;
    private DbHelper dbHelper;

    public PayBackListPresenter(PayBackListAdapter.PayBackListViewHolder holder, int position) {
        this.holder = holder;
        this.position = position;
        dbHelper = new DbHelper(holder.itemView.getContext());
    }

    private CheckPayBack getElement(int position) {
        Cursor c = dbHelper.getReadableDatabase().query(CheckPayBackTable.TABLE, null, null, null, null, null, null);
        CheckPayBack checkPayBack = new CheckPayBack();
        int idColIndex = c.getColumnIndex(CheckPayBackTable.COLUMN.ID);
        int sumColIndex = c.getColumnIndex(CheckPayBackTable.COLUMN.SUM);
        int numberColIndex = c.getColumnIndex(CheckPayBackTable.COLUMN.NUMBER);
        int dateColIndex = c.getColumnIndex(CheckPayBackTable.COLUMN.DATE);
        if (c.moveToPosition(position)) {
            checkPayBack = new CheckPayBack(c.getInt(idColIndex), c.getString(sumColIndex), c.getString(numberColIndex),
                    c.getString(dateColIndex));
        }
        c.close();
        return checkPayBack;
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
}
