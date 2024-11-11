# gemas

<div class="main-list">

* rails

</div>
----
<!-- .slide: data-auto-animate -->

## Las Gemas de Rails
* Rails en sí es una gema que requiere un conjunto de otras gemas:
  * Esto puede verse en [Rubygems](https://rubygems.org/gems/rails)
* Las gemas que depende rails son varias. A continuación las analizamos.
----
<!-- .slide: data-auto-animate -->
## Las Gemas de Rails
<div class="small">

* **[actioncable](https://github.com/rails/rails/tree/master/actioncable):**
  integra websockets con rails.
* **[actionmailbox](https://github.com/rails/rails/tree/master/actionmailbox):**
  ruteo de mail entrante del estilo de controlador para su procesamiento en
  rails.
* **[actionmailer](https://github.com/rails/rails/tree/master/actionmailer):**
  delivery de mails y testing.
* **[actionpack](https://github.com/rails/rails/tree/master/actionpack):**
  responsable del manejo de requerimientos y respuestas HTTP. Se encarga del
  ruteo mapeando URLs en acciones mediante controladores. Las respuestas se
  generan a partir de vistas. _Corresponde al V y C del paradigma MVC_.
* **[actiontext](https://github.com/rails/rails/tree/master/actiontext):**
  manejo de texto enriquecido y su edición en rails.
* **[actionview](https://github.com/rails/rails/tree/master/actionview):**
  responsable del templating de vistas y su renderización.Integra helpers que
  asisten en la construcción de respuetas.
* **[activejob](https://github.com/rails/rails/tree/master/activejob):**
  manejo de tareas asíncronas agnóstico del backend de manejo de colas.
* **[activemodel](https://github.com/rails/rails/tree/master/activemodel):**
  provee módulos con funcionalidades similares a las presentes en AR. De esta
  forma, actionpack puede utilizar ActiveModels como objetos AR de forma
  indiferente dando independencia del ORM que podría se personalizado.
</div>
----
<!-- .slide: data-auto-animate -->
## Las Gemas de Rails
<div class="small">

* **[activerecord](https://github.com/rails/rails/tree/master/activerecord):**
  framework para la abstracción de la bases de datos. _Un ORM que representa la
  M de MVC_.
* **[activestorage](https://github.com/rails/rails/tree/master/activestorage):**
  simplifica el upload y gestión de archivos en proveedores de cloud mediante
  referencias. Se integra fácilmente con [AWS S3](https://aws.amazon.com/s3/),
  [Google Cloud Storage](https://cloud.google.com/storage/docs/), [Microsoft Azure
  Storage](https://azure.microsoft.com/en-us/services/storage/), almacenando las
  referencias correspondientes en AR. Soporta además un servicio principal y
  otros como espejos para ofrecer redundancia. Puede usarse localmente para
  deployment locales o desarrollo, pero su foco principal está en storage en la
  nube.
* **[activesupport](https://github.com/rails/rails/tree/master/activesupport):**
  extensiones a Ruby y clases que proveen mayor funcionalidad.
* **[bundler](http://gembundler.com/):** gestión de dependencias.
* **[railties](https://github.com/rails/rails/tree/master/railties):** se encarga del
  [bootstrap de aplicaciones rails](https://guides.rubyonrails.org/initialization.html)
  (cuando usamos `rails server`),  comandos de consola y generadores.
* **[sprockets-rails](https://github.com/rails/sprockets-rails):** implementa el
  assets pipeline basado en [Sprockets](https://github.com/rails/sprockets).

<div>
----
<!-- .slide: data-auto-animate -->
## Las Gemas de Rails

_Estas gemas a su vez tienen dependencias, dando un total de aproximadamente 100
gemas_.

----
## Otras gemas

<div class="small">

Además de la gema de rails, el comando **`rails new`** agrega otras gemas:

<div class="container">

<div class="col">

* sqlite3
* puma
* stimulus-rails
* turbo-rails
* jbuilder
* tzinfo-data

</div>
<div class="col">

* development:
  * brakeman
  * web-console
  * debug
* test:
  * capybara
  * selenium-webdriver

</div>
</div>
</div>

----
## Gemas externas

Gemas que podemos utilizar para implementar ciertas funcionalidades de forma más
cómoda:

* **[simple_form](https://github.com/heartcombo/simple_form):** simplifica el
  uso de forms.
* **[ransack](https://github.com/activerecord-hackery/ransack):** busquedas
  simples.
* **[kaminari](https://github.com/kaminari/kaminari):** pager de modelos.
* **[lograge](https://github.com/roidrage/lograge):** normaliza los logs.
* **[devise](https://github.com/heartcombo/devise):** solución de autenticación
  flexible.
* **[cancancan](https://github.com/CanCanCommunity/cancancan):** librería de
  autorización
