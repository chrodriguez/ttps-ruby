# introducción

<div class="main-list">

* active record

</div>
----
<!-- .slide: data-auto-animate -->
## Introducción

* Conecta clases a tablas de una base de datos estableciendo una capa de
  persistencia.
* La librería provee una clase base que al heredarse, mapea la nueva clase
  con una tabla existente de una base de datos.
* En el contexto de una aplicación a estas clases se las llama **modelos**.
* Los modelos pueden conectarse con otros modelos usando **asociaciones**.
----
<!-- .slide: data-auto-animate -->
## Introducción

* Se basa en convenciones de nombres de forma tal que utiliza el
  nombre de una clase o asociación para establecer mapeos con tablas
  de la base de datos y claves foráneas.
* A pesar de poder definir estos mapeos en forma explícita, es muy
  recomendable seguir las convenciones de nombres, especialmente durante el
  aprendizaje de la librería.
----
## ORM

* Object Relational Mapping (ORM) es una técnica que conecta objetos de una
  aplicación a tablas de un RDBMS. 
* Utilizando ORM, las propiedades y relaciones de los objetos en una aplicación
  pueden ser fácilmente almacenados y recuperados de una base de datos **sin**
  escribir SQL directamente, minimizando el código de base de datos.

----
## AR como Framework de ORM

* Representa modelos y sus datos.
* Representa asociaciones entre los modelos.
* Representa herencia entre modelos.
* Validaciones de modelos antes de ser persistidos.
* Operaciones de bases de datos de forma orientada a objetos.

----
## CoC

_Conventioin over Configuration_

* Si se siguen las convenciones adoptadas por Rails, será
  necesario escribir muy pocas configuraciones (en algunos casos ninguna
  configuración) para crear modelos.
* La configuración explícita será necesaria sólo cuando no pueda seguirse la
  convención estándar.

----
## Ejemplo

Active Record mapea automáticamente entre tablas y clases, atributos y
columnas:

<div class="small container">

<div class="col">

```ruby
class Product < ActiveRecord::Base
end
```

La clase **`Product`** se mapea automáticamente a la tabla llamada **`products`**


</div>
<div class="col">

```sql
CREATE TABLE products (
  id int(11) NOT NULL auto_increment,
  name varchar(255),
  PRIMARY KEY  (id)
);
```
</div>
</div>
<div class="fragment small">

Además se definen accessors para cada campo. En el ejemplo serían **`name`** y
**`name=`**.

[Acceso a un ejemplo
completo](https://github.com/ttps-ruby/ttps-ruby.github.io/tree/master/ejemplos/ar/00-introduccion)
</div>
----
## Convenciones de nombres

Los nombres de las clases se pluralizan para encontrar las tablas
* **`Book`** se mapea a **`books`** 
* El mecanismo de pluralización puede tanto pluralizar como singularizar 
  palabras regulares como irregulares.
* Cuando un modelo utiliza más de una palabra las clases utilizan **CamelCase** 
  y las tablas **snake_case**. Por ejemplo: la clase **`BookClub`** se mapeará con
  la tabla **`book_clubs`**.

----
## Ejemplo de mapeos

<div class="small">

Las definiciones de estos mapeos son mediante otra gema llamda
**`ActiveSupport`**.

| Modelo / Clase | Tabla / Schema|
|----------------|---------------|
| Post           | posts         |
| LineItem       | line_items    |
| Deer           | deers         |
| Mouse          | mice          |
| Person         | people        |

<div class="fragment">

Ver [ActiveSupport::Inflector](http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html)

```
irb -r active_support/all
ActiveSupport::Inflector.pluralize 'person'
```

</div>
</div>
----
<!-- .slide: data-auto-animate -->
## Convenciones

Active Record utiliza convenciones para las columnas de las tablas,
dependiendo del propósito de estas columnas.
----
<!-- .slide: data-auto-animate -->
## Convenciones

* **Claves foráneas:** deben llamarse de la siguiente forma:
  **`nombre_en_singular_id`** (por ejemplo: `item_id`, `order_id`). Estos serán
  los campos por los que AR buscará cuando se creen asociaciones entre
  modelos.
* **Claves primarias:** por defecto, AR utilizará una columna de
  tipo entero llamada **`id`** como clave primaria. Cuando se usan *Migraciones de
  AR* para crear las tablas, esta columna se creará automáticamente.

----
<!-- .slide: data-auto-animate -->
## Convenciones

* **`created_at`:** esta columna automáticamente setea la fecha y hora cuando el
  registro es creado.
* **`updated_at`:** esta columna automáticamente setea la fecha y hora cuando el
  registro es actualizado.
* **`lock_version`:** agrega [optimistic
  locking](http://api.rubyonrails.org/classes/ActiveRecord/Locking/Optimistic.html) al modelo
* **`type`:** especifica que el modelo utiliza [Single Table
  Inheritance](http://api.rubyonrails.org/classes/ActiveRecord/Base.html#label-Single+table+inheritance).
----
<!-- .slide: data-auto-animate -->
## Convenciones

* **`(association_name)_type`:** especifica el tipo de [asociaciones
  polimórifcas](http://edgeguides.rubyonrails.org/association_basics.html#polymorphic-associations).
* **`(table_name_plural)_count`:** usado para cachear el número de registros que pertenecen
  a una asociación. Por ejemplo, una columna `comments_count` en la clase `Post` que tiene muchas instancias de `Comment`, cacheará el número de comentarios existentes para cada post.

----
## Ejemplo más completo

* Usaremos herencia (STI). Para ello la superclase **debe tener(** un campo **`type`**.
* Activamos logs de AR con **`ActiveRecord::Base.logger`**
* Mostraremos además el uso de cache de una asociación. Para ello se habilita 
  creando un campo **`asociacion_en_plural_count`** y agregando un modificador
  a la asociación: **`belongs_to` llamado `counter_cache: true`**

<div class="small">

[Ver ejemplo](https://github.com/TTPS-ruby/ttps-ruby.github.io/tree/master/ejemplos/ar/01-sti-logs-cache)
</div>
