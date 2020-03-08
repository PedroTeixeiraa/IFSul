package exercicio3;

public class Circle {

    private Double radius;

    public Circle(Double radius) {
        this.radius = radius;
    }

    public Double perimeter() {
        return 2 * Math.PI * radius;
    }

    public Double area() {
        return Math.PI * radius * radius;
    }

    public Double getRadius() {
        return radius;
    }

    public void setRadius(Double radius) {
        this.radius = radius;
    }
}
