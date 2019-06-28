package com.example.cashbox.Models;

public class ProductTable {

    public static final String TABLE = "products";

    public static class COLUMN {
        public static final String ID = "_id";
        public static final String NAME = "name";
        public static final String PRICE = "price";
        public static final String COUNT = "count";
        public static final String ARTICLE = "article";
    }

    public static final String CREATE_SCRIPT =
            String.format("create table %s ("
                            + "%s integer primary key autoincrement,"
                            + "%s text,"
                            + "%s text,"
                            + "%s text,"
                            + "%s text" + ");",
                    TABLE, COLUMN.ID, COLUMN.NAME, COLUMN.PRICE, COLUMN.COUNT, COLUMN.ARTICLE);

}
