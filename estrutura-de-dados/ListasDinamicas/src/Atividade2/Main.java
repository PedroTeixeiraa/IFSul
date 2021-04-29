package Atividade2;

import Atividade1.model.Aluno;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		iniciar();
	}

	private static void iniciar() {
		Scanner scanner = new Scanner(System.in);
		List<Aluno> listaAluno = new ArrayList<>();

		int opcaoMenu;
		do {
			System.out.println("//////////// MENU /////////////");
			System.out.println("///       [1] Adicionar     ///");
			System.out.println("///       [2] Buscar        ///");
			System.out.println("///       [3] Remover       ///");
			System.out.println("///       [4] Imprimir      ///");
			System.out.println("///       [0] Sair          ///");
			System.out.println("///////////////////////////////");
			System.out.print("Digite sua opção: ");
			opcaoMenu = scanner.nextInt();

			inicializarMenu(opcaoMenu, scanner, listaAluno);
		} while (opcaoMenu != 0);

		scanner.close();
	}

	private static void inicializarMenu(int opcaoMenu, Scanner scanner, List<Aluno> listaAluno) {
		switch (opcaoMenu) {
			case 1:
				adicionarAluno(listaAluno, scanner);
				break;
			case 2:
				buscarAluno(listaAluno, scanner);
				break;
			case 3:
				removerUltimoAluno(listaAluno);
				break;
			case 4:
				imprimirAlunos(listaAluno);
				break;
			case 0:
				imprimirSaidaPrograma();
				break;
			default:
				imprimirOpcaoErrada();
				break;
		}
	}

	private static void adicionarAluno(List<Aluno> listaAluno, Scanner scanner) {
		System.out.print("Digite o nome do aluno: ");
		scanner.nextLine();
		String nome = scanner.nextLine();

		System.out.print("Digite uma nota: ");
		double nota = scanner.nextDouble();

		listaAluno.add(new Aluno(nome, nota));
		System.out.println("Aluno inserido com sucesso!");
	}

	private static void buscarAluno(List<Aluno> listaAluno, Scanner scanner) {
		System.out.println("Digite o nome a ser buscado: ");
		scanner.nextLine();
		String nome = scanner.nextLine();

		Aluno alunoEncontrado = listaAluno
				.stream()
				.filter(aluno -> aluno.getNome().equals(nome)).findFirst().orElse(null);

		if (Objects.isNull(alunoEncontrado)) {
			System.out.println("Aluno não encontrado em nenhuma posição.");
			return;
		}

		int index = listaAluno.indexOf(alunoEncontrado);
		System.out.println("Aluno encontrado na posição: " + index);
	}

	private static void removerUltimoAluno(List<Aluno> listaAluno) {
		if (!listaAluno.isEmpty()) {
			listaAluno.remove(listaAluno.size() - 1);
			System.out.println("Aluno removido com sucesso.");
		} else {
			System.out.println("Impossível remover, lista está vazia");
		}
	}

	private static void imprimirAlunos(List<Aluno> listaAluno) {
		if (!listaAluno.isEmpty()) {
			listaAluno.forEach(System.out::println);
		} else {
			System.out.println("Não existe alunos para imprimir");
		}
	}

	private static void imprimirSaidaPrograma() {
		System.out.print("///////////////////////////////");
		System.out.print("///  Saindo do Programa...  ///");
		System.out.print("///////////////////////////////");
	}

	private static void imprimirOpcaoErrada() {
		System.out.print("///////////////////////////////");
		System.out.print("///      Opção Errada!      ///");
		System.out.print("///////////////////////////////");
	}
}
