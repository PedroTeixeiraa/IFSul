public class PilhaEstatica {

    private final int[] pilha;
    private int length;
    private int top;

    public PilhaEstatica(int range) {
        this.pilha = new int[range];
        this.length = 0;
    }

    public int getTop() {
        return top;
    }

    public void push(int element) {
        if (!verifyFull()) {
            this.pilha[length] = element;
            length++;
            this.top = element;
        }
    }

    public void pop() {
        if (!verifyEmpty()) {
            this.pilha[length - 1] = 0;
            length--;
            if (!verifyEmpty()) {
                this.top = pilha[length - 1];
            }
        }
    }

    public boolean verifyFull() {
        return length == pilha.length;
    }

    public boolean verifyEmpty() {
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
