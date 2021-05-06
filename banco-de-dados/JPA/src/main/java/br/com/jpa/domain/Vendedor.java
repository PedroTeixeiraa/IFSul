package br.com.jpa.domain;

import javax.persistence.*;
import java.math.BigDecimal;

@Table
@Entity
public class Vendedor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CodVendedor"    )
    private int codVendedor;

    @Column(name = "Nome", nullable = false)
    private String nome;

    @Column(name = "SalarioFixo", nullable = false)
    private BigDecimal salarioFixo;

    @Column(name = "FaixaComissao", columnDefinition="ENUM('A','B','C','D')", nullable = false)
    @Enumerated(EnumType.STRING)
    private FaixaComissao faixaComissao;

    public Vendedor(int codVendedor, String nome, BigDecimal salarioFixo, FaixaComissao faixaComissao) {
        this.codVendedor = codVendedor;
        this.nome = nome;
        this.salarioFixo = salarioFixo;
        this.faixaComissao = faixaComissao;
    }

    public Vendedor() {}

    public int getCodVendedor() {
        return codVendedor;
    }

    public void setCodVendedor(int codVendedor) {
        this.codVendedor = codVendedor;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public BigDecimal getSalarioFixo() {
        return salarioFixo;
    }

    public void setSalarioFixo(BigDecimal salarioFixo) {
        this.salarioFixo = salarioFixo;
    }

    public FaixaComissao getFaixaComissao() {
        return faixaComissao;
    }

    public void setFaixaComissao(FaixaComissao faixaComissao) {
        this.faixaComissao = faixaComissao;
    }
}
