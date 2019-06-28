package com.example.cashbox.Views;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.cashbox.Presenters.PaymentPresenter;
import com.example.cashbox.R;

public class PaymentActivity extends AppCompatActivity {

    private Button buttonPay;
    private Button buttonAdd;
    private RecyclerView recyclerView;

    private PaymentPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payment);

        presenter = new PaymentPresenter(this);
        presenter.initialize();

        recyclerView = findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(new PaymentListAdapter(presenter.getProducts()));

        boolean isPayBack = getIntent().getBooleanExtra("IS_PAY_BACK", false);
        buttonPay = (Button) findViewById(R.id.buttonPay);
        if (!isPayBack) {
            buttonPay.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {
                    presenter.pay();
                }
            });
        } else {
            buttonPay.setText("Вернуть");
            buttonPay.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {
                    presenter.payBack();
                }
            });
        }
        buttonAdd = (Button) findViewById(R.id.buttonAdd);
        buttonAdd.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                presenter.add();
            }
        });
    }
}
