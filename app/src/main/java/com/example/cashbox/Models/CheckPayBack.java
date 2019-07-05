package com.example.cashbox.Models;

import java.util.Date;

public class CheckPayBack {
    private int id;
    private String sum;
    private String number;
    private String date;

    public CheckPayBack(){}

    public CheckPayBack(int id, String sum, String number, String date) {
        this.id = id;
        this.sum = sum;
        this.number = number;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSum() {
        return sum;
    }

    public void setSum(String sum) {
        this.sum = sum;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
