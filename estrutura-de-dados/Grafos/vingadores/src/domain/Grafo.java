package domain;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class Grafo<Object> {

    private List<Aresta<Object>> arestas;

    private List<Vertice<Object>> vertices;

    public Grafo() {
        arestas = new ArrayList<>();
        vertices = new ArrayList<>();
    }

    public List<Aresta<Object>> getArestas() {
        return arestas;
    }

    public void setArestas(List<Aresta<Object>> arestas) {
        this.arestas = arestas;
    }

    public List<Vertice<Object>> getVertices() {
        return vertices;
    }

    public void setVertices(List<Vertice<Object>> vertices) {
        this.vertices = vertices;
    }

    public void adicionarVertice(Object elemento) {
        Vertice<Object> novoVertice = new Vertice<>(elemento);
        this.vertices.add(novoVertice);
    }

    public void adicionarAresta(Double peso, Object elementoInicio, Object elementoFim) {
        Vertice<Object> inicio = this.getVertice(elementoInicio);
        Vertice<Object> fim = this.getVertice(elementoFim);
        Aresta<Object> aresta = new Aresta<>(peso, inicio, fim);
        inicio.adicionarArestaSaida(aresta);
        fim.adicionarArestaEntrada(aresta);
        this.arestas.add(aresta);
    }

    public Vertice<Object> getVertice(Object elemento) {
        Optional<Vertice<Object>> optionalVertice = this.vertices
                .stream()
                .filter(vertice -> vertice.getElemento().equals(elemento))
                .findFirst();

        return optionalVertice.orElse(null);
    }

    public void buscaEmLargura() {
        List<Vertice<Object>> marcados = new ArrayList<>();
        List<Vertice<Object>> filaPendentes = new ArrayList<>();

        Vertice<Object> atual = this.vertices.get(0);
        marcados.add(atual);

        System.out.println(atual.getElemento());
        filaPendentes.add(atual);

        while (filaPendentes.size() > 0) {
            Vertice<Object> visitado = filaPendentes.get(0);
            for (int i = 0; i < visitado.getArestasSaida().size(); i++) {
                Vertice<Object> proximo = visitado.getArestasSaida().get(i).getFim();
                if (!marcados.contains(proximo)) {
                    marcados.add(proximo);
                    System.out.println(proximo.getElemento());
                    filaPendentes.add(proximo);
                }
            }
            filaPendentes.remove(0);
        }
    }

    public void curtida(Object elementoCurtidor, Object elementoCurtido) {
        Vertice<Object> inicio = this.getVertice(elementoCurtidor);
        Vertice<Object> fim = this.getVertice(elementoCurtido);

        if (!inicio.getArestasSaida().isEmpty()) {
            Optional<Aresta<Object>> arestaCurtida = inicio.getArestasSaida()
                    .stream()
                    .filter(arestaSaida -> arestaSaida.getInicio().getElemento().equals(inicio.getElemento())
                            && arestaSaida.getFim().getElemento().equals(fim.getElemento()))
                    .findFirst();

            arestaCurtida.ifPresent(this::curtir);
        }
    }

    private void curtir(Aresta<Object> aresta) {
        Double peso = aresta.getPeso();
        aresta.setPeso(peso + 1);
    }

    public void imprimirVertices(List<Vertice<Object>> vertices) {
        for (Vertice<Object> vertice: vertices) {
            System.out.println(vertice);
        }
    }

    public void imprimirArestas(List<Aresta<Object>> arestas) {
        for (Aresta<Object> aresta: arestas) {
            System.out.println(aresta);
        }
    }
}
