package model;

public class PilhaEstatica {

    private final int[] pilha;
    private int length;
    private int topo;

    public PilhaEstatica(int range) {
        this.pilha = new int[range];
        this.length = 0;
    }

    public int getTopo() {
        return topo;
    }

    public void push(int element) {
        if (!isFull()) {
            this.pilha[length] = element;
            length++;
            this.topo = element;
        }
    }

    public void pop() {
        if (!isEmpty()) {
            this.pilha[length - 1] = 0;
            length--;
            if (!isEmpty()) {
                this.topo = pilha[length - 1];
            }
        }
    }

    public boolean isFull() {
        return length == pilha.length;
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
            result.append(pilha[i]);
            result.append(", ");
        }
        result.append(pilha[length - 1]);
        result.append("]");
        return result.toString();
    }
}
