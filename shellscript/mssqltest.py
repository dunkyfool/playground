import pymssql

conn = pymssql.connect(server='mssql', user='sa', password='!qaz2wsX') 
cursor = conn..cursor() 
cursor.execute('SELECT Name from sys.Databases')
row = cursor.fetchall()
print row
