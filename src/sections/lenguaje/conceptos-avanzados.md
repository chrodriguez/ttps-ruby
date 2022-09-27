# Conceptos avanzados

<div class="main-list">

* ruby

</div>

----
# Tipos estándar

<div class="main-list">

* ruby
  * conceptos avanzados

</div>
----
## Números

* Pueden ser enteros, punto flotante, racionales, complejos.
* **Antes de ruby 2.4**, los enteros se manejaban internamente como:
  * Se representan con `Fixnum` en el rango de `(-2^30..2^30-1 o -2^62..2^62-1)`.
  * Fuera del rango anterior, Ruby utiliza Bignum en forma transparente.
* **A partir de ruby 2.4** se usa `Integer`.
* Los strings no se convierten automáticamente a enteros: `'1' + '2' => '12'`.

----
## ¿Cómo interactúan?

```ruby
1 + 2               # => 3
1 + 2.0             # => 3.0
1.0 + 2             # => 3.0
1.0 + Complex(1,2)  # => (2.0,2i)
1 + Rational(2,3)   # => (5/3)
1.0 + Rational(2,3) # => 1.66666666666665

# Y cuando se divide:

1.0/2               # => 0.5
1/2.0               # => 0.5
1/2                 # => 0
```

<div class="fragment small">

**Probar la división requiriendo `mathn`**. A partir de ruby 2.5 debe instalrse
como gema: `gem install cmath mathn`

</div>

----
<!-- .slide: data-auto-animate -->
## Strings y el encoding
* A partir de ruby 1.9, cada string tiene asociada una codificación.
* Por defecto, la codificación asociada a un literal string dependerá de la 
  codificación del archivo fuente donde se especificó:
  * Si no se especifica la codificación se asume: `US-ASCII` en
    1.9 y `UTF-8` a partir de ruby 2.

----
<!-- .slide: data-auto-animate -->
## Strings y el encoding

Cambiamos la codificación de un fuente agregando en la primer línea un
 comentario **`#encoding: xxxx`**.

```ruby
#encoding: iso-8859-1
txt = "dog"
puts "Encoding of #{txt.inspect} is #{txt.encoding}"
```

----
# Rangos

<div class="main-list">

* ruby
  * conceptos avanzados

</div>
----
## Rangos como condiciones
Otro uso rangos en condiciones permite al objeto rango mantener el estado de
las comparaciones que macheen desde un valor (el inicial del rango) hasta el
final (del rango).

```ruby 
100.times {|x| p x if x==50 .. x==55 }

while line = gets
  puts line if line =~ /start/ .. line =~ /end/
end
```

----
<!-- .slide: data-auto-animate -->
## Rangos como intervalos
```ruby
car_age = gets.to_f # let's assume it's 5.2
case car_age
  when 0...1
    puts "Mmm.. new car smell"
  when 1...3
    puts "Nice and new"
  when 3...6
    puts "Reliable but slightly dinged"
  when 6...10
    puts "Can be a struggle"
  when 10...30
    puts "Clunker"
  else
    puts "Vintage gem"
end
```

----
<!-- .slide: data-auto-animate -->
## Buscando el problema...

```ruby
car_age = gets.to_f # let's assume it's 5.2
case car_age
  when 0..0
    puts "Mmm.. new car smell"
  when 1..2
    puts "Nice and new"
  when 3..5
    puts "Reliable but slightly dinged"
  when 6..9
    puts "Can be a struggle"
  when 10..29
    puts "Clunker"
  else
    puts "Vintage gem"
end

```
----
# Métodos

<div class="main-list">

* ruby
  * conceptos avanzados

</div>

----
## Definiendo un método
* Los nombres de los métodos deben empezar con minúscula o underescore
* *No es error que el nombre comience con mayúsucla, pero debería recibir
  argumentos.  Por convención, los métodos que comienzan con mayúscula se
  utilizan para conversiones de tipos*:
    * `def String; 'string'; end;`
    * `String() vs String`
----
## Los métodos

* Cuando retornamos un boolean, es prolijo que el método termine con `?`
* Aquellos métodos *peligrosos* deben terminar con `!`
* Los métodos que aparecen a la izquierda de una asignación terminan con `=`

