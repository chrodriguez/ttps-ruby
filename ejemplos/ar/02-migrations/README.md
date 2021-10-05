# Ejemplo de migraciones de AR

En este ejemplo, mostramos de forma aislada (independiente del framework Rails) el uso de migraciones en ActiveRecord.

Para ello, primero debemos instalar las dependencias mencionadas en el [`Gemfile`](./Gemfile):

```bash
bundle
```

> Podemos observar que se utilizan tres gemas: activerecord y sqlite3 conectan
> ar con un driver de base de datos, el de sqlite. Por otro ladola gema standalone_migrations es la que ofrece el uso de migraciones sin utilizar rails.

## Uso de standalone_migrations

Para conocer bien la gema [**standalone_migrations**](https://github.com/thuss/standalone-migrations) se recomienda leer su documentación.

En este caso, nosotros ya proveemos un [`Rakefile`](./Rakefile) que como indica
la documentación de la gema, debemos modificar.  Con esto configurado, ya
podemos investigar qué comandos rake disponemos usando:

```bash
rake -T
```
> La opción `-T` lista todas las tareas rake disponibles

### Elimina una db previamente creada

```bash
rake db:drop
```

### Crea la base de datos

```bash
rake db:create
```

### Agrega una nueva migración

```bash
rake db:new_migration name=create_table_person
```

### Corre las migraciones

```bash
rake db:migrate
```

### Deshace una o más migraciones

```bash
rake db:rollback
```

## Ejemplo de uso

Una secuencia de uso habitual podría ser:

```bash
rake db:drop db:create db:migrate

# Revisamos la tabla
echo .schema publications | sqlite3 db/development.sqlite3

# Creamos una tabla y una referencia de publications a author
rake db:new_migration name=createAuthors options="firstname:string lastname:string"
rake db:new_migration name=addAuthorRefToPublications options=author_id:integer:index
rake db:migrate

# Revisamos las tablas
echo .schema publications | sqlite3 db/development.sqlite3
echo .schema authors | sqlite3 db/development.sqlite3
```

