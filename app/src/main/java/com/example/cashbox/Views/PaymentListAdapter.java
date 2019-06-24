package com.example.cashbox.Views;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.recyclerview.widget.RecyclerView;

import com.example.cashbox.Models.Payment;
import com.example.cashbox.R;

import java.util.List;

public class PaymentListAdapter extends RecyclerView.Adapter<PaymentListAdapter.PaymentListViewHolder> {

    private List<Payment> mpaymentList;

    public static class PaymentListViewHolder extends RecyclerView.ViewHolder {
        private View rssFeedView;

        public PaymentListViewHolder(View v) {
            super(v);
            rssFeedView = v;
        }
    }

    public PaymentListAdapter(List<Payment> paymentList) {
        mpaymentList = paymentList;
    }

    @Override
    public PaymentListViewHolder onCreateViewHolder(ViewGroup parent, int type) {
        View v = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_payment_list, parent, false);
        PaymentListViewHolder holder = new PaymentListViewHolder(v);
        return holder;
    }

    @Override
    public void onBindViewHolder(PaymentListViewHolder holder, int position) {

    }



    @Override
    public int getItemCount() {
        return mpaymentList.size();
    }
}
