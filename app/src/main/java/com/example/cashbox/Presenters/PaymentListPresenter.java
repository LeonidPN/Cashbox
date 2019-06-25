package com.example.cashbox.Presenters;

import android.view.View;
import android.widget.TextView;

import com.example.cashbox.R;
import com.example.cashbox.Views.PaymentListAdapter;

public class PaymentListPresenter {

    private PaymentListAdapter.PaymentListViewHolder holder;

    public PaymentListPresenter(PaymentListAdapter.PaymentListViewHolder holder){
        this.holder=holder;
    }

    public void plus(){
        View v=holder.itemView;
        int count=Integer.parseInt(((TextView)v.findViewById(R.id.editTextCount)).getText().toString());
        if(count<1000000){
            count++;
            ((TextView)v.findViewById(R.id.editTextCount)).setText(count+"");
        }
    }

    public void minus(){
        View v=holder.itemView;
        int count=Integer.parseInt(((TextView)v.findViewById(R.id.editTextCount)).getText().toString());
        if(count>0){
            count--;
            ((TextView)v.findViewById(R.id.editTextCount)).setText(count+"");
        }
    }

}
