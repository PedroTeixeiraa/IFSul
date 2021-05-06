package domain;

public class Celula {

    private Object elemento;

    public Celula(Object elemento) {
        this.elemento = elemento;
    }

    public Object getElemento() {
        return elemento;
    }

    public void setElemento(Object elemento) {
        this.elemento = elemento;
    }

    @Override
    public String toString() {
        return elemento.toString();
    }
}
