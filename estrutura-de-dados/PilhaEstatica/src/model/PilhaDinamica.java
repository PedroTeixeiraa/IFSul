import java.util.ArrayList;
import java.util.List;

public class PilhaDinamica {

    private final List<Integer> pilha;
    private int length;
    private Integer top;

    public PilhaDinamica() {
        this.pilha = new ArrayList<Integer>();
        this.length = 0;
    }

    public int getTop() {
        return top;
    }

    public void push(Integer element) {
        this.pilha.add(length, element);
        length++;
        this.top = element;
    }

    public Integer pop() {
        if (!verifyEmpty()) {
            Integer valor = pilha.get(length- 1);
            this.pilha.remove(length-1);
            length--;
            return valor;
        }
        return 0;
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
            result.append(pilha.get(i));
            result.append(", ");
        }
        result.append(pilha.get(length - 1));
        result.append("]");
        return result.toString();
    }

}
