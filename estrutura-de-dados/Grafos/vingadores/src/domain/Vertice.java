package domain;

import java.util.ArrayList;
import java.util.List;

public class Vertice<Object> {

    private Object elemento;

    private List<Aresta<Object>> arestasEntrada;

    private List<Aresta<Object>> arestasSaida;

    public Vertice(Object elemento) {
        this.elemento = elemento;
        this.arestasEntrada = new ArrayList<Aresta<Object>>();
        this.arestasSaida = new ArrayList<Aresta<Object>>();
    }

    public Object getElemento() {
        return elemento;
    }

    public void setElemento(Object elemento) {
        this.elemento = elemento;
    }

    public List<Aresta<Object>> getArestasEntrada() {
        return arestasEntrada;
    }

    public void setArestasEntrada(List<Aresta<Object>> arestasEntrada) {
        this.arestasEntrada = arestasEntrada;
    }

    public List<Aresta<Object>> getArestasSaida() {
        return arestasSaida;
    }

    public void setArestasSaida(List<Aresta<Object>> arestasSaida) {
        this.arestasSaida = arestasSaida;
    }

    public void adicionarArestaEntrada(Aresta<Object> aresta) {
        this.arestasEntrada.add(aresta);
    }

    public void adicionarArestaSaida(Aresta<Object> aresta) {
        this.arestasSaida.add(aresta);
    }

    @Override
    public String toString() {
        return "Vertice [elemento=" + elemento + "]";
    }
}
