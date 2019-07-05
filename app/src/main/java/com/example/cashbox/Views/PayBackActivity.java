package com.example.cashbox.Views;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.example.cashbox.Presenters.PayBackPresenter;
import com.example.cashbox.R;

public class PayBackActivity extends AppCompatActivity {

    private Button buttonPay;
    private Button buttonCancel;
    private RecyclerView recyclerView;

    private PayBackPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pay_back);

        presenter = new PayBackPresenter(this);
        presenter.initialize();

        recyclerView = findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(new PayBackListAdapter(presenter.getCheckPayBackList(), presenter));

        buttonPay = (Button) findViewById(R.id.buttonPayBack);
        buttonPay.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                presenter.payBack();
            }
        });
        buttonCancel = (Button) findViewById(R.id.buttonCancel);
        buttonCancel.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                presenter.cancel();
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        presenter.destroy();
    }
}
