package com.example.cashbox.Views;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

import com.example.cashbox.Presenters.CorrectionPresenter;
import com.example.cashbox.R;

public class CorrectionActivity extends AppCompatActivity {

    private Button buttonChooseDate;
    private Button buttonRes;

    private CorrectionPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_correction);
        presenter = new CorrectionPresenter(this);
        presenter.initialize();
        buttonChooseDate = findViewById(R.id.buttonChooseDate);
        buttonChooseDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                presenter.setDate();
            }
        });
        buttonRes = findViewById(R.id.buttonRes);
        buttonRes.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                presenter.correction();
            }
        });
    }


    @Override
    protected void onDestroy(){
        super.onDestroy();
        presenter.destroy();
    }
}
