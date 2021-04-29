package Atividade1;

import Atividade1.model.Aluno;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

public class Main {

	private static final int MAXIMO_ALUNOS = 2;
	private static final int NOTA_MAXIMA = 10;
	private static final int NOTA_MINIMA = 0;

	public static void main(String[] args) {
		iniciar();
	}

	private static void iniciar() {
		Scanner scanner = new Scanner(System.in);
		List<Aluno> listaAluno = new ArrayList<>(MAXIMO_ALUNOS);

		adicionarAlunos(listaAluno, scanner);
		listarAlunos(listaAluno);
	}

	private static void adicionarAlunos(List<Aluno> listaAluno, Scanner scanner) {
		for (int i = 0; i < MAXIMO_ALUNOS; i++) {
			System.out.printf("Digite uma nota para a posicao %d: ", i);
			double nota = scanner.nextDouble();

			if (isNotaValida(nota)) {
				System.out.printf("Digite o nome do aluno da posicao %d: ", i);
				scanner.nextLine();
				String nome = scanner.nextLine();
				listaAluno.add(new Aluno(nome, nota));
			}
		}
	}

	private static boolean isNotaValida(double nota) {
		return nota > NOTA_MINIMA && nota <= NOTA_MAXIMA;
	}

	private static void listarAlunos(List<Aluno> listaAluno) {
		if (!listaAluno.isEmpty()) {
			for (int i = 0; i < listaAluno.size(); i++) {
				System.out.printf("Nota para %s, da posicao %d: %.1f\n", listaAluno.get(i).getNome(), i, listaAluno.get(i).getNota());
			}
		}
	}

}
