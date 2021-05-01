import model.PilhaEstatica;

public class Main {

    public static void main(String[] args) {
        PilhaEstatica pilhaEstatica = new PilhaEstatica(10);

        System.out.println("Vazia " + pilhaEstatica.verifyEmpty());
        pilhaEstatica.push(10);
        pilhaEstatica.push(8);
        pilhaEstatica.push(5);
        pilhaEstatica.push(2);
        pilhaEstatica.pop();
        System.out.println("Cheia " + pilhaEstatica.verifyFull());

        System.out.println("Topo " + pilhaEstatica.elementoTopo());
        System.out.println(pilhaEstatica);

        ////// testes da atividade 1

        PilhaEstatica pilhaEstatica1 = new PilhaEstatica(5);
        PilhaEstatica pilhaEstatica2 = new PilhaEstatica(5);
        PilhaEstatica pilhaEstatica3 = new PilhaEstatica(5);

        pilhaEstatica1.push(2);
        pilhaEstatica1.push(5);
        pilhaEstatica1.push(8);
        pilhaEstatica1.push(7);
        pilhaEstatica1.push(1);

        pilhaEstatica2.push(pilhaEstatica1.pop());
        pilhaEstatica3.push(pilhaEstatica2.pop());

        pilhaEstatica2.push(pilhaEstatica1.pop());
        pilhaEstatica2.push(pilhaEstatica1.pop());
        pilhaEstatica2.push(pilhaEstatica1.pop());
        pilhaEstatica2.push(pilhaEstatica1.pop());

        pilhaEstatica3.push(pilhaEstatica2.pop());
        pilhaEstatica3.push(pilhaEstatica2.pop());

        pilhaEstatica1.push(pilhaEstatica2.pop());

        pilhaEstatica3.push(pilhaEstatica2.pop());

        pilhaEstatica2.push(pilhaEstatica1.pop());
        pilhaEstatica3.push(pilhaEstatica2.pop());


        System.out.println("/////////////////");
        System.out.println(pilhaEstatica3);
    }
}
