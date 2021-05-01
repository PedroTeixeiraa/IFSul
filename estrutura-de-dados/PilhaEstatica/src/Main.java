import model.PilhaDinamica;
import model.PilhaEstatica;

public class Main {

    public static void main(String[] args) {

        System.out.println("Pilha Estática");

        PilhaEstatica pe = new PilhaEstatica(10);

        System.out.println("Vazia " + pe.isEmpty());
        pe.push(10);
        pe.push(8);
        pe.push(5);
        pe.push(2);
        pe.pop();
        System.out.println("Cheia " + pe.isFull());

        System.out.println("Topo " + pe.getTopo());
        System.out.println(pe);

        System.out.println("Pilha Dinâmica");

        PilhaDinamica pd = new PilhaDinamica();
        pd.push(10);
        pd.push(8);
        pd.push(5);
        pd.push(2);
        pd.push(5);
        pd.pop();

        System.out.println("Vazia " + pd.isEmpty());
        System.out.println("Topo " + pd.getTopo());
        System.out.println(pd);

        System.out.println("Exercício Atividade 1");

        PilhaDinamica pd1 = new PilhaDinamica();
        PilhaDinamica pd2 = new PilhaDinamica();
        PilhaDinamica pd3 = new PilhaDinamica();

        pd1.push(2);
        pd1.push(5);
        pd1.push(8);
        pd1.push(7);
        pd1.push(1);

        pd2.push(pd1.pop());
        pd3.push(pd2.pop());

        pd2.push(pd1.pop());
        pd2.push(pd1.pop());
        pd2.push(pd1.pop());
        pd2.push(pd1.pop());

        pd3.push(pd2.pop());
        pd3.push(pd2.pop());

        pd1.push(pd2.pop());

        pd3.push(pd2.pop());

        pd2.push(pd1.pop());
        pd3.push(pd2.pop());


        System.out.println("Resultado:");
        System.out.println(pd3);
    }

}