----
<!-- .slide: data-auto-animate -->
## Argumentos

* Los parámtros a un método se escriben como una lista de variables entre
  paréntesis:
  * Los paréntesis pueden omitirse.
  * Por convención se usarán paréntesis cuando el método tenga argumentos, y
    omitirlos cuando no.
----
<!-- .slide: data-auto-animate -->
## Argumentos
* Es posible definir valores por defecto para los argumentos.
* Incluso usando como valor un parámetro anterior.

<div class="fragment">

```ruby
def concat(a="a", b="b")
  "#{a},#{b}"
end

def surround(word, pad_width=word.length/2)
"[" * pad_width + word + "]" * pad_width
end
```
</div>

----
## Argumentos variables
* Usando **`*`** antes del nombre del argumento y luego de los parámetros normales.
  * A partir de Ruby 1.9, es posible definir el argumento variable en cualquier
    posición. Lo importante es no tener más de uno
* A esta técnica se la suele llamar: *splatting an argument* 

```ruby
def varargs(arg1, *rest)
  "arg1=#{arg1}. rest=#{rest.inspect}"
end
```

----
## Usos de splat
* Se utiliza splat en una subclase para pasar parámetros a la
  superclase usando `super`.
* **`super`** sin argumentos invoca el método del padre con todos los argumentos recibidos.

<div class="container">

<div class="col">

```ruby
class Child < Parent
  def do_something(*not_used)
    # our processing
    super
  end
end
```
</div>
<div class="col">

```ruby
class Child < Parent
  def do_something(*)
    # our processing
    super
  end
end
```
</div>
</div>

----
## Retornando valores 
* Los métodos siempre retornan un valor aunque el mismo no sea utilizado.
* Podemos usar `return` para forzar la salida.
* Si se envían varios parámetros a `return` se retorna un arreglo.
* El caso anterior se puede usar en asignaciones en paralelo.

----
## Arreglo como argumentos
Es la idea inversa a la explicación de splat previa


```ruby
def five(a, b, c, d, e)
  "I was passed #{a} #{b} #{c} #{d} #{e}"
end

five(1, 2, 3, 4, 5 )
five(1, 2, 3, *['a', 'b'])
five(*['a', 'b'], 1, 2, 3)
five(*(10..14))
five(*[1,2], 3, *(4..5))
```

----
## Bloques más dinámicos
Al igual que en el caso anterior de splat, podemos necesitar especificar que
uno de los parámetros a un método es un bloque

```ruby
## En vez de 
(1..10).collect { |x| x*2}.join(',')

## Podemos usar
b = -> x { x*2}
(1..10).collect(&b).join ','
```

----
<!-- .slide: data-auto-animate -->
## Argumentos como Hash
* Hasta Ruby 1.9 no existía la posibilidad de usar *keyword arguments*.
* En vez de especificar los parámetros en el orden en que se definieron, es posible
  especificar qué valor tomará cada parámetro indicando el hecho con el nombre
  del argumento y su valor.
* Hasta que Ruby 1.9 se utilizaba Hash en su reemplazo para obtener el mismo
  resultado.

----
<!-- .slide: data-auto-animate -->
## Argumentos como Hash

```ruby
class SongList
  def search(name, params)
  # ...
  end
end
list.search(:titles,
            { :genre              => "jazz",
              :duration_less_than => 270
            })
```

<div class="small">

El primer parámetro indica qué atributo retornar mientras que el segundo es
un hash con el criterio de búsqueda.
</div>

----
<!-- .slide: data-auto-animate -->
## Argumentos como Hash
* Lo incómodo del ejemplo es la necesidad de usar `{}`, además de la posible
  confusión con la posibilidad de que se esté indicando un bloque
* **Una solución:** usar **`clave => valor`** en la lista de
  argumentos siempre que:
  * Sea luego de los argumentos *normales*.
  * Antes de un splat y bloque.
  * Ya no es necesario usar llaves.

