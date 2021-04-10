package exercicio1;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Scanner keyboard = new Scanner(System.in);

        System.out.println("Type the width: ");
        Double width = keyboard.nextDouble();

        System.out.println("Type the height: ");
        Double height = keyboard.nextDouble();

        Rectangle rectangle = new Rectangle(width, height);

        System.out.println("PERIMETER: " + rectangle.perimeter());
        System.out.println("AREA: " + rectangle.area());
        System.out.println("DIAGONAL: " + rectangle.diagonal());

        keyboard.close();
    }
}
