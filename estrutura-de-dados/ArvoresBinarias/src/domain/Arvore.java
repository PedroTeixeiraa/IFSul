package domain;

import java.util.Objects;

public class Arvore {

    private Object info;
    private Arvore left;
    private Arvore right;

    public Arvore() {
    }

    public Arvore(Object info) {
        this.info = info;
        this.left = null;
        this.right = null;
    }

    public Arvore(Object info, Arvore left, Arvore right) {
        this.info = info;
        this.left = left;
        this.right = right;
    }

    public static boolean isEmpty(Arvore arvore) {
        return Objects.isNull(arvore);
    }

    public static boolean find(Arvore arvore, Object info) {
        if (isEmpty(arvore)) {
            return false;
        }
        return (arvore.info.equals(info)) || (find(arvore.left, info)) || find(arvore.right, info);
    }

    public static void printBeforeOrder(Arvore arvore) {
        if(!isEmpty(arvore)) {
            System.out.print(arvore.info + ", ");
            printBeforeOrder(arvore.left);
            printBeforeOrder(arvore.right);
        }
    }

    public static void printSymmetricOrder(Arvore arvore) {
        if (!isEmpty(arvore)) {
            printSymmetricOrder(arvore.left);
            System.out.print(arvore.info + ", ");
            printSymmetricOrder(arvore.right);
        }
    }

    public static void printAfterOrder(Arvore arvore) {
        if(!isEmpty(arvore)) {
            printAfterOrder(arvore.left);
            printAfterOrder(arvore.right);
            System.out.print(arvore.info + ", ");
        }
    }

    public static int height(Arvore arvore) {
        if (isEmpty(arvore)) {
            return -1;
        }

        return 1 + Math.max(height(arvore.left), height(arvore.right));
    }

    public static int quantity(Arvore arvore) {
        return (isEmpty(arvore)) ? 0 : 1 + quantity(arvore.left) + quantity(arvore.right);
    }

    public Object getInfo() {
        return info;
    }

    public void setInfo(Object info) {
        this.info = info;
    }

    public Arvore getLeft() {
        return left;
    }

    public void setLeft(Arvore left) {
        this.left = left;
    }

    public Arvore getRight() {
        return right;
    }

    public void setRight(Arvore right) {
        this.right = right;
    }
}
