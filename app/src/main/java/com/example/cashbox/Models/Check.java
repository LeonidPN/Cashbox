package com.example.cashbox.Models;

public class Check {

    private int id;
    private String name;
    private String price;
    private String count;
    private String article;

    public Check() {}

    public Check(int id, String name, String price, String count, String article) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.count = count;
        this.article = article;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public String getArticle() {
        return article;
    }

    public void setArticle(String article) {
        this.article = article;
    }
}
