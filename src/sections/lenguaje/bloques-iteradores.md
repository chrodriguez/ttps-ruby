# Bloques e iteradores

<div class="main-list">

* ruby

</div>

----

## Bloques
* Un bloque es código encerrado entre llaves o las palabras claves `do` y `end`.
* Ambas formas son idénticas, salvo por la precedencia.
  * Cuando el código del bloque entra en una línea usar {}.
  * Cuando tiene más de una línea usar `do` / `end`.
* Los bloques pueden verse como métodos anónimos.

----

## Bloques
* Pueden recibir parámetros, que se explicitan entre barras verticales `|`.
* El código de un bloque no se ejecuta cuando se define, sino que se almacenará
  para ser ejecutado más adelante.
* En ruby, los bloques sólo podrán usarse después de la *invocación* de algún
  método:
  * Si el método recibe parámetros, entonces aparecerá luego de ellos.
  * Podría verse incluso como un parámetro extra que es pasado al método.

----

## Ejemplo

Suma de los cuadrados de los números en un arreglo

<div class="container">
<div class="col">

```ruby
sum = 0
[1, 2, 3, 4].each do |value|
  square = value * value
  sum += square
end
puts sum
```

</div>
<div class="col small">

* El bloque se invoca para cada elemento en el arreglo
* El elemento del arreglo es pasado al bloque en la variable `value`
* La variable `sum` declarada fuera del bloque es actualizada dentro del bloque
</div>
</div>

----
## Bloques

* **Regla importante:** *si existe una variable en el bloque con el mismo
  nombre que una variable dentro del alcance pero creada fuera del bloque, ambas serán la
  misma variable. En el ejemplo hay sólo una variable `sum`*
* Veremos que el comportamiento mencionado podremos cambiarlo
* Si una variable aparece sólo en el bloque, entonces será local al mismo (como
`square`)

----
## Un caso inesperado

```ruby
# assume Shape defined elsewhere
square = Shape.new(sides: 4) 
#
# .. lots of code
#
sum = 0
[1, 2, 3, 4].each do |value|
  square = value * value
  sum += square
end

puts sum
square.draw # BOOM!
```

----
## Mas casos

No sucede lo mismo con los argumentos al bloque

```ruby
value = "some shape"
[ 1, 2 ].each {|value| puts value }
puts value
```

Podemos solucionar el problema de `square`

```ruby
square = "some shape"
sum = 0
[1, 2, 3, 4].each do |value; square|
  square = value * value # different variable
  sum += square
end
puts sum
puts square
```

----
## La magia de los bloques

<div class="small">

* Mencionamos que los bloques se utilizan de forma adyacente a la llamada a un
  método y que no se ejecutan en el momento en que aparecen en el código.
* Para lograr este comportamiento, dentro de un método cualquiera, podremos
  invocar un bloque:
  * Los bloques se invocarán como si fueran métodos.
  * Para invocar un bloque se utiliza la sentencia `yield`.
  * Al invocar `yield` ruby invocará al código del bloque .
  * Cuando el bloque finaliza, ruby devuelve el código inmediatamente al
    finalizar el llamado a `yield`.
</div>
----
## Ejemplo de un bloque

```ruby

def three_times
  yield
  yield
  yield
end

three_times { puts "Hola" }
```

----

## Parámetros a un bloque

* Cuando utilizamos `yield` podemos enviarle un parámetro
  * El parámetro enviado se mapea con el definido en el bloque entre las barras
    verticales.
* Un bloque puede retornar un valor y ser usado en el método.

----
## Ejemplo de envío de parámetros

```ruby

def fib_up_to(max)
  i1, i2 = 1, 1
  while i1 <= max
    yield i1
    i1, i2 = i2, i1+i2
  end
end

fib_up_to(1000) {|f| print f, " " }

```

----
## Uso del valor retornado

```ruby

class Array
  def my_find
    for i in 0...size
      value = self[i]
      return value if yield(value)
    end
    return nil
  end
end

(1..200).to_a.my_find {|x| x%5 == 0}

(1..200).to_a.my_find {|x| x == 0}

```

----
## Los iteradores
* Las clases que implementan colecciones, como `Array` *hacen lo que hacen
  mejor:*
  * Acceder a los elementos que contienen.
* El comportamiento de qué hacer con cada elemento lo delegan a la aplicación:
  * Permitiendo que nos concentremos sólo en un requerimiento particular.
  * En los casos anteriores (`find`), sería encontrar un elemento para el cual
    el criterio sea verdadero.

----
## each y collect

* El iterador `each` es el más simple.
  * Solo invoca `yield` para cada elemento.
* El iterador `collect` también conocido como `map`.
  * Invoca `yield` para cada elemento. El resultado lo guarda en un nuevo 
  arreglo que es **retornado**.

