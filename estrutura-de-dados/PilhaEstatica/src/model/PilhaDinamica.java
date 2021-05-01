package model;

import java.util.ArrayList;
import java.util.List;

public class PilhaDinamica {

    private final List<Integer> pilha;
    private int length;
    private Integer topo;

    public PilhaDinamica() {
        this.pilha = new ArrayList<>();
        this.length = 0;
    }

    public int getTopo() {
        return topo;
    }

    public void push(Integer element) {
        this.pilha.add(element);
        length++;
        this.topo = element;
    }

    public Integer pop() {
        if (!isEmpty()) {
            Integer valor = pilha.get(length - 1);
            this.pilha.remove(length-1);
            length--;
            if (!isEmpty()) {
                this.topo = pilha.get(length - 1);
            }
            return valor;
        }
        return 0;
    }

    public boolean isEmpty() {
        return length == 0;
    }

    @Override
    public String toString() {
        StringBuilder result = new StringBuilder();

        if (length == 0) {
            return "[]";
        }

        result.append("[");
        for (int i = 0; i < length - 1; i++) {
            result.append(pilha.get(i));
            result.append(", ");
        }
        result.append(pilha.get(length - 1));
        result.append("]");
        return result.toString();
    }

}
