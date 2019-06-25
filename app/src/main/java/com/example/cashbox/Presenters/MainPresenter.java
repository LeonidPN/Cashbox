package com.example.cashbox.Presenters;

import android.content.Intent;

import com.example.cashbox.Views.MainActivity;

public class MainPresenter {

    private MainActivity view;

    public MainPresenter(MainActivity view){
        this.view=view;
    }

    public void openView(Class c, boolean isPayBack){
        Intent intent = new Intent(view, c);
        intent.putExtra("IS_PAY_BACK", isPayBack);
        view.startActivity(intent);
    }

    public  void openShift(){

    }

    public  void closeShift(){

    }

}
