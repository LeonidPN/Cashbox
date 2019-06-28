package com.example.cashbox.Views;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.example.cashbox.Models.Product;
import com.example.cashbox.Presenters.PaymentListPresenter;
import com.example.cashbox.Presenters.PaymentPresenter;
import com.example.cashbox.R;

import java.util.List;

public class PaymentListAdapter extends RecyclerView.Adapter<PaymentListAdapter.PaymentListViewHolder> {

    private List<Product> mpaymentList;
    private PaymentPresenter presenter;

    public static class PaymentListViewHolder extends RecyclerView.ViewHolder {
        private View view;

        public PaymentListViewHolder(View v) {
            super(v);
            view = v;
        }
    }

    public PaymentListAdapter(List<Product> productList) {
        mpaymentList = productList;
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
        final Product product = mpaymentList.get(position);
        final PaymentListPresenter presenter=new PaymentListPresenter(holder, product);
        ((TextView)holder.view.findViewById(R.id.editTextName)).setText(product.getName());
        (holder.view.findViewById(R.id.editTextName)).setEnabled(false);
        ((TextView)holder.view.findViewById(R.id.editTextPrice)).setText(product.getPrice()+"");
        (holder.view.findViewById(R.id.editTextPrice)).setEnabled(false);
        ((TextView)holder.view.findViewById(R.id.editTextCount)).setText("1");
        (holder.view.findViewById(R.id.editTextCount)).setEnabled(false);
        holder.view.findViewById(R.id.buttonPlus).setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                presenter.plus();
            }
        });
        holder.view.findViewById(R.id.buttonMinus).setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                presenter.minus();
            }
        });
    }

    @Override
    public int getItemCount() {
        return mpaymentList.size();
    }
}
