# Intérpretes

<div class="main-list">

* introducción
</div>

----

Ruby como lenguaje, tiene varias implementaciones. La implementación de
referencia es conocida como **MRI: _Matz’s Ruby Interpreter_** o **CRuby**
(porque está desarrollada en C), pero existen otras implementaciones.

----

## MRI

* **Homepage:** https://www.ruby-lang.org/
* Matz' Ruby Implementation
* También llamada CRuby
* Es la implementación de referencia del lenguaje
* Versiones
  * **1.8.x**
  * **1.9.x**
  * **2.x**
  * **3.x** _Ruby 3 will be 3 times faster_<!-- .element: class="fragment" -->

----
## JRuby


* **Homepage:** https://www.jruby.org/
* Ruby en la **JVM de Java**
* Es la alternativa más madura a MRI en términos de compatibilidad con MRI
* Ventajas:
  * Concurrencia real
  * Interoperabilidad con librerías Java

<img src="static/jruby.png" height="200" />

----
## Rubinius

* **Homepage:** https://github.com/rubinius/rubinius
* Comenzó como un experimento que comenzó como una implementación de Ruby, pero
  en realidad apunta a extender las limitaciones de Ruby.
* Su diseño se enfoca en la concurrencia.
* La VM fue escrita en C++

----
## TruffleRuby

* **Homepage:** https://github.com/oracle/truffleruby
* Es una implementación de alta performance de Ruby creada por Oracle.
* Permite correr código en paralelo y el startup de aplicaciones ruby es mucho
  menor.
* Basado en [GraalVM](http://graalvm.org/). 

<img src="static/truffleruby.png" height="200" />
----
## ¿Cómo trabajar con ruby?

* Mayormente la gestión del ambiente de trabajo con ruby se realiza con alguna
  de las siguientes herramientas:
  * [**RVM:** Ruby Version Manager](https://rvm.io/)
  * [**rbenv:** Ruby environment](https://github.com/rbenv/rbenv)
  * [**asdf**](https://asdf-vm.com/) con el plugin [**asdf
    ruby**](https://github.com/asdf-vm/asdf-ruby)
  * _Ruby instalado como paquete del propio sistema no es recomendado._

> El uso, instalación y manejo de los entornos serán abordados en el espacio de
> las prácticas