```ruby
[ 1, 3, 5, 7, 9 ].each {|i| puts i }

['k','h','m','t','w'].collect {|x| x.succ }
```

----
## Otros usos de iteradores 

* Los iteradores no sólo se usan con array y hash.
* Su lógica es muy utilizada en clases de entrada / salida para retornar
  líneas sucesivas o bytes.

```ruby
f = File.open("testfile")
f.each { |line| puts "The line is: #{line}"}
f.close
```


```ruby
f = File.open("testfile")
f.each_with_index do |line, index| 
  puts "Line #{index} is: #{line}" 
end
f.close
```

----
## inject
* Este iterador tiene un nombre *raro*.
* Permite acumular un valor a lo largo de los miembros de una colección.
* Recibe un parámetro que es el valor inicial para comenzar a acumular.
  * Si no se especifica **toma el primer elemento de la colección**.

```ruby
[1,3,5,7].inject(0) {|sum, element| sum+element}
[1,3,5,7].inject    {|sum, element| sum+element}
[1,3,5,7].inject(1) {|prod, element| prod*element}
[1,3,5,7].inject    {|prod, element| prod*element}
```

----
## inject

Un uso más críptico de `inject`:

```ruby
[1,3,5,7].inject(:+)
[1,3,5,7].inject 100, :+
[1,3,5,7].inject(:*)
```

----
## Problema de iteradores
* Los iteradores son muy cómodos pero:
  * Son parte de la colección y no una clase a parte.
  * En otros lenguajes (como Java), las colecciones no implementan sus
    iteradores, sino que son clases separadas (como por ejemplo la interfaz 
    Iterator de Java).
  * Es complicado iterar dos colecciones simultáneamente.

----
## Enumerators

* La solución: clase `Enumerator`.
* Se obtiene de una colección con el método `to_enum` o `enum_for`.

```ruby
a = [ 1, 3, "cat" ]
h = { dog: "canine", fox: "lupine" }
# Create Enumerators
enum_a = a.to_enum
enum_h = h.to_enum
enum_a.next   # => 1
enum_h.next   # => [ :dog, "canine" ]
enum_a.next   # => 3
enum_h.next   # => [ :fox, "lupine" ]
```
----
## Enumerators e iteradores

Si un iterador se utiliza sin bloque, entonces retorna un Enumerator

```ruby
a = [1,2,3].each
a.next
```

----
## El método loop
<div class="small">

* Ejecuta el código que se encuentra dentro del bloque.
* Se puede salir con break cuando se cumple una condición.
* Si hay iteradores, `loop` terminará cuando el Enumerator se quede sin valores.

</div>

<div class="container">
<div class="col">

```ruby


loop { puts "Hola" }



```
</div>
<div class="col">

```ruby
i=0
loop do
  puts i += 1
  break if i >= 10
end
```
</div>
</div>

```ruby
short_enum = [1, 2, 3].to_enum
long_enum = ('a'..'z').to_enum
loop { puts "#{short_enum.next} - #{long_enum.next}" }
```

----
## Enumerator como objeto

Sabemos que es posible usar `each_with_index` en `Array`

```ruby
result = []
[ 'a', 'b', 'c' ].each_with_index do |item, index| 
  result << [item, index] 
end
```

<div class="fragment">

¿Y si queremos hacer lo mismo con un `String`?
</div>

<div class="fragment small">

* No existe `each_with_index` en `String`.
* Pero sí existe `each_char` que es como `each` de `Array` pero sobre cada
  caracter del string.
  * Si no enviamos un bloque, retornará un `Enumerator`.
* La interfaz `Enumerable` define el método `each_with_index`.
</div>

----
## El código con String
```ruby
result = []
"cat".each_char.each_with_index do |item, index| 
    result << [item, index] 
end
# Aun más simple:
result = []
"cat".each_char.with_index do |item, index| 
    result << [item, index] 
end
```

----
## Enumerator como generadores
<div class="small">

* Podemos crear objetos enumerator explícitamente en vez de hacerlo a partir de
  una colección.
* Para ello es necesario utilizar un bloque en la creación:
  * El código del bloque se usará por el objeto Enumerator cada vez que el
    programa principal le solicite un nuevo valor.
  * Este bloque no se ejecutará como otros bloques dado que su ejecución
    se disparará cada vez que se solicita el siguiente valor.
  * La ejecución del bloque se pausa y vuelve al programa principal cuando se
    encuentra `yield`.
  * Cuando se solicita el siguiente valor, el código del bloque continúa a
    partir de la línea siguiente al `yield`.
</div>

----
## Enumerator como generadores
Generamos **secuencias infinitas**:


