# introducción

<div class="main-list">

* rails

</div>
----
## Cómo funciona la web

* Contenidos: _HTML, imágenes, CSS, JS_.
* Contenidos estáticos.
* Contenidos dinámicos:
  * Porque se conecta a una DB o servicio.
  * Para simplificar el armado de la respuesta usando _partials_.
----
## Qué es rails
* Conjunto de estructuras y convenciones.
* Es una librería o conjunto de gemas.
* Al usar rails,  estaremos usando prácticas estándar que simplificarán la
  colaboración y el mantenimiento del código.
* Promueve [Separation of Concerns (SoC)](http://en.wikipedia.org/wiki/Separation_of_concerns),
  lo cual permite obtener programas modulares y mantenibles.
* El principal patrón de diseño que implementa es MVC.

<div class="small fragment">

Al igual que con otros frameworks.
</div>

----
## Stack tecnológico

<div class="small" >

Conjunto de tecnologías o librerías utilizadas para desarrollar una aplicación.

* Un stack productivo podría ser:
    * Linux
    * WEB Server:
      * Apache / NGINX
      * PHP/Python/Ruby
    * MariaDB/Postgres
* Para el desarrollo con rails generalmente es:
    * Mac/Linux/Windows
    * Puma/Unicorn
    * SQLite/MariaDB/Postgres
    * Ruby
</div>
----
## El stack de rails

* Un clásico stack de rails será:
  * ERB for view templates
  * MySQL for databases
  * MiniTest for testing
* Una alternativa:
  * Haml for view templates
  * PostgreSQL for databases
  * Rspec for testing

<div class="small">

Las componentes podrán intercambiarse fácilmente, habiendo múltiples
alternativas. Seguir las tendencias o componentes populares es una buena
elección
</div>

----
## Ayuda


* Google: pero considerar resultados actuales
* [Stack Overflow](http://stackoverflow.com/questions/tagged/ruby-on-rails)
* [Rails Guides](http://guides.rubyonrails.org/)
* [Rails Documentation](http://api.rubyonrails.org/)
* [Rails Begginer Chat Sheet](http://pragtob.github.io/rails-beginner-cheatsheet/index.html)
  alguno podría ser útil_.
----
## Mantenerse actualizado

* [Ruby on rails weblog](https://weblog.rubyonrails.org/)
* [Ruby Weekly](http://rubyweekly.com/)
* [Ruby Flow](http://www.rubyflow.com/)
* [Changelog Rails](https://changelog.com/topic/rails)
* [Go Rails](https://gorails.com/episodes)

----
## Instalando rails


<div class="container">

<div class="col fragment">

```bash
gem install rails
```
</div>
<div class="col fragment">

```bash
rails -v
```

</div>
</div>
<div class="small fragment">

* Es importante saber que disponemos de mensajes de ayuda para cada comando
  rails usando **`--help`**.
* Rails provee el comando `rails new` para crear una aplicación Rails básica
</div>

<div class="fragment">

```bash
rails new --help
```
</div>

<div class="small fragment">

> * La ayuda puede parecer extensa pero es importante leer las alternativas
>   propuestas.
> * No usaremos ninguna opción en esta primer instancia.
> * Como resultado de la ejecución, se creará un directorio con carpetas y
>   archivos en ella.

</div>
