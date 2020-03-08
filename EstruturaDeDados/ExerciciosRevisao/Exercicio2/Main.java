package exercicio2;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Scanner keyboard = new Scanner(System.in);

        System.out.println("Type the name: ");
        String name = keyboard.next();

        System.out.println("Type the first semester note: ");
        Double firstSemesterNote = keyboard.nextDouble();

        System.out.println("Type the second semester note: ");
        Double secondSemesterNote = keyboard.nextDouble();

        Student student = new Student(name, firstSemesterNote, secondSemesterNote);

        System.out.println(student.statusStudent());

        keyboard.close();
    }
}
