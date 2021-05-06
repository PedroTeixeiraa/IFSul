import domain.Celula;
import domain.FilaDinamica;

public class Main {

    private static final FilaDinamica filaInteiro = new FilaDinamica();
    private static final FilaDinamica filaPar = new FilaDinamica();
    private static final FilaDinamica filaImpar = new FilaDinamica();

    public static void main(String[] args) {
        filaInteiro.push(2);
        filaInteiro.push(4);
        filaInteiro.push(10);
        filaInteiro.push(13);
        filaInteiro.push(11);

        System.out.println("FILA NÚMEROS INTEIROS");
        System.out.println(filaInteiro);

        System.out.println("FILA NÚMEROS ÍMPARES");
        System.out.println(filaImpar);

        System.out.println("FILA NÚMEROS PARES");
        System.out.println(filaPar);

        adicionarElementosFilaParImpar();

        System.out.println("||||||||||||||||||||||||||||||||");

        System.out.println("FILA NÚMEROS INTEIROS ATUALIZADA");
        System.out.println(filaInteiro);

        System.out.println("FILA NÚMEROS ÍMPARES ATUALIZADA");
        System.out.println(filaImpar);

        System.out.println("FILA NÚMEROS PARES ATUALIZADA");
        System.out.println(filaPar);
    }

    private static void adicionarElementosFilaParImpar() {
        filaInteiro.getFila().forEach(celula -> {
            if (isPar(celula)) {
                filaPar.push(celula);
            } else {
                filaImpar.push(celula);
            }
        });
        removerElementosFilaInteiro();
    }

    private static void removerElementosFilaInteiro() {
        int tamanhoFilaInteiro = filaInteiro.getFila().size();
        for (int i = 0; i < tamanhoFilaInteiro; i++) {
            filaInteiro.pop();
        }
    }

    private static boolean isPar(Celula celula) {
        return Integer.parseInt(celula.getElemento().toString()) % 2 == 0;
    }
}
