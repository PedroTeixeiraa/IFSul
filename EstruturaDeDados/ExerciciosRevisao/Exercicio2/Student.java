package exercicio2;

public class Student {

    public static final double MEDIA_TO_PASS = 6.0;

    private String name;

    private Double firstSemesterNote;

    private Double secondSemesterNote;

    public Student(String name, Double firstSemesterNote, Double secondSemesterNote) {
        this.name = name;
        this.firstSemesterNote = firstSemesterNote;
        this.secondSemesterNote = secondSemesterNote;
    }

    public String statusStudent() {
        if(annualAverage() >= MEDIA_TO_PASS) {
            return studentApproved();
        } else {
            return studentDisapproved();
        }
    }

    private String studentApproved() {
        return "Student: " + name +
                " | Annual average: " + annualAverage() +
                " | Status: APROVADO";
    }

    private String studentDisapproved() {

        Double missingPoints = MEDIA_TO_PASS - annualAverage();

        return "Student: " + name +
                " | Missing points: " + missingPoints +
                " | Status: REPROVADO";
    }

    private Double annualAverage() {
        return (firstSemesterNote + secondSemesterNote) / 2;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getFirstSemesterNote() {
        return firstSemesterNote;
    }

    public void setFirstSemesterNote(Double firstSemesterNote) {
        this.firstSemesterNote = firstSemesterNote;
    }

    public Double getSecondSemesterNote() {
        return secondSemesterNote;
    }

    public void setSecondSemesterNote(Double secondSemesterNote) {
        this.secondSemesterNote = secondSemesterNote;
    }
}
