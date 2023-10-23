# migraciones

<div class="main-list">

* active record

</div>
----
## ¿Qué son las migraciones?

* Son una implementación de [schema migrations](https://en.wikipedia.org/wiki/Schema_migration).
* Las migraciones son una DSL para el manejo de esquemas de bases de datos
  llamados migraciones
* Las migraciones se almacenan en archivos que son ejecutados contra una base de
  datos soportada por Active Record usando `rake`

----
<!-- .slide: data-auto-animate -->
## Migraciones

Ejemplo de una migración que crea una tabla

<div class="small">

```ruby
class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.text :description
      t.references :publication_type
      t.integer :publisher_id
      t.string :publisher_type
      t.boolean :single_issue

      t.timestamps
    end
    add_index :publications, :publication_type_id
  end
end
```
</div>

----
<!-- .slide: data-auto-animate -->
## Migraciones

* Las migraciones permiten tener un registro en la misma base de datos que
  indica qué cambios se han aplicado
* Los cambios entonces pueden versionarse y comitirse o deshacerse en la base de
  datos
* Para aplicar las migraciones pendientes: `rake db:migrate`
* Para deshacer un cambio hecho: `rake db:rollback`
* La DSL es agnóstico a la base de datos: funciona en MySQL, SQLite, Oracle,
  Postgres, etc

----

## Ejemplo de migraciones

[Ver ejemplo](https://github.com/ttps-ruby/ttps-ruby.github.io/tree/master/ejemplos/ar/02-migrations)

----
### Alternativas a las Migraciones

Otros productos que ofrecen alternativas son:

 * https://flywaydb.org/
 * http://www.liquibase.org/
