import domain.Arvore;

public class Main {

    public static void main(String[] args) {

        Arvore arvD = new Arvore('D', null, null);
        Arvore arvB = new Arvore('B', null, arvD);

        Arvore arvE = new Arvore("E", null, null);
        Arvore arvF = new Arvore("F", null, null);
        Arvore arvC = new Arvore("C", arvE, arvF);

        Arvore raiz = new Arvore("A", arvB, arvC);

        System.out.println("Before Order: ");
        Arvore.printBeforeOrder(raiz);
        System.out.println();
        System.out.println("Symmetric Order: ");
        Arvore.printSymmetricOrder(raiz);
        System.out.println();
        System.out.println("After Order: ");
        Arvore.printAfterOrder(raiz);
        System.out.println();

        System.out.print("Height: ");
        System.out.print(Arvore.height(raiz));
        System.out.println();

        System.out.print("Nodes: ");
        System.out.print(Arvore.quantity(raiz));
    }

}
