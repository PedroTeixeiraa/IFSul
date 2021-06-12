import domain.Grafo;

public class Main {

    public static void main(String[] args) {
        Grafo<String> grafo = new Grafo<>();

        grafo.adicionarVertice("Thor");
        grafo.adicionarVertice("Capitão América");
        grafo.adicionarVertice("Viúva Negra");
        grafo.adicionarVertice("Hulk");
        grafo.adicionarVertice("Homem de Ferro");

        grafo.adicionarAresta(2.0, "Thor", "Capitão América");
        grafo.adicionarAresta(3.0, "Capitão América", "Hulk");
        grafo.adicionarAresta(1.0, "Hulk", "Viúva Negra");
        grafo.adicionarAresta(1.0, "Thor", "Viúva Negra");
        grafo.adicionarAresta(2.0, "Homem de Ferro", "Capitão América");
        grafo.adicionarAresta(3.0, "Homem de Ferro", "Thor");

        grafo.buscaEmLargura();

        grafo.curtida("Thor", "Capitão América");

        grafo.imprimirVertices(grafo.getVertices());
        grafo.imprimirArestas(grafo.getArestas());
    }
}
