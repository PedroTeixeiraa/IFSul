package domain;

import java.util.ArrayList;
import java.util.List;

public class FilaDinamica {

    private Celula primeiroElemento;
    private List<Celula> fila;

    public FilaDinamica() {
        this.fila = new ArrayList<>();
        this.primeiroElemento = null;
    }

    public void push(Object element) {
        if (fila.isEmpty()) {
            this.primeiroElemento = new Celula(element);
        }
        this.fila.add(new Celula(element));
    }

    public void pop() {
       if (fila.isEmpty()) {
           throw new RuntimeException("Fila vazia!");
       }
       this.fila.remove(0);

       this.primeiroElemento = this.fila.isEmpty() ? null : this.fila.get(0);
    }

    @Override
    public String toString() {
        return "FilaDinamica{" +
                "primeiroElemento=" + primeiroElemento +
                ", fila=" + fila +
                '}';
    }

    public Celula getPrimeiroElemento() {
        return primeiroElemento;
    }

    public void setPrimeiroElemento(Celula primeiroElemento) {
        this.primeiroElemento = primeiroElemento;
    }

    public List<Celula> getFila() {
        return fila;
    }

    public void setFila(List<Celula> fila) {
        this.fila = fila;
    }
}


