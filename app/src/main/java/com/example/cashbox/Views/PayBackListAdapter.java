package com.example.cashbox.Views;

import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.example.cashbox.Models.Check;
import com.example.cashbox.Models.CheckPayBack;
import com.example.cashbox.Presenters.PayBackListPresenter;
import com.example.cashbox.Presenters.PayBackPresenter;
import com.example.cashbox.Presenters.PaymentListPresenter;
import com.example.cashbox.Presenters.PaymentPresenter;
import com.example.cashbox.R;

import java.util.List;

public class PayBackListAdapter extends RecyclerView.Adapter<PayBackListAdapter.PayBackListViewHolder> {

    public List<CheckPayBack> checkList;
    private PayBackPresenter presenter;

    public static class PayBackListViewHolder extends RecyclerView.ViewHolder {
        private View view;

        public PayBackListViewHolder(View v) {
            super(v);
            view = v;
        }
    }

    public PayBackListAdapter(List<CheckPayBack> checkList, PayBackPresenter presenter) {
        this.checkList = checkList;
        this.presenter = presenter;
    }

    @Override
    public PayBackListAdapter.PayBackListViewHolder onCreateViewHolder(ViewGroup parent, int type) {
        View v = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_payback_list, parent, false);
        PayBackListAdapter.PayBackListViewHolder holder = new PayBackListAdapter.PayBackListViewHolder(v);
        return holder;
    }

    @Override
    public void onBindViewHolder(final PayBackListAdapter.PayBackListViewHolder holder, final int position) {
        final CheckPayBack check = checkList.get(position);
        ((TextView) holder.view.findViewById(R.id.textViewDocNum)).setText(check.getNumber());
        ((TextView) holder.view.findViewById(R.id.textViewSum)).setText(check.getSum());
        ((TextView) holder.view.findViewById(R.id.textViewDate)).setText(check.getDate());
        holder.view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                presenter.setPosition(position);
            }
        });
        if(position==presenter.getPosition()){
            holder.view.findViewById(R.id.linearLayout).setBackgroundColor(Color.argb(20,0,188,212));
        }else{
            holder.view.findViewById(R.id.linearLayout).setBackgroundColor(Color.argb(20,255,255,255));
        }
    }

    @Override
    public int getItemCount() {
        return checkList.size();
    }

}