```ruby
fibonacci = Enumerator.new do |caller|
  i1, i2 = 1, 1
  loop do
    caller.yield i1
    i1, i2 = i2, i1+i2
  end
end

6.times { puts fibonacci.next }
```

<div class="small">

Como `Enumerator` es `Enumerable` sería posible:
</div>

```ruby
fibonacci.first(1000).last
```

----
## ¡Hay que tener cuidado!

<div class="small">

* Cuidado con los enumerators que generan listas infinitas.
* Los metodos comunes de los enumeradores como `count` y `select` tratarán de
  leer todos los elementos antes de retornar un valor.
  * Podemos escribir la versión de `select` adecuada a nuestra lista
    infinita.

</div>

```ruby
def infinite_select(enum, &block)
  Enumerator.new do |caller|
    enum.each do |value|
      caller.yield(value) if block.call(value)
    end
  end
end

p infinite_select(fibonacci) {|val| val % 2 == 0}.first(5)
```

----
## Solución conveniente
Podemos escribir filtros como `infinite_select` directamente en la clase
`Enumerator`

``` ruby
class Enumerator
  def infinite_select(&block)
    Enumerator.new do |caller|
      self.each do |value|
        caller.yield(value) if block.call(value)
      end
    end
  end
end

p fibonacci.
  infinite_select {|val| val % 2 == 0}.
  infinite_select {|val| val.to_s =~ /13\d$/ }.
  first(2)
```

----
## Bloques como transacciones

<div class="small">

* Podemos usar bloques para definir código que debe ejecutarse bajo ciertas
  condiciones transaccionales.
* Por ejemplo:
  * Abrir un archivo
  * Procesarlo
  * Cerrarlo
* Si bien esto podemos hacerlo secuencialmente, utilizando bloques simplificamos
  mucho.
</div>

```ruby
class File
  def self.open_and_process(*args)
    f = File.open(*args)
    yield f
    f.close()
  end
end
```

----
## Analizamos un poco...

<div class="small">

* El método de clase implementado fue desarrollado para que entienda los mismos
  parámetros que `File.open`.
* Para ello, lo que hicimos es pasar los parámetros tal cual se enviaron a
  `File.open`.
  * Esto se logra definiendo como argumento al método `*args` que significa:
    *tomar todos los argumentos enviados al método actual y colocarlos en un
    arreglo llamado args*.
  * Luego llamamos a `File.open(*args)`. Utilizar *args vuelve a expandir los
    elementos del arreglo a parámetros individuales.
</div>

----
## Versión completa de my_open
```ruby
class File
  def self.my_open(*args)
    result = file = File.new(*args)
    if block_given?
      result = yield file
      file.close
    end
    return result
  end
end
```


> Esta técnica es tan útil, que `File.open` ya lo implementa.  Además de usar `File.open`
> para abrir un archivo, podemos usarlo para directamente procesarlo como lo hacíamos
> con `open_and_process`.

----
## Bloques como objetos
* Anteriormente mencionamos que los bloques son como un parámetro
  adicional pasado a un método.
* Podremos forzar bloques como parámetros explícitos:
  * Utilizando & en el último parámetro, Ruby buscará el codigo
    de un bloque cuando el método es invocado.
  * Este parámetro podrá utilizarse como cualquier otro.

----
## Bloques como objetos

```ruby
class ProcExample
  def pass_in_block(&action)
    @stored_proc = action
  end
  def use_proc(parameter)
    @stored_proc.call(parameter)
  end
end

eg = ProcExample.new
eg.pass_in_block { |param| puts "The parameter is #{param}" }
eg.use_proc(99)
```

> Notar que pasando `&action` podemos almacenar el bloque en una variable. Si no
> se usara `&` no sería posible.
----

## Avanzando un poco más...
* Vemos que `call` invoca la ejecución del bloque.
* Muchos programas utilizan esta idea para implementar **callbacks**.
* ¿Qué pasaría si retornamos el bloque?

```ruby
def create_block_object(&block)
  block
end

bo = create_block_object do |param| 
  puts "You called me with #{param}"
end
bo.call 99
bo.call "cat"
```

----
## Proc y lambda
* Devolver un bloque es tan útil que en Ruby hay dos formas de hacerlo:
  * `lamda` y `Proc.new` toman un bloque y retornan un objeto.
  * El objeto retornado es de la clase `Proc`.

> Ya hemos mencionado que `lambda` controla los parámetros que requiere el
> bloque  mientras que `Proc` no lo hace.

----
## Bloques como Closures
Los bloques pueden utilizar variables que están dentro del alcance del bloque.

```ruby
def n_times(thing)
  lambda {|n| thing * n }
end
p1 = n_times(10)
p1.call(3)
p1.call(4)
p2 = n_times("Hola ")
p2.call(3)
```
> ¿Qué hace el ejemplo anterior?

