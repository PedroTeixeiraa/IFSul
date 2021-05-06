package br.com.jpa.domain;

import javax.persistence.*;

@Table
@Entity
public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CodCliente", nullable = false)
    private int codCliente;

    @Column(name = "Nome", nullable = false)
    private String nome;

    @Column(name = "Endereco", nullable = false)
    private String endereco;

    @Column(name = "Cidade", nullable = false)
    private String cidade;

    @Column(name = "Cep", nullable = false)
    private String cep;

    @Column(name = "Uf", nullable = false, columnDefinition = "char")
    @Enumerated(EnumType.STRING)
    private Estado uf;

    @Column(name = "Ie", nullable = false)
    private String ie;

    public Cliente(int codCliente, String nome, String endereco, String cidade, String cep, Estado uf, String ie) {
        this.codCliente = codCliente;
        this.nome = nome;
        this.endereco = endereco;
        this.cidade = cidade;
        this.cep = cep;
        this.uf = uf;
        this.ie = ie;
    }

    public Cliente() {}

    public int getCodCliente() {
        return codCliente;
    }

    public void setCodCliente(int codCliente) {
        this.codCliente = codCliente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public Estado getUf() {
        return uf;
    }

    public void setUf(Estado uf) {
        this.uf = uf;
    }

    public String getIe() {
        return ie;
    }

    public void setIe(String ie) {
        this.ie = ie;
    }
}
