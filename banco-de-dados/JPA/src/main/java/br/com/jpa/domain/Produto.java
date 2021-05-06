package br.com.jpa.domain;

import javax.persistence.*;
import java.math.BigDecimal;

@Table
@Entity
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CodProduto")
    private int codProduto;

    @Column(name = "Descricao", nullable = false)
    private String descricao;

    @Column(name = "ValorUnitario", nullable = false)
    private BigDecimal valorUnitario;

    public Produto(int codProduto, String descricao, BigDecimal valorUnitario) {
        this.codProduto = codProduto;
        this.descricao = descricao;
        this.valorUnitario = valorUnitario;
    }

    public Produto() {}

    public int getCodProduto() {
        return codProduto;
    }

    public void setCodProduto(int codProduto) {
        this.codProduto = codProduto;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public BigDecimal getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(BigDecimal valorUnitario) {
        this.valorUnitario = valorUnitario;
    }
}
