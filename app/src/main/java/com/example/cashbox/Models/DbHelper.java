package com.example.cashbox.Models;

import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DbHelper extends SQLiteOpenHelper {

    public static final String NAME = "Cashbox";
    public static final int VERSION = 1;

    public DbHelper(Context context) {
        super(context, NAME, null, VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        sqLiteDatabase.execSQL(ProductTable.CREATE_SCRIPT);
        try {
            ContentValues cv = new ContentValues(2);
            cv.put(ProductTable.COLUMN.NAME, "1");
            cv.put(ProductTable.COLUMN.PRICE, 1000);
            getWritableDatabase().insert(ProductTable.TABLE, null, cv);
            cv = new ContentValues(2);
            cv.put(ProductTable.COLUMN.NAME, "2");
            cv.put(ProductTable.COLUMN.PRICE, 10000);
            getWritableDatabase().insert(ProductTable.TABLE, null, cv);
            cv = new ContentValues(2);
            cv.put(ProductTable.COLUMN.NAME, "3");
            cv.put(ProductTable.COLUMN.PRICE, 100000);
            getWritableDatabase().insert(ProductTable.TABLE, null, cv);
        }
        catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {

    }

}
