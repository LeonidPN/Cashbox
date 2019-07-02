package com.example.cashbox.Views;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

import com.example.cashbox.Presenters.MainPresenter;
import com.example.cashbox.R;

public class MainActivity extends AppCompatActivity {

    private Button buttonOpenShift;
    private Button buttonCloseShift;
    private Button buttonPay;
    private Button buttonPayBack;
    private Button buttonCheckCor;
    private MainPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        presenter=new MainPresenter(this);
        presenter.initialize();

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
        buttonCheckCor = (Button) findViewById(R.id.buttonCheckCor);
        buttonCheckCor.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                presenter.openView(CorrectionActivity.class, false);
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

    @Override
    protected void onDestroy(){
        super.onDestroy();
        presenter.destroy();
    }

    @Override
    protected void onPause() {
        super.onPause();
        presenter.pause();
    }

    @Override
    protected void onResume() {
        super.onResume();
        presenter.resume();
    }
}
