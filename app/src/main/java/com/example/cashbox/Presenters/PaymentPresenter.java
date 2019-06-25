package com.example.cashbox.Presenters;

import android.database.Cursor;

import com.example.cashbox.Models.DbHelper;
import com.example.cashbox.Models.Product;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import com.example.cashbox.R;
import com.example.cashbox.Views.PaymentActivity;

import java.util.ArrayList;
import java.util.List;

public class PaymentPresenter {

    private PaymentActivity view;
    private List<Product> products;
    private DbHelper dbHelper;

    public PaymentPresenter(PaymentActivity view) {
        this.view = view;
        products=new ArrayList<>();
        /*dbHelper=new DbHelper(view);
        Cursor cursor=dbHelper.getReadableDatabase().query(ProductTable.TABLE, null,
                null,null,null,null,null);
        while (cursor.moveToNext()) {
            Product product = new Product(cursor.getInt(cursor.getColumnIndex(ProductTable.COLUMN.ID)),
                    cursor.getString(cursor.getColumnIndex(ProductTable.COLUMN.NAME)),
                    cursor.getDouble(cursor.getColumnIndex(ProductTable.COLUMN.PRICE)));
            products.add(product);
        }
        cursor.close();*/
        products.add(new Product(1,"1",100));
        products.add(new Product(2,"2",1000));
        products.add(new Product(3,"3",10000));
    }

    public void add() {


    }

    public void pay() {

    }

    public void payBack() {

    }

    public List<Product> getProducts() {
        return products;
    }
}
