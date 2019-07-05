package com.example.cashbox.Models;

public class CheckPayBackTable {

    public static final String TABLE = "checkPayBackTable";

    public static class COLUMN {
        public static final String ID = "id";
        public static final String SUM = "sum";
        public static final String NUMBER = "number";
        public static final String DATE = "date";
    }

    public static final String CREATE_SCRIPT =
            String.format("create table %s ("
                            + "%s integer primary key autoincrement,"
                            + "%s text,"
                            + "%s text,"
                            + "%s text" + ");",
                    TABLE, COLUMN.ID, COLUMN.SUM, COLUMN.NUMBER, COLUMN.DATE);

}
