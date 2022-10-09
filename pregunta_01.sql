-- 
--  La tabla `tbl1` tiene la siguiente estructura:
-- 
--    K0  CHAR(1)
--    K1  INT
--    c12 FLOAT
--    c13 INT
--    c14 DATE
--    c15 FLOAT
--    c16 CHAR(4)
--
--  Escriba una consulta en SQL que devuelva la suma del campo c12.
-- 
--  Rta/
--     SUM(c12)
--  0  15137.63
--
--  >>> Escriba su codigo a partir de este punto <<<
--SELECT SUM(c12) FROM tbl1.csv

import doctest
import subprocess

def run_answer():
    '''Codigo especifico para ejecutar la respuesta'''
    #----------------------------------------------------------------------------------------------
    # Prepara los datos para evaluar la tarea
    #----------------------------------------------------------------------------------------------
    import sqlite3
    conn = sqlite3.connect(':memory:')
    cur = conn.cursor()
    sqlcmd = """
        CREATE TABLE tbl (
            K0  CHAR(1),
            K1  INT,
            c12 FLOAT,
            c13 INT,
            c14 DATE,
            c15 FLOAT,
            c16 CHAR(4)
            );"""
    cur.execute(sqlcmd).fetchall()

    ## Carga los datos y los inserta en la tabla
    text = open('data.csv', 'rt', encoding='utf-8').readlines()
    text = [line[:-1] if line[-1] == '\n' else line for line in text]
    text = [line.split(',') for line in text]
    text = [tuple(line) for line in text]
    cur.executemany('INSERT INTO tbl VALUES (?,?,?,?,?,?,?)', text)

    #----------------------------------------------------------------------------------------------
    # Ejecuta el código del estudiante
    #----------------------------------------------------------------------------------------------
    import pandas as pd
    answer = open('question.sql', 'rt', encoding='utf-8').readlines()
    answer = [row for row in  answer if len(row) >= 2 and row[0:2] != '--']
    answer = ''.join(answer)
    if answer.strip() == '':
        return None
    else:
        return pd.read_sql_query(answer, conn)

#--------------------------------------------------------------------------------------------------
# Grader (generic)
#--------------------------------------------------------------------------------------------------
subprocess.run(['rm', '-f', '_SUCCESS']) # borra el flag de exito de la corrida
RESULT = doctest.testmod()               # ejecuta el doctest
FAIL, _ = RESULT                         # fail, total
if FAIL == 0:                            # grading
    open('_SUCCESS', 'a').close()        #
else:
    print('\n')
