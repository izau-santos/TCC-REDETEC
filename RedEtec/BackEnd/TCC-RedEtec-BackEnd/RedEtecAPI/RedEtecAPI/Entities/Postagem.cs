﻿namespace RedEtecAPI.Entities
{
    public class Postagem
    {
        public int Id_Postagem { get; set; }
        public int Id_Usuario { get; set; }
        public string Legenda_Postagem { get; set; }
        public string Localizacao_Midia_Postagem { get; set; }
        public DateTime Data_Postagem { get; set; }
        public ICollection<Anexo> Anexos { get; set; }
        public ICollection<Comentario> Comentarios { get; set; }
        public ICollection<Curtida> Curtidas { get; set; }
        public Usuario Usuario { get; set; }

        public Postagem()
        {
            Anexos = new List<Anexo>();
            Comentarios = new List<Comentario>();
            Curtidas = new List<Curtida>();
        }
    }
}
