
# The Twelve-Factor App


----

## The Twelve-Factor App

<div class="container small">
  <div class="col">

* ¿Qué es?
* I - Código fuente
* II - Dependencias
* III - Configuración
* IV - Servicios
* V - Construir, distribuir, ejecutar

  </div>

  <ul class="col">

* VI - Procesos
* VII - Asignación de puertos
* VIII - Concurrencia
* IX - Desechabilidad
* X - Aproximación entre desarrollo y producción
* XI - Logs
* XII - Procesos de administración

  </ul>
</div>

----

## ¿Qué es?

Esta metodología se enuncia en https://12factor.net y describe un conjunto de
prácticas para construir aplicaciones web o SaaS.

----

## I - Código fuente

* La aplicación debe usar un SCM _-Source Control Management-_ como por ejemplo git.
* Si hay múltiples repositorios de fuentes, es porque se trata de un sistema distribuido y no una aplicación. En tal caso, cada aplicación puede aplicar 12 factor.
* Pueden existir mútiples despliegues.
  * _Depende de los ambientes_.
  * Los fuentes son los mismos en todos los despliegues, salvo por diferencias de versiones.

----

## II - Dependencias

* Declarar y aislar dependencias de forma explícita.
  * _Usando Gemfile, Pipfile, package.json (Yarn, npm), composer.json, Gopkg.toml, pom.xml_.
* Las librerías descargadas por el manejador de dependencias deben poder instalarse en el sistema o bajo un directorio del proyecto (vendor).
* A veces estas dependencias pueden requerir la instalación de librerías o comandos en el sistema base.

----

### III - Configuración

* La configuración de una aplicación es lo único que puede variar entre despliegues de una misma versión en diferentes ambientes:
	* Bases de datos, cachés u otros servicios.
	* Credenciales para servicios externos tales como Amazon S3, APIs, etc.
	* Valores propios del despliegue.
* Guardar constantes de configuración en el código **viola 12 factor**.
	* _La configuración varía entre despliegues, no el código_.
* Se propone utilizar **variables de entorno**.

----

## IV - Servicios

* Tratar los servicios como recursos conectables:
	* Bases de datos (no)SQL.
	* SMTP.
	* Colas como ZeroMQ, RabbitMQ, ActiveMQ.
* Deben poder configurarse mediante URLs o variables de entorno.
* Ser fácilmente reemplazables.

----

### V - Construir, distribuir, ejecutar

<div class="small">

* Separar siempre la etapa de construcción de ejecución.
* Los fuentes se transforman en un despliegue al completarse las etapas de:
	* **Construcción:** compilación del código en binarios ejecutables o intermedios.
		* _No aplica a lenguajes interpretados. **Sí para docker**_.
	* **Distribución:** preparado de un paquete listo para ser desplegado.
	* **Ejecución:** etapa que se instancia luego del despliegue en un ambiente.

> Hay relación entre entrega continua (construcción y distribución) y despliegue
> continuo (ejecución).

</div>

----

### V - Construir, distribuir, ejecutar
* Las herramientas de despliegue como por ejemplo [caspitrano](https://capistranorb.com/), realizan la distribución en directorios diferentes que son referenciados con links simbólicos.
* La fase de ejecución controla los procesos de la aplicación que permiten su
  funcionamiento.
	* Generalmente se delega en algún manejador de procesos como systemd, upstart, init-scripts, supervisord, etc.

----

## VI - Procesos

* Ejecutar la aplicación como uno o más procesos sin estado.
* Los procesos que componen una aplicación 12 factor **no tienen estado y no
  comparten nada**.
  * Cualquier información que deba persistirse debe utilizar algún servicio que
  permite almacenar el estado (por ejemplo bases de datos, NFS, S3).

----

## VI - Procesos

* Los compresores de assets, se recomiendan que se apliquen en la **fase de
  construcción** en vez del momento de ejecución.
  * Esto responde algunas cuestiones acerca de cómo armar un `Dockerfile`.
* El uso de sticky sessions asumen que alguna aplicación guarda datos que no
  son sin estado, por ejemplo en memoria. **Esto viola 12 factor app**.
  * Tratar de usar caches como Memcached o Redis.
  * O usar cookies firmadas como session store. _Ver explicación en la 
  [documentación de Ruby on Rails](https://api.rubyonrails.org/v6.0.3.3/classes/ActionDispatch/Session/CookieStore.html)_.

----

## VII - Asignación de puertos

* Publicar servicios usando puertos diferentes.
* Las aplicaciones 12 factor son autocontenidas, esto es, no dependen de un web
  server o application server en ejecución para crear un servicio web público.
  * Analogía con docker.

----

## VIII - Concurrencia

* Escalar mediante el modelo de procesos.
* Según el lenguaje, el modelo de procesos varía:
	* PHP, Ruby y ¿Python? utiliza preforks (no threads). Los últimos por GIL.
	* Go y Java explotan el uso de threads.

----

## VIII - Concurrencia

* Los modelos de procesos muestran su potencial a la hora de escalar.
* Al ser cualquier 12 factor app una aplicación que no comparte nada, sin
  estado, el escalamiento horizontal es simple y confiable.
* Los procesos nunca deberían ser daemons. Deben correr en foreground.
  * Ver este post acerca de no usar daemons llamado: _[Don't daemonize your
  daemons!](https://www.mikeperham.com/2014/09/22/dont-daemonize-your-daemons/)_.

----

## VIII - Concurrencia

Cuando una aplicación debe atender procesos lentos, es aconsejable utilizar
threads. Cuando esto no es posible, se aconseja utilizar procesos fuera de
banda como es el caso de:

* [EventMachine](https://github.com/eventmachine/eventmachine) / [Sidekiq](https://sidekiq.org/)
* [Twisted](https://twistedmatrix.com/trac/) /
  [Celery](https://docs.celeryproject.org)
* [NodeJS](https://nodejs.org/en/)
* [Vertx](https://vertx.io/)

----

## IX - Desechabilidad

* Si los sistemas inician rápido y su muerte (kill) es segura, el sistema se vuelve robusto.
* Los procesos de una aplicación 12 factor debe ser desechables.

----

### X - Aproximación entre dev y ops

* Mantener todos los ambientes lo más similares que sea posible entre ambientes.
* Evitar las diferencias de ambientes considerando:
	* **Diferencias de tiempo:** evitar que el desarrollo de un feature no se suba al repositorio de fuentes en períodos largos de tiempo.
	* **Diferencias de personal:** el despliegue lo hacen operadores y lo desarrollan programadores. Unificar roles.
	* **Diferencias de herramientas:** producción usa Postgres y desarrollo SQLite.

----

### X - Aproximación entre dev y ops

Las aplicaciones 12 factor deben estar preparadas para realizar despliegues
continuo.

Hoy es muy común utilizar diferentes servicios como parte de un desarrollo. El
armado del ambiente para desarrollo se simplifica utilizando herramientas como
**docker**, **docker-compose** o **vagrant**.

----

## XI - Logs

Una aplicación 12 factor nunca se preocupa del direccionamiento, almacenamiento
o rotación de logs. 

En general debe escribir los logs en **stdout** y **stderr**.

----

### XII - Procesos de administración

* Hace mención a tareas de gestión de la aplicación:
  * Correr migraciones de la base de datos _-schema migrations-_.
  * Aplicar algún parche.
  * Iniciar una consola REPL.
* Estas tareas deben ejecutarse en un entorno similar al que ejecuta la
  aplicación habitualmente.

