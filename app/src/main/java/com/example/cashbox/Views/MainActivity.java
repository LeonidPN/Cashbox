package com.example.cashbox.Views;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.example.cashbox.Presenters.MainPresenter;
import com.example.cashbox.R;

public class MainActivity extends AppCompatActivity {

    private Button buttonOpenShift;
    private Button buttonCloseShift;
    private Button buttonPay;
    private Button buttonPayBack;
    private MainPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        presenter=new MainPresenter(this);

        buttonCloseShift=(Button)findViewById(R.id.buttonCloseShift);
        buttonCloseShift.setOnClickListener(new View.OnClickListener(){

            @Override
            public void onClick(View v) {
                presenter.closeShift();
            }
        });
        buttonOpenShift=(Button)findViewById(R.id.buttonOpenShift);
        buttonOpenShift.setOnClickListener(new View.OnClickListener(){

            @Override
            public void onClick(View v) {
                presenter.openShift();
            }
        });
        buttonPay=(Button)findViewById(R.id.buttonPay);
        buttonPay.setOnClickListener(new View.OnClickListener(){

            @Override
            public void onClick(View v) {
                presenter.openView(PaymentActivity.class, false);
            }
        });
        buttonPayBack=(Button)findViewById(R.id.buttonPayBack);
        buttonPayBack.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                presenter.openView(PaymentActivity.class, true);
            }
        });
    }
}
