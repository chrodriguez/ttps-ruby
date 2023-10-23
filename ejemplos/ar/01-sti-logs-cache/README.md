# Ejemplo con Active Record

En este ejemplo mostramos cómo habilitar los logs de AR, así como además
utilizar Single Table Inheritance (STI) para la clase product. Luego, se
mostrará además como es posible llevar la cantidad de objetos asociados (Item)
utilizando una característica de caché propia de AR.

## La base de datos

Para las pruebas utilizaremos [SQLite](https://www.sqlite.org/). Entonces
procedemos a crear la estructura y datos para nuestras pruebas:

```bash
sqlite3 /tmp/sample.db
```

```sql
create table products(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name varchar(255),
  type varchar(255),
  items_count INTEGER);

create table items(id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(255),  product_id INTEGER);

insert into products(name) values('pelota'),('botines');
```

## La aplicación

El programa principal recorre la tabla de productos imprimiendo su tipo, nombre
y cantidad de items. Al finalizar el recorrido agrega un nuevo item al último
producto de la tabla.

> Observar el uso de bundler en el ejemplo analizando `Gemfile`

```
ruby main.rb
```

> La aplicación fallará si la base de datos no es creada previamente como se
> indica en la sección anterior. El path a la base de datos puede parametrizarse
> con la variable de ambiente DB_NAME

## Probamos STI

La idea es crear un producto de tipo **`ProductA`** y **`ProductB`**. Luego
probar nuevamente el programa verificando que se listen estos nuevos tipos de
producto.

Para ello utilizaremos la consola de ruby interactiva **`irb`**:

```bash
irb -I . -r main.rb
```

> El comando anterior inicia la consola de ruby cargando main.rb y ejecutándolo.
> De esta forma tendremos a disposición todos los modelos y gemas necesarias
> para operar:

```ruby
ProductA.create name: 'Sample product A'
ProductB.create name: 'Sample product B'
```

Una vez creados los nuevos productos, analizamos bien la salida del logger.
Luego probamos una vez más nuestro programa.