----
## ¿Qué es un Closure?
* El método `n_times` referencia un parámetro `thing` que es usado dentro el bloque.
* Aunque en las llamadas a `call` el parámetro `thing` está fuera del alcance,
  el parámetro se mantiene accesible dentro del bloque.

_**Closure:** variables en el alcance cercano que son referenciadas por el bloque
se mantienen accesibles por la vida del bloque y la vida del objeto Proc creado
para este bloque._

----
## Otro ejemplo de Closure

```ruby
def what_do_i_do?
  value = 1
  lambda { value += value }
end

let_me_see = what_do_i_do?
let_me_see.call
let_me_see.call
```

----
## Un closure en js

```js
let multiplicar = ( x => (y) => x*y )
multiplicar(2)(3)
```

----
### Lambda: notación alternativa

```ruby
lambda { |params| ... }
# es equivalente a
->params { ... }

# Y con parámetros
proc1 = -> arg {puts "proc1:#{arg}" }
proc2 = -> arg1, arg2 {puts "proc2:#{arg1} y #{arg2}" }
proc3 = ->(arg1, arg2) {puts "proc3:#{arg1} y #{arg2}" }

proc1.call "ant"
proc2.call "bee", "cat"
proc3.call "dog", "elk"
```

----
## Custom while
Reimplementamos un while usando bloques

<div class="container">

<div class="col fragment">

### Proc
```ruby
def my_while(cond, &body)
  while cond.call
    body.call
  end
end

a = 0
my_while(Proc.new { a < 3 }) do
  puts a
  a += 1
end
```
</div>
<div class="col fragment">

### Lamda
```ruby
def my_while(cond, &body)
  while cond.call
    body.call
  end
end

a = 0
my_while -> { a < 3 } do
  puts a
  a += 1
end
```
</div>
</div>

----
### Lista de parámetros a un bloque
* Los argumentos a un bloque podrán ser:
  * Argumentos splat.
  * Inicializados con un valor por defecto.
  * Bloques como parámetro (usando `&`).
----
### Lista de parámetros a un bloque
```ruby
proc1 = lambda do |a, *b, &block|
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
  block.call
end
proc1.call(1, 2, 3, 4) { puts "in block1" }

proc2 = -> a, *b, &block do
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
  block.call
end
proc2.call(1, 2, 3, 4) { puts "in block2" }
```
> Más adelante veremos en detalle cómo funciona el splat.

----
### El símbolo usado como bloque

Para entender por qué funciona:

```ruby
[1,2,3].inject &:+
```

<div class="small"> 

Analizando qué es lo que sucede en el siguiente ejemplo
</div>

```ruby
o = Object.new
[1,2,3].inject &o
# TypeError: wrong argument type Object (expected Proc)
```

----
### El símbolo usado como bloque

Una solución es implementar `to_proc`:

<div class="container">

<div class="col">

```ruby
class Object
  def to_proc
    Proc.new {}
  end
end
o = Object.new
[1,2,3].inject &o
```

</div>
<div class="col small">

* No falla, pero no hace lo esperado.
* Sólo convertimos a un bloque vacío.
* Un bloque sin acciones no es útil.
* Menos en el contexto de `inject`.
</div>
</div>
----
### El símbolo usado como bloque

<div class="small">

Analizando entonces lo que sucedió inferimos que la clase `Symbol` implementa
`#to_proc` de la siguiente forma:
</div>

<div class="container">
<div class="col">

```ruby
class Symbol
  def to_proc
    lambda { |obj| obj.send(self) }
  end
end
```
</div>
<div class="col">

```ruby

[1,2,3].map &:to_s

[1,2,3].inject &:+


```
</div>
</div>

**¡¡Probemos!!**
<div class="small fragment">

Funciona **`map`** pero no **`inject`**. _Observemos bien el error._
</div>
----
### El símbolo usado como bloque


<div class="small">
Tratamos de solucionar la implementación anterior:
</div>

<div class="container">
<div class="col">

```ruby
class Symbol
  def to_proc
    lambda do |obj, args| 
      obj.send(self, *args)
    end
  end
end
```
</div>
<div class="col">

```ruby

[1,2,3].map &:to_s


[1,2,3].inject &:+



```
</div>
</div>

**¡¡Probemos!!**
<div class="small fragment">

Funciona **`inject`** pero no **`map`**. _Observemos bien el error._
</div>
<div class="small fragment">

> Claro ejemplo de solucionar algo y romper otra cosa. Caso que se controla
> utilizando tests de unidad.
</div>
----
### El símbolo usado como bloque

La solución a ambos problemas:

```ruby
class Symbol
  def to_proc
    lambda { |obj, args=nil| obj.send(self, *args) }
  end
end

[1,2,3].map &:to_s
[1,2,3].inject &:+
```
