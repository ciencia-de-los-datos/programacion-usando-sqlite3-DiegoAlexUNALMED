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

import sqlite3
import pandas as pd

conn = sqlite3.connect(":memory:")
cur = conn.cursor()
conn.executescript(
    """
DROP TABLE IF EXISTS tbl1;

CREATE TABLE tbl1 (
    K0  CHAR(1),
    K1  INT,
    c12 FLOAT,
    c13 INT,
    c14 DATE,
    c15 FLOAT,
    c16 CHAR(4)
    );
"""
)
conn.commit()

data = pd.read_csv("https://raw.githubusercontent.com/ciencia-de-los-datos/programacion-usando-sqlite3-DiegoAlexUNALMED/main/tbl1.csv", sep = ",", header = None)
data.rename(columns = {0:"K0", 1:"K1",2:"c12",3:"c13",4:"c14",5:"c15",6:"c16"}, inplace = True)

cur.executemany("INSERT INTO tbl1 VALUES (?,?,?,?,?,?,?)", data.values)

df = pd.DataFrame({'SUM(c12)':[cur.execute("SELECT SUM(c12) FROM tbl1").fetchall()[0][0]]})
print(df)