----
<!-- .slide: data-auto-animate -->
## Argumentos como Hash
```ruby
# Ruby <= 1.9
list.search(:titles,
            :genre              => 'jazz',
            :duration_less_than => 270)

# Ruby >= 1.9
list.search(:titles, genre: 'jazz', duration_less_than: 270)
```

----
## Keyword arguments

_Solo en Ruby 2.0 o superior_.

Asumimos un supuesto método **`log`**

<div class="container small">

<div class="col">

Keyword arguments

```ruby
def log(msg, level: "ERROR", time: Time.now)
  puts "#{ time.ctime } [#{ level }] #{ msg }"
end



```

</div>
<div class="col">

Usando hash

```ruby
def log(msg, opt = {})
  level = opt[:level] || "ERROR"
  time  = opt[:time]  || Time.now
  puts "#{ time.ctime } [#{ level }] #{ msg }"
end
```

</div>
</div>

```ruby
log("Hello!", level: "INFO")
```

----
<!-- .slide: data-auto-animate -->
## Keyword arguments
* Las cosas parecen simples de reproducir con hashes, pero todo se complica un poco si sucede que:
  * Queremos usar keyword arguments con splat.
  * Lanzar excepciones cuando un argumento no es conocido.

----
<!-- .slide: data-auto-animate -->
## Keyword arguments

Simular keyword arguments con hash:

```ruby
def log(*msgs)
  opt = msgs.last.is_a?(Hash) ? msgs.pop : {}
  level = opt.key?(:level) ? opt.delete(:level) : "ERROR"
  time  = opt.key?(:time ) ? opt.delete(:time ) : Time.now
  raise "unknown keyword: #{ opt.keys.first }" if !opt.empty?
  msgs.each {|msg| puts "#{ time.ctime } [#{ level }] #{ msg }" }
end
```

<div class="small fragment">

*Pero nos gustó preservar la primer versión del ejemplo*
</div>

----
<!-- .slide: data-auto-animate -->
## Keyword arguments

Probamos los argumentos

```ruby
log("Hello")
log("Hello!", level: "ERROR", time: Time.now)
```
<div class="fragment">

Y si cambiamos el orden

```ruby
log("Hello!", time: Time.now, level: "ERROR") 
```
</div>
<div class="fragment">

Cuando enviamos un argumento no conocido

```ruby
log("Hello!", date: Time.new) 
```
</div>

----
<!-- .slide: data-auto-animate -->
## Keyword arguments

Si queremos evitar las excepciones podemos usar <b>`**`</b> para explícitamente
agrupar el resto de los keyword arguments en un hash (como splat).

<div class="fragment">

```ruby
def log(msg, level: "ERROR", time: Time.now, **kwrest)
  puts "#{ time.ctime } [#{ level }] #{ msg }"
end

log("Hello!", date: Time.now) 
```
</div>
----
<!-- .slide: data-auto-animate -->
## Keyword arguments

Una función que considera todos los casos:

```ruby
def f(a, b, c, m = 1, n = 1, *rest, x, y, z, k: 1, **kwrest, &blk)
  puts "a: %p" % a
  puts "b: %p" % b
  puts "c: %p" % c
  puts "m: %p" % m
  puts "n: %p" % n
  puts "rest: [%p]" % rest.join(',')
  puts "x: %p" % x
  puts "y: %p" % y
  puts "z: %p" % z
  puts "k: %p" % k
  puts "kwrest: %p" % kwrest
  puts "blk: %p" % blk
end

f("a", "b", "c", 2, 3, "foo", "bar", "baz", "x", 
  "y", "z", k: 42, u: "unknown") { }
```
----
# Operadores

<div class="main-list">

* ruby
  * conceptos avanzados

</div>
----
## Operadores
* Ya hemos usado los operadores **`+`**, **`-`**, **`*`**, **`/`**, etc
* Estos operadores se implementan como llamadas a métodos

```ruby
a, b, c = 1, 2, 3
a * b + c
# O en forma similar
(a.*(b)).+(c)
```

----
## Redefinir operadores

```ruby
class Integer
  alias old_plus +
  def +(other)
    old_plus(other).succ
  end
end
```

----
## El operador `<<`

<div class="container">

<div class="col small">

