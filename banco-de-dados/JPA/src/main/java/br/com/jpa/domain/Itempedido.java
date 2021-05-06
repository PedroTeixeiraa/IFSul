package br.com.jpa.domain;

import javax.persistence.*;

@Table
@Entity
public class Itempedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CodItemPedido")
    private int codItemPedido;

    @ManyToOne
    @JoinColumn(name="CodPedido", nullable = false)
    private Pedido pedido;

    @ManyToOne
    @JoinColumn(name="CodProduto", nullable = false)
    private Produto produto;

    @Column(name = "Quantidade", nullable = false)
    private int quantidade;

    public Itempedido() {}

    public Itempedido(int codItemPedido, Pedido pedido, Produto produto, int quantidade) {
        this.codItemPedido = codItemPedido;
        this.pedido = pedido;
        this.produto = produto;
        this.quantidade = quantidade;
    }

    public int getCodItemPedido() {
        return codItemPedido;
    }

    public void setCodItemPedido(int codItemPedido) {
        this.codItemPedido = codItemPedido;
    }

    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }
}
