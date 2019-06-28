package com.example.cashbox.Models;

public class Product {

    private int id;
    private String name;
    private double price;
    private int count;
    private String article;

    public Product(int id, String name, double price, int count, String article) {
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getArticle() {
        return article;
    }

    public void setArticle(String article) {
        this.article = article;
    }
}
