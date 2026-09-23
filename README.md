En este proyecto se muestra el proceso de creacion de una base de datos de un sitio de E-comerce Brasileño. A partir de archivos csv y un diagrama de 
entidad-relacion, se crean las tablas, las relaciones entre las mismas y se introducen los datos. Se utilizo la librería Pandas de Python para organizar las 
columnas de algunos archivos csv previo a la carga de los datos en las tablas.

Una vez creada la base de datos, se realizan consultas a la misma para analizar algunos datos importantes. Las consultas realizadas son:
- Los productos con mas cantidad de ordenes de compra y ganancia,
- Las formas de pago mas usadas en base a la cantidad de ordenes realizadas y el valor total de los pagos,
- Segmentación de la cantidad de clientes por ciudad y estado,
- Los productos y su respectiva cantidad de ordenes para aquellas compras realizadas con tarjeta de debito,
- RFM Segmentation para los clientes (si bien la consulta fue realizada, la base de datos utilizada no presenta datos como para realizar un analisis real),
- Segmentación por ciudad, la cantidad de ordenes y la recaudación en base a las compras realizadas por los clientes en su respectiva ciudad,
- Tendencia de ingresos anuales y mensuales para todo el periodo del que se tiene datos,
- Obtener los productos con su respectiva cantidad de ordenes y ganancia total para un año especifico,
- Cantidad total de ordenes de compra y ganancia de aquellos productos con un costo de envío mayor al promedio,
- Los tipos de pago, los productos y la cantidad de ordenes por producto,
- La cantidad de ordenes para cada producto en un día especifico,
- Todos los productos con mas de 400 ordenes durante 2017,
- Los tres clientes con mas dinero gastado por ciudad dentro del estado de Rio de Janeiro,
- Los cinco productos con mas recaudación por cada medio de pago,
- El nombre de la ciudad, recaudación y cantidad de clientes para todas las ventas realizadas en seis pagos o menos durante el segundo trimestre de 2017.
