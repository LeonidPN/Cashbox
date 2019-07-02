package com.example.cashbox.Views;

import androidx.appcompat.app.AppCompatActivity;

import android.app.DatePickerDialog;
import android.os.Bundle;
import android.text.format.DateUtils;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.Spinner;
import android.widget.TextView;

import com.example.cashbox.Presenters.CorrectionPresenter;
import com.example.cashbox.Presenters.PaymentPresenter;
import com.example.cashbox.R;

import java.util.Calendar;

public class CorrectionActivity extends AppCompatActivity {

    private Button buttonChooseDate;
    private Button buttonRes;
    private Spinner spinner;
    TextView textDate;
    Calendar date = Calendar.getInstance();

    private CorrectionPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_correction);
        presenter = new CorrectionPresenter(this);
        presenter.initialize();
        textDate=(TextView)findViewById(R.id.textDate);
        setInitialDate();
        buttonChooseDate = (Button) findViewById(R.id.buttonChooseDate);
        buttonChooseDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setDate(v);
            }
        });
        buttonRes = (Button) findViewById(R.id.buttonRes);
        buttonRes.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                presenter.correction();
            }
        });
    }


    public void setDate(View v) {
        new DatePickerDialog(CorrectionActivity.this, d,
                date.get(Calendar.YEAR),
                date.get(Calendar.MONTH),
                date.get(Calendar.DAY_OF_MONTH))
                .show();
    }

    private void setInitialDate() {

        textDate.setText(DateUtils.formatDateTime(this,
                date.getTimeInMillis(),
                DateUtils.FORMAT_SHOW_DATE | DateUtils.FORMAT_SHOW_YEAR
                        ));
    }

    DatePickerDialog.OnDateSetListener d=new DatePickerDialog.OnDateSetListener() {
        public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
            date.set(Calendar.YEAR, year);
            date.set(Calendar.MONTH, monthOfYear);
            date.set(Calendar.DAY_OF_MONTH, dayOfMonth);
            setInitialDate();
        }
    };

    @Override
    protected void onDestroy(){
        super.onDestroy();
        presenter.destroy();
    }
}