```ruby
class ScoreKeeper
  def initialize
    @total_score = 0
    @count = 0
  end

  def <<(score)
    @total_score += score
    @count += 1
    self
  end

  def average
    fail "No scores" if @count == 0
    Float(@total_score) / @count
  end
end
```
</div>
<div class="col">

```ruby
scores = ScoreKeeper.new
scores << 10 << 20 << 40
puts "Average = #{scores.average}"
```
</div>
</div>

----
## El operador  `[]`

```ruby
class SomeClass
  def []=(*params)
    value = params.pop
    puts "Indexed with #{params.join(', ')}"
    puts "value = #{value.inspect}"
  end
end

s = SomeClass.new
s[1] = 2
s['cat', 'dog'] = 'enemies'
```

----
# Expresiones

<div class="main-list">

* ruby
  * conceptos avanzados

</div>

----
## Ejecutar comandos

Podemos usar comillas: **\`**  ó **`%x`** para indicar la ejecución de un comando
en el sistema operativo subyacente:

```ruby
`date`
`ls /bin`.split[34]
%x{echo "Hello there"}
`ip address ls`.
  split("\n").
  select {|x| x =~ / inet / }.
  map do |x|
    x.scan(/((\d{1,3}\.?){4}\/(\d){1,2})/).flatten.shift 
  end
```
----
## Asignaciones

Jugando con splat y asignación en paralelo

```ruby
a, b, c, d, e = *(1..2), 3, *[4, 5] # a=1, b=2, c=3, d=4, e=5

a1, *b1 = 1, 2, 3                   # a1=1, b1=[2, 3]

a2, *b2 = 1                         # a2=1, b2=[]

*a3, b3 = 1, 2, 3, 4                # a3=[1, 2, 3], b3=4

c, *d, e = 1, 2, 3, 4               # c=1, d=[2,3], e=4

f, *g, h, i, j = 1, 2, 3, 4         # f=1, g=[], h=2, i=3, j=4
```

----
## and

El operador **`&&`** y el método **`and`** funcionan similar: _retornan el
primer valor si es falso, sino el segundo_.


```ruby
nil && 99    # => nil
false && 99  # => false
"cat" && 99  # => 99
a = (true and false)
a = true and false # Check a, Why??
```

<div class="small">

Ambos son iguales salvo por la precedencia: _**`and` es de menor precedencia
que `&&`**_.
</div>
----
## or
El operador **`||`** y el método **`or`** funcionan similar: _retornan el
primer valor si es verdadero, sino el segundo_.

```ruby
nil || 99    # => 99
false || 99  # => 99
"cat" || 99  # => "cat"
b = (false or true)
b = false or true # Check b, Why??
```

<div class="small">

_**`or` es de menor precedencia
que `||`**_.
</div>
<div class="small fragment">

Es muy común utilizar la expresión: `||=` para setear un valor si no fue
seteado:

```ruby
var ||= "default value"
```
</div>

----
## Break, Redo y Next

* Podemos alterar el flujo de ejecución de loops 
  * **`break`:** termina en forma inmediata al loop que se encuentra más próximo. El
    control se devuelve a la sentencia siguiente al final del bloque
  * **`redo`:** repite la iteración actual sin evaluar la condición ni trayendo el
    siguiente elemento si fuese un iterador
  * **`next`:** avanza hasta el final del bloque continuando con la siguiente
    iteración

----
## break

```ruby
a = 0
while a < 20 do
  a +=1
  break if a == 10 
  p a 
end
```

----
## redo

<div class="container">
<div class="col"> 

```ruby
a = 0
while a < 20 do
  a +=1
  redo if a == 10 
  p a 
end
```
</div>
<div class="col fragment"> 

```ruby
a = 0
while a < 20 do
  a +=1
  redo if a == 20 
  p a 
end
```
</div>
</div>

----
## next

<div class="container">
<div class="col"> 

```ruby
a = 0
while a < 20 do
  a +=1
  next if a == 10 
  p a 
end
```
</div>
<div class="col fragment"> 

```ruby
a = 0
while a < 20 do
  a +=1
  next if a == 20 
  p a 
end
```
</div>
</div>
