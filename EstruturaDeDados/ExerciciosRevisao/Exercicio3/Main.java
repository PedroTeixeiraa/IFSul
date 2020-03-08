package exercicio3;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Scanner keyboard = new Scanner(System.in);

        System.out.println("Type the radius: ");
        Double radius = keyboard.nextDouble();

        Circle circle = new Circle(radius);

        System.out.println("AREA: " + circle.area());
        System.out.println("PERIMETER: " + circle.perimeter());

        keyboard.close();
    }
}
