package br.com.jpa.domain;

import javax.persistence.*;
import java.util.Calendar;

@Table
@Entity
public class Pedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CodPedido")
    private int codPedido;

    @Temporal(TemporalType.DATE)
    @Column(name = "PrazoEntrega", nullable = false)
    private Calendar prazoEntrega;

    @Temporal(TemporalType.DATE)
    @Column(name = "DataPedido", nullable = false)
    private Calendar dataPedido;

    @ManyToOne
    @JoinColumn(name="CodCliente", nullable = false)
    private Cliente cliente;

    @ManyToOne
    @JoinColumn(name="CodVendedor", nullable = false)
    private Vendedor vendedor;

    public Pedido(int codPedido, Calendar prazoEntrega, Calendar dataPedido, Cliente cliente, Vendedor vendedor) {
        this.codPedido = codPedido;
        this.prazoEntrega = prazoEntrega;
        this.dataPedido = dataPedido;
        this.cliente = cliente;
        this.vendedor = vendedor;
    }

    public Pedido() {}

    public int getCodPedido() {
        return codPedido;
    }

    public void setCodPedido(int codPedido) {
        this.codPedido = codPedido;
    }

    public Calendar getPrazoEntrega() {
        return prazoEntrega;
    }

    public void setPrazoEntrega(Calendar prazoEntrega) {
        this.prazoEntrega = prazoEntrega;
    }

    public Calendar getDataPedido() {
        return dataPedido;
    }

    public void setDataPedido(Calendar dataPedido) {
        this.dataPedido = dataPedido;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Vendedor getVendedor() {
        return vendedor;
    }

    public void setVendedor(Vendedor vendedor) {
        this.vendedor = vendedor;
    }
}
