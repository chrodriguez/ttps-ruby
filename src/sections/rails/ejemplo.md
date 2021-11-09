# ejemplo

<div class="main-list">

* rails

</div>
----
## Home dinámica

_Planificamos nuestro trabajo definiendo un User story que llamaremos **Birthday countdown**_

* As a visitor to the website
  * I want to see the owner's name
  * I want to see the owner's birthdate
  * I want to see how many days until the 
  *   owner's next birthday
  * In order to send birthday greetings

----
## La elección de nombres

<div class="small">

* Mucho en el arte de la programación radica en elegir nombres correctos para
  nuestras creaciones.
* Necesitamos un modelo que represente el site owner.
  * Elegiremos el nombre más obvio: **`Owner`** y creamos el archivo **`app/models/owner.rb`**.
* Para el controlador consideramos el **User Story** y por ello tomamos el
  nombre **`VisitorsController`** considerando que **visitor** es el actor.
  * Creamos entonces **`app/controllers/visitors_controller.rb`**.
</div>
----
<!-- .slide: data-auto-animate -->

## Convenciones de nombres


* En rails es **importante** el nombre de los archivos y clases definidas en
  ellos.
* Esto se debe al principio **CoC** evitando configuraciones innecesarias.
----
<!-- .slide: data-auto-animate -->

## Convenciones de nombres

**Modelos en singular usando camelcase:**

```ruby
class Visitor < ActiveRecord::Base
```

**Controladores en plurar y camelcase:**

```ruby
class VisitorsController < ApplicationController
```
> Terminan en **`Controller`**
----
<!-- .slide: data-auto-animate -->

## Convenciones de nombres

* Los archivos de modelo coinciden con el nombre del modelo pero en
  minúscula: **`app/models/visitor.rb`**.
* Los archivos de controlador coinciden con la clase: **`app/controllers/visitors_controller.rb`**.
* La **_carpeta de las vistas_** coinciden con el nombre del controlador
  pero sin el sufijo controller: **`app/views/visitors`**.

> Siempre se utiliza snake case
----
## Ruteo

Crearemos primero el ruteo antes de implementar el modelo y controlador. Editamos
entonces **`config/routes.rb`**

```ruby
Rails.application.routes.draw do
  root to: 'visitors#new'
end
```

> La sintaxis de este archivo puede verse a partir del documento: [Routing from outside in](http://guides.rubyonrails.org/routing.html).
> 
> Modificando **`config/routes.rb`** no requiere reiniciar.

----
## Primer prueba

Acceder a [http://localhost](http://localhost:3000)

<div class="fragment">

Esperamos obtener un error indicando:

**uninitialized constant VisitorsController**

Lo cual es lógico considerando que no hemos implementado dicha clase.

</div>
----
## El modelo

* La mayoría de los modelos rails obtienen datos desde una base de datos.
* Cuando se utiliza una base de datos, es posible usar el comando: **`rails
  generate model`** para crear un modelo que hereda de **`ActiveRecord`**.
* Para este ejemplo no necesitamos una base de datos: _nuestra clase simplemente
  definirá los métodos necesarios_.

----
<!-- .slide: data-auto-animate -->
## El Modelo

<div class="small">

```ruby
class Owner
  def name
    'Foobar Kadigan'
  end

  def birthdate
    Date.new(1990, 12, 22)
  end

  def countdown
    today = Date.today
    birthday = Date.new(today.year, 
            birthdate.month, 
            birthdate.day)
    if birthday > today
      countdown = (birthday - today).to_i
    else
      countdown = (birthday.next_year - today).to_i
    end
  end

end
```

</div>

----
## La Vista

* Como ya mencionamos en las convenciones de nombres, las vistas se guardan en
  **`app/views/`**.
* En una aplicación convencional, un controlador puede renderizar múltiples
  vistas, por lo tanto se crea un directorio para cada controlador.

**Creamos el directorio**

```bash
mkdir app/views/visitors
```

----
<!-- .slide: data-auto-animate -->
## La Vista

**Creamos `app/views/visitors/new.html.erb`**

```html
<h3>Home</h3>
<p>Welcome to the home of <%= @owner.name %>.</p>
<p>I was born on <%= @owner.birthdate %>.</p>
<p>Only <%= @owner.countdown %> days until my birthday!</p>
```


----
<!-- .slide: data-auto-animate -->
## La Vista
* Tenemos únicamente la vista **new** para el controlador **visitors**.
* La extensión es **`erb`** porque usamos el motor ERB para armar nuestros
  templates.
* En la vista, podemos ver que el markup de ERB utiliza los tags **`<%=`** y
  **`%>`**

----
<!-- .slide: data-auto-animate -->
## La Vista

Por defecto en rails se utiliza ERB, pero es posible utilizar gemas que
proveen alternativas como por ejemplo [Slim](http://slim-lang.com/). 
Si usáramos **slim** la vista sería **`new.html.slim`**.

```
h3 Home in slim

p  Welcome to the home of #{@owner.name}

p I was born on #{@owner.birthdate}.

p Only #{@owner.countdown} days until my birthday!
```

> Debe incluirse la gema `slim-rails` y éste ser el único template dador que por
> defecto tiene prioridad erb.


----
<!-- .slide: data-auto-animate -->

## La Vista
El acceso a los datos del modelo **Owner** se hace a través de **`@owner`**

**Podríamos preguntarnos por qué usar:**

<div class="small">

```erb
<%= @owner.countdown %>
```
</div>

en vez de

<div class="small">

```erb
<%= (Date.new(today.year, @owner.birthdate.month, @owner.birthdate.day) - Date.today).to_i %>
```
</div>

> Podríamos hacerlo, pero violaríamos SoC

----
<!-- .slide: data-auto-animate -->
## El controlador

* Será el *pegamento* entre el modelo Owner y la vista **`VisitorsController#new`**.
* Cuando hagamos referencia a una acción en un controlador, usaremos la
  notación **VisitorsController#new** uniendo el nombre de la clase del
  controlador con el de la acción (que es un método). En este contexto, el
  caracter **#** es una convención usada en la documentación.
* El nombre de la clase será **`VisitorsController`** pero el nombre del archivo
  **`visitors_controller.rb`**


----
<!-- .slide: data-auto-animate -->
## El controlador


**Creamos `app/controllers/visitors_controller.rb`**


```ruby
class VisitorsController < ApplicationController
  def new
    @owner = Owner.new
  end
end
```

----

<!-- .slide: data-auto-animate -->
## El controlador

**¿Qué hace?**

* Al ser subclase de **`ApplicationController`** hereda todo el comportamiento
  definido por la API de rails.
* Solo implementa el método **`new`**
* Creamos una variable de instancia **`@owner`** dado que en la vista
  correspondiente estará disponible.

----
## El controlador y la vista

<div class="small">

* Ya creamos una vista llamada **`app/views/visitors/new.html.erb`**.
* El controlador es muy simple dado que el comportamiento oculto que invoca la
  vista **`new`** es heredado de la API de rails.
  * Podemos hacer explícita esta relación

**Indicando qué vista usar en el controlador**

</div>

```ruby
class VisitorsController < ApplicationController
  def new
    @owner = Owner.new
    render 'visitors/new'
  end
end
```

