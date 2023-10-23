# Objetos y atributos

<div class="main-list">

* ruby

</div>

----
## Aprendemos con un ejemplo

* Sistema que realiza control de stock de libros.
* Utilizando un lector de código de barra se lee de cada libro información que
  luego se descargará como CSV
* Ejemplo del CSV:

```csv
"Date","ISBN","Amount"
"2008-04-12","978-1-9343561-0-4",39.45
"2008-04-13","978-1-9343561-6-6",45.67
"2008-04-14","978-1-9343560-7-4",36.95
```

----
## ¿Qué debe hacer el sistema?

* Leer varios archivos CSV y determinar cuántos ejemplares de cada
  título disponemos
* Determinar además el monto total en libros que tenemos

----
## Creamos la clase BookInStock


```ruby
class BookInStock
end
```
> Recordamos que los nombres de las clases deben comenzar con mayúsculas, los
métodos con minúscula

<div class="fragment" >

### Lo probamos

```ruby
a_book = BookInStock.new
another_book = BookInStock.new
```
</div>

----
## Observaciones

* Se crean dos objetos diferentes de la clase `BookInStock`. 
* Podríamos decir en esta primer instancia que son el mismo libro, o iguales porque **nada los
distingue**.
* Lo solucionamos obligando que la inicialización indique aquellos datos que distinga al
libro.

----

## Variables de instancia

```ruby
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
end
```

* El método `initialize` es especial en Ruby 
* Cuando se invoca el método `new`, Ruby aloca memoria para alojar un objeto no
  inicializado y luego invoca al método `initialize` **pasándole cada parámetro
  que fue enviado a `new`**.
* Entonces `initialize` nos permite configurar el estado inicial de nuestros objetos.

----
## En el método initialize

* Se utilizan variables de instancia: comienzan con **@**.
* Las variables `@isbn` e `isbn` son diferentes.
* Se realiza una pequeña validación implícita:
  * El método [`Float`](http://www.ruby-doc.org/core-2.0.0/Kernel.html#method-i-Float)
    toma un argumento y lo convierte a `float`, terminando el programa si falla
    la conversión
----

## Usamos los nuevos objetos

```ruby
b1 = BookInStock.new("isbn1", 3)
p b1
b2 = BookInStock.new("isbn2", 3.14)
p b2
b3 = BookInStock.new("isbn3", "5.67")
p b3
```

> Usamos el método `p` porque imprime el estado interno de los objetos.
> Si se utilizara `puts` entonces se invocaría `to_s` e imprimiría:
> `#<nombre_de_clase:id_objeto_en_hex>`

----

## Implementamos to_s

```ruby
class BookInStock
  def to_s
    "ISBN: #{@isbn}, price: #{@price}"
  end
end
```

> Probar nuevamente `puts b3`
----
## Objetos y sus atributos

* Un objeto como el mostrado anteriormente no permite que nadie acceda a sus
  variables.
* Si bien es algo positivo encapsular, si no permitimos acceder a los datos que
  mantienen el estado del objeto, el mismo se vuelve inútil.
* A las *ventanas* de acceso a los objetos las denominaremos **atributos**.
* Modificaremos nuestra clase de `BookInStock` con el fin de agregar atributos
  para `isbn` y `price` así podemos contabilizarlos.

----
## Getters

```ruby
class BookInStock
  def isbn
    @isbn 
  end

  def price
    @price
  end
end
```

----
## Atributos de lectura

A los atributos anteriores se los denomina **accesor** porque mapean
directamente con las variables de instancia. Ruby provee un shortcut: **`attr_reader`**.

```ruby 
class BookInStock
  attr_reader :isbn, :price
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
end
```

> * Notar que se utilizan **símbolos**.
> * `attr_reader` **no define variables de instancia**, sólo los métodos de acceso.

----
## Atributos de escritura

No sólo leemos atributos: a veces necesitamos modificar un valor. Ésto es
posible definiendo un método terminado con **el signo igual**.

```ruby
class BookInStock
  attr_reader :isbn, :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def price=(new_price)
    @price = new_price
  end
end
```

----
## Atributos de escritura

```ruby
book = BookInStock.new("isbn1", 33.80)
book.price = book.price * 0.75 # discount price
puts "New price = #{book.price}"
```

<div class="container">

<div class="col small">

Podemos usar entonces:
* **`attr_writer`:** acceso W.
* **`attr_accessor`:** acceso RW.

</div>
<div class="col">


```ruby
class BookInStock

  attr_reader :isbn
  attr_accessor :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
end
```

</div>
</div>
----
## Atributos virtuales

Agregamos el precio en centavos

<pre><code class="ruby hljs" data-trim data-line-numbers="9-16">
class BookInStock
  attr_reader :isbn
  attr_accessor :price
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def price_in_cents
    Integer(price*100 + 0.5)
  end

  def price_in_cents=(cents)
    @price = cents / 100.0
  end
end
</pre></code>

----
## El lector de CSV
Ya tenemos el objeto que representa un libro. Resta implementar:
* Leer varios archivos CSV
* Totalizar ejemplares iguales
* Totalizar el precio de los libros en stock

----
## CsvReader

Pensamos la estructura de `CsvReader`
```ruby
class CsvReader
  def initialize
  end

  def read_in_csv_data(csv_file_name)
  end

  def total_value_in_stock
  end

  def number_of_each_isbn
  end
end
```
----
## Uso de CsvReader

```ruby
reader = CsvReader.new
reader.read_in_csv_data("file1.csv")
reader.read_in_csv_data("file2.csv")
# Otros csv
puts "Total value in stock =  #{reader.total_value_in_stock}"
```

* Notamos que `CsvReader` debe ir acumulando lo que va leyendo de cada csv.
* Para ello mantendremos un arreglo de valores como variable de instancia.
* Para leer un CSV, Ruby provee de una librería que simplificará el trabajo.

----

## CsvReader

```ruby
require 'csv'

class CsvReader

  def initialize
    @books_in_stock = []
  end

  def read_in_csv_data(csv_file_name)
    CSV.foreach(csv_file_name, headers: true) do |row|
      @books_in_stock << 
        BookInStock.new(row["ISBN"], row["Amount"])
    end
  end
end
```
> Utilizamos la librería `csv` que nos permite acceder a los campos de cada
> columna por su nombre.

----
## Cálculo  del precio total

```ruby
class CsvReader

  def total_value_in_stock
    sum = 0.0
    @books_in_stock.each do |book| 
      sum += book.price
    end
    sum
  end

end
```

> Ya veremos una implementación **más rubista** que la utilizada en esta
> instancia.

----

## Organizando el código

* Dividimos el código en tres archivos
  * **`lib/book_in_stock.rb`:** la clase `BookInStock`
  * **`lib/csv_reader.rb`:** el código de `CsvReader`
  * **`stock_stats.rb`:** el programa principal
* Aparecerán dependencias entre ellos
  * Para cargar dependencias externas se utiliza: **`require`** y **`require_relative`**

----

### stock_stats.rb

```ruby
require_relative 'csv_reader'

reader = CsvReader.new
ARGV.each do |csv_file_name|
  STDERR.puts "Processing #{csv_file_name}"
  reader.read_in_csv_data(csv_file_name)
end

puts "Total value = #{reader.total_value_in_stock}"
```

[Descargar el
ejemplo](https://github.com/ttps-ruby/ttps-ruby.github.io/tree/master/ejemplos/stock-stats)

