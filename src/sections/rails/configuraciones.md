# configuraciones

<div class="main-list">

* rails

</div>
----
<!-- .slide: data-auto-animate -->
## Configuraciones

* Rails es conocido por su lema: **convention over configuration**
  * Al aplicarlo, se reducen muchas configuraciones.
  * No todas las configuraciones pueden eliminarse.
  * Las aplicaciones requieren credenciales o API keys para poder funcionar.
* El versionado con **git** debe evitar el guardado de estas credenciales.
----
<!-- .slide: data-auto-animate -->
## Configuraciones
<div class="small" >

* Una buena práctica es usar variables de entorno dado que:
  * La soportan todos los SO, PaaS como Heroku y otras
    plataformas de deployment como Swarm y Kubernetes.
  * Obviamente que las variables de ambiente pueden accederse desde ruby.
  * Mantienen la privacidad del proyecto de forma independiente.
  * La gema **[figaro](https://github.com/laserlemon/figaro)** permite setear
    variables desde el shell o desde un archivo de configuración
  * La gema **[dotenv-rails](https://github.com/bkeepers/dotenv)** permite setear
    variables desde un archivo `.env` en `ENV`
* A partir de rails 5.2 aparecen [Rails
  credentials](https://edgeguides.rubyonrails.org/security.html#custom-credentials)
</div>
----
## Cómo usar env vars

* Las variables de entorno se usan mediante la constante **ENV**.
* Supongamos que se necesita configurar en alguna parte de nuestra aplicación,
  un servidor de mail:

<div class="small">

```ruby
config.action_mailer.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: ENV["DOMAIN_NAME"],
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: ENV["GMAIL_USERNAME"],
  password: ENV["GMAIL_PASSWORD"]
}
```

<div class="fragment" >

_¿De qué forma seteamos los valores **`DOMAIN_NAME`**, **`GMAIL_USERNAME`** y
  **`GMAIL_PASSWORD`**?_
</div>
</div>

----
<!-- .slide: data-auto-animate -->
## Cómo usar figaro

Agregamos al `Gemfile`

```ruby
gem "figaro", git: "https://github.com/laserlemon/figaro"
```

Instalamos la gema con bundler

```bash
bundle install
```

> No han actualizado la gema en rubygems

----
<!-- .slide: data-auto-animate -->
## Cómo usar figaro

* Esta gema setea las variables de entorno antes de hacer cualquier otra cosa.
* Los valores se leen desde un archivo: **`config/application.yml`**.
* Al instalar figaro, se crea el archivo **`config/application.yml`** y
  modificará **`.gitignore`** para ignorar esta configuración.
* La gema entra en acción cuando se ejecute: **`bundle exec figaro install`**.

----
<!-- .slide: data-auto-animate -->
## Cómo usar figaro

Completamos la instalación con:

```bash
bundle exec figaro install
```

Editamos `config/application.yml`

```yaml
GMAIL_USERNAME: mygmailusername
GMAIL_PASSWORD: mygmailpassword
development:
  GMAIL_USERNAME: otherusername
  GMAIL_PASSWORD: otherpassword
```

> Probar con `rails console [-e production]`, imprimiendo
> `ENV['GMAIL_USERNAME']`

----

## Rails credentials

* A partir de rails 5.2, al crear una aplicación rails se crea **`config/credentials.yml.enc`**.
* Las credenciales en este archivo se editan usando **`rails
  credentials:edit`**:
  * Este comando generará si no existe una _**clave maestra**_.
  * Con este comando podremos editar `credentials.yml.enc` y versionarlo de
    forma segura.
  * Nunca debemos versionar la clave maestra.
----

## Ejemplo credentials

<div class="small">

* Si usamos **`rails credentials:edit`** manejamos una configuración con todos
  los parámetros de cada ambiente en forma jerárquica.
* Si usamos **`rails credentials:edit --environment development`** tendremos un
  par de archivos por ambiente: 
  * **`config/credentials/development.yml.enc`**
  * **`config/credentials/development.key`**

**Usamos desde rails las credenciales de la siguiente forma:**

```ruby
Rails.application.credentials[:some_key] # Only specific value
Rails.application.credentials.config # all configured values
```

</div>
