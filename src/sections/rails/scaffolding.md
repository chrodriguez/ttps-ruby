# scaffolding

<div class="main-list">

* rails

</div>
----
## Scaffolding

El concepto de scaffold lo utilizan varios frameworks para simplificar la
generación de código a partir de templates parametrizables que
aceleran la generación inicial de CRUD para modelos. Luego se podrá construir a
partir de estos templates personalizando con código.

Rails, tiene un potente mecanismo de scaffolding que nos permitirá ir armando un
proyecto rails de forma simple y automática.

----

## ¿Qué automatiza rails?

La generación de:

* Modelos a partir de migraciones y el código ruby asociado.
* Controladores y rutas que implementan CRUD.
* Vistas que materiaizan las funciones requeridas en cualquier CRUD.

----
<!-- .slide: data-auto-animate -->

## Ejemplo

```bash
rails generate scaffold books
```

El comando generará:

* `BooksController`
* El modelo para `Book`
* Una entrada en `config/routes.rb` para [`resources :book`](https://guides.rubyonrails.org/routing.html#resources-on-the-web)
* Tests asociados
* Vistas para cada acción del controlador bajo la carpeta `app/views/books`

----
<!-- .slide: data-auto-animate -->
## Ejemplo

Lo probamos accediendo a:

[http://localhost:3000/books](http://localhost:3000/books)

y veremos que....

<div class="fragment">

Primero debemos correr las migraciones

```bash
rails db:migrate
```
</div>
<div class="fragment">


**¡¡los libros no tienen campos!!**
</div>

----

## Scaffold con campos

Para mejorar nuestro ejemplo, desharemos lo que hicimos y luego volveremos a
correr el comando pero especificando algunos campos.

**Eliminar lo generado por el scaffold**

```bash
rails db:rollback
rails destroy scaffold books
```

**Crear un nuevo scaffold con campos**

```bash
rails generate scaffold books \
  title:string author:string publication_year:integer
```
----
## Otros generators

Rails provee generators para las diferentes componentes:

```bash
rails generate model Fruit name:string color:string
rails generate controller Fruit
rails generate resource post title:string body:text \
  published:boolean
```

----
<!-- .slide: data-auto-animate -->
## Las rutas

Es importante entender cómo los controladores funcionan en relación con las
rutas de rails. Podemos analizar entonces, luego de haber creado diferentes
rutas usando los generators, vemos que tenemos en `config/routes.rb`

```ruby
Rails.application.routes.draw do
  resources :posts
  resources :books

  root to: 'visitors#new'
end
```

----
<!-- .slide: data-auto-animate -->

## Las rutas

Con el comando `rails routes` podemos ver cómo se expanden esas rutas:

```
rails routes --help
rails routes -c posts
rails routes -E -c posts
```

----
## Analizando las rutas

<div class="small">

En el ejemplo anterior, vemos que aparece `resources :xxxx`. Esto define siete
acciones para implementar CRUD usando veebos HTTP. Si el recurso es `photos`
entonces tendremos:


 | Verbo HTTP | Path | Controller#Action | ¿Qué hace? | 
 | --------- | ---- | ----------------- | -------- | 
 | GET | `/photos` | `photos#index` | Listado de fotos |
 | GET | `/photos/new` | `photos#new` | Formulario para crear una nueva foto |
 | POST | `/photos` | `photos#create` | Crea la foto |
 | GET | `/photos/:id` | `photos#show` | Muestra una foto determinada |
 | GET | `/photos/:id/edit` | `photos#edit` | Formulario para editar una foto |
 | PATCH/PUT | `/photos/:id` | `photos#update` | Actualiza la foto |
 | DELETE | `/photos/:id` | `photos#destroy` | Elimina una foto |

</div>
----

## Posibilidades con las rutas

* Especificar múltiples recursos al mismo tiempo: `resources :photos, :books,
  :videos`
* Rutas singulares: 
  * **`get 'profile', to: 'users#show'`**
  * **`resoruces :photo`** genera seis acciones (no incluye el list)
* Pueden anidarse para por ejemplo CRUD de un modelo que esté relacionado. Por
  ejemplo como sucedería por ejemplo en un modelo `Person` que tiene asociado
  `Pet`. Es posible tener rutas como **`/people/:id/pets/new`**


----
### ¿Y cómo sé la url de una ruta?

<div class="small">

Al crear una ruta usando resource, se generan además una serie de helpers que
pueden usarse en el controller y vistas, como por ejemplo para `:photos`
tenderemos entonces:


* **`photos_path`:** retornará /photos
* **`new_photo_path`:** retornará /photos/new
* **`edit_photo_path(:id)`:** retornará /photos/:id/edit (entonces, `edit_photo_path(10)` retornará /photos/10/edit)
* **`photo_path(:id)`:** retornará /photos/:id (entonces, `photo_path(10)` retornará /photos/10)

> Los mismos helpers con sufijo `_url` en vez de `_path` proveen URLs absolutas 

</div>

----
### Ruteo en rails

La mejor forma de aprender todas las capacidades del ruteo en rails, es
recomendable leer [Rails Routing from the Outside In](https://guides.rubyonrails.org/routing.html).
