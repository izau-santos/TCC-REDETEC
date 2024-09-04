﻿namespace RedEtecAPI.Entities
{
    public class Curso
    {
        public int Id_Curso { get; set; }
        public string Nome_Curso { get; set; }
        public string Horario_Curso { get; set; }
        public ICollection<Matricula> Matriculas { get; set; }
        public ICollection<Materia_Curso> Materia_Cursos { get; set; }
        public ICollection<Professor_Curso> Professor_Cursos { get; set; }

        public Curso()
        {
            Matriculas = new List<Matricula>();
            Materia_Cursos = new List<Materia_Curso>();
            Professor_Cursos = new List<Professor_Curso>();
        }
    }
}
