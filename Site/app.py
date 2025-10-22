from flask import Flask 
from flask import render_template 
import mysql.connector as connection 

app = Flask (__name__)

def conectar():
    cnx = connection.MySQLConnection (
        user='root', 
        password='labinfo',
        host='127.0.0.1',
        database='academico'
        )
    
def execucao(sql, titulo, cabecalho):
    cnx = conectar()
    cursor = cnx.cursor(dictionary=True)
    cursor.execute(sql)
    dados = cursor.fetchall()
    cursor.close()
    cnx.close()
    return render_template("respostas.html", titulo=titulo, cabecalho=cabecalho, dados=dados)

    
@app.route ("/um")
def um():
    sql = """
        SELECT nome, cidade FROM alunos ORDER BY nome ASC;
    """
    return execucao (sql, "Seleção 1 - Nome e Cidade dos Alunos", ["Nome", "Cidade"])

@app.route ("/dois")
def dois():
    sql = """
        SELECT aluno_id, nome, email
        FROM alunos
        WHERE nome LIKE 'A%';
    """
    return execucao (sql, "Seleção 2 - Alunos de inicial A", ["ID", "Nome", "E-mail"])

@app.route ("/tres")
def tres():
    sql = """
        SELECT nome, cidade, nota_media
        FROM alunos
        WHERE nota_media > 8.0;
    """
    return execucao (sql, "Seleção 3 - Alunos com nota média acima de 8.0", ["Nome", "Cidade", "Nota Média"])


@app.route ("/quatro")
def quatro():
    sql = """
        SELECT nome, nota_media
        FROM alunos
        WHERE nota_media < 7.0;
    """
    return execucao (sql, "Seleção 4 - Alunos com nota média abaixo de 7.0", ["Nome", "Nota Média"])

@app.route ("/cinco")
def cinco():
   sql = """
        SELECT COUNT(cidade)
        FROM alunos
        WHERE cidade LIKE 'Natal';
    """
   return execucao (sql, "Seleção 5 - Total de alunos de Natal", ["Total de Alunos"])

@app.route ("/seis")
def seis():
    sql = """
        SELECT alunos.nome, cursos.nome, matriculas.status 
        FROM alunos, cursos, matriculas
        WHERE alunos.aluno_id=matriculas.aluno_id and cursos.curso_id=matriculas.curso_id;
"""
    return execucao (sql, "Seleção 6 - Aluno, Curso e Status de Matrículas", ["Aluno", "Curso", "Status"])

@app.route ("/sete")
def sete():
    sql = """
        SELECT alunos.nome, cursos.nome, matriculas.data_matricula 
        FROM alunos, cursos, matriculas
        WHERE alunos.aluno_id=matriculas.aluno_id and 
        cursos.curso_id=matriculas.curso_id and matriculas.status = "Ativa" and cursos.preco > 700;
"""
    return execucao (sql, "Seleção 7 - Matrículas Ativas em cursos com preço maior que 700", ["Aluno", "Curso", "Data de Matrícula"])

@app.route ("/oito")
def oito(): 
    sql = """
        SELECT alunos.nome, cursos.nome, matriculas.status 
        FROM alunos, cursos, matriculas
        WHERE alunos.aluno_id=matriculas.aluno_id and cursos.curso_id=matriculas.curso_id 
        and cursos.area = "Tecnologia";
"""
    return execucao (sql, "Seleção 8 - Matrículas em cursos de Tecnologia", ["Aluno", "Curso", "Status"])

@app.route("/")
def home():
    return render_template ("respostas.html", titulo="Que seleção deseja acessar?", cabecalhos=[], dados=[])


if __name__ == "__main__":
    app.run(debug=True)