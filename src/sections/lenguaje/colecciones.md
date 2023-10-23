# Colecciones

<div class="main-list">

* ruby

</div>

----

## Introducción
* Las colecciones representan elementos fundamentales de cualquier programa.
* Ruby provee dos clases que representan colecciones:
  * `array`
  * `hash` _o  arreglo asociativo_
* El correcto uso de estas colecciones es fundamental en la programación Ruby.
* Los bloques, combinados con colecciones se convierten en construcciones muy
  poderosas para la iteración.

----

## Array

<div class="container">
  <div class="col">

* La clase `Array` mantiene una colección de referencias a objetos.
* Cada referencia a objeto ocupa una posición en el arreglo, identificada por un
  índice entero no negativo.

  </div>
  <div class="col">

```ruby
a = [ 3.14159, "pie", 99 ]
a.class
a.length
a[0]
a[1]
a[2]
a[3]

b = Array.new
b.class
b.length
b[0] = "second"
b[1] = "array"
```
  </div>
</div>

----

## Arrays y `[]`

* Los elementos de un arreglo se acceden con el operador `[]`.
* Pero `[]` es un método (de instancia en la clase `Array`) y por tanto puede
  implementarse por cualquier subclase.
* El primer índice de un arreglo es el cero.
* Un arreglo accedido en un índice positivo retorna el objeto referenciado en
  esa posición.
  * Si no hay objeto, retorna `nil`.
* Un arreglo accedido en un índice negativo, retorna el objeto contando desde el
  final.

----
## Uso de índices

<div class="container">
  <div class="col">

### Negativos

```ruby
a = [ 1, 7, 9]
a[-1]
a[-2]
a[-99]


```

  </div>
  <div class="col">

### Pares
```ruby
a = [ 1, 3, 5, 7, 9 ]
a[1, 3]
a[3, 1]
a[-3, 2]


```

> El significado es `[desde,cantidad]`

  </div>
  <div class="col">

### Rangos

```ruby
a = [ 1, 3, 5, 7, 9]
a[1..3]
a[1...3]
a[3..3]
a[-3..-1]
```
> Significa **desde** y **hasta**.
> Si se utiliza `..` se incluye el fin de rango, con
> `...` se **excluye** el extremo final.
  </div>
  </div>

----
## El método `[]=`


Setea elementos de un array.

```ruby
a = [ 1, 3, 5, 7, 9 ]
a[1] = 'bat'
a[-3] = 'cat'
a[3] = [ 9, 8 ]
a[6] = 99
```

> Si se utiliza un único índice, reemplaza su valor por lo que esté
> a la derecha de la asignación: _cualquier gap que haya quedado luego de `[]=`
> se completa con nil._

----
## El método `[]=`
* Utilizando dos valores o un rango, el comportamiento depende de lo que 
  esté a la derecha de la asignación:
  * Si la cantidad  a reemplazar es cero, entonces **inserta el valor**
    en la posición inicial: **_no se eliminan elementos_**.
  * Si el valor a la **derecha es un arreglo**, sus elementos se utilizan en el 
    reemplazo: _el tamaño del arreglo es actualizado si la cantidad de
    elementos a la derecha difiere de la cantidad a reemplazar._

----
## Mejor un ejemplo


```ruby
a = [ 1, 3, 5, 7, 9 ]
a[2, 2] = 'cat'
a[2, 0] = 'dog'
a[1, 1] = [ 9, 8, 7 ]
a[0..3] = []
a[5..6] = 99, 98
```

----
## push y pop


```ruby
stack = []
stack.push "red"
stack.push "green"
stack.push "blue"

puts stack.pop
puts stack.pop
puts stack.pop
```

----
## shift y unshift

```ruby
stack = []
(stack.unshift 1).unshift 2
stack.unshift 3

puts stack.shift
puts stack.shift
puts stack.shift
```

----
## first y last

```ruby
array = [ 1, 2, 3, 4, 5, 6, 7 ]
p array.first(4)
p array.last(4)
```

----
## Hashes

* Los arreglos se indexan con enteros, los hashes con objetos: _Símbolos, strings, expresiones regulares, etc_.
* Cuando se almacena un valor en un hash, utilizamos:
  * El índice, generalmente llamado *key*
  * El dato a almacenar en dicho índice, generalmente llamado *valor*
* El acceso a los valores referenciados por un hash se realiza por medio de los
  *keys*.

----

### Ejemplo

```ruby
h = { 'dog' => 'canine', 'cat' => 'feline' }
h.length # => 2
h['dog'] # => "canine"
h['cow'] = 'bovine'
h[12] = 'dodecine'
h['cat'] = 99
```

----
### Cambio de notación

```ruby
# En ruby >= 1.9
h = { dog: 'canine', cat: 'feline' }

# En ruby < 1.9
h = { :dog => 'canine', :cat => 'feline' }
```
----

### Un programa usando colecciones


Calcular el número de veces que aparece una palabra en un texto

> El problema se divide en dos partes:
> * Separar el texto en palabras: *suena como un array*
> * Luego contar cada palabra diferente: *suena como hash*

----

### El método que obtiene las palabras

Usando expresiones regulares y el método `scan` todo parece muy simple:

```ruby
def words_from_string(string)
  string.downcase.scan(/[\w']+/)
end
```

> Analizar otros ejeplos de scan. Por ejemplo probar:
> 
> `"0123456789".scan /.{2}/`
----
### El método que cuenta las palabras

Con un hash indexaremos para cada palabra, la cantidad de ocurrencias.

```ruby
if counts.has_key?(next_word)
  counts[next_word] += 1
else
  counts[next_word] = 1
end
```

----

## Refactorizamos

```ruby
def count_frequency(word_list)
  counts = Hash.new(0)
  for word in word_list
    counts[word] += 1
  end
  counts
end
```

> `Hash.new` puede recibir como parámetro el valor usado para incializar cada
> valor del Hash.  [Ver ejemplo](https://github.com/ttps-ruby/ttps-ruby.github.io/tree/master/ejemplos/words-frequency).
> Es importante destacar que el ejemplo incluye tests para analizar cómo
> desarrollar utilzando TDD.

