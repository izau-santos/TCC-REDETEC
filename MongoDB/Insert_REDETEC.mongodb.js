/* NOME DO BANCO DE DADOS */
const database_redetec = "REDETEC";
/* NOME DA COLEÇÃO */
const collection = "Midia";
/* CRIAR OU USAR O BANCO DE DADOS */
use(database_redetec);
db[collection].insertMany(
    [{
        "_id": "unique_media_id",
        "nome_arquivo": "imagem123.png",
        "tipo_arquivo": "image/png",
        "tamanho_arquivo": 1024,
        "caminho_arquivo": "/caminho/para/imagem123.png",
        "data_upload": "2024-09-01T12:00:00Z",
        "metadados": {
            "uploader_id": 1,
            "mensagem_id": 123,
            "descricao": "Imagem do perfil"
        }
    }
    ]     
);