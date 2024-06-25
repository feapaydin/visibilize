# ⚠️ This is a very old and unmaintaned repository, refer to [friendly_id](https://github.com/norman/friendly_id) for a better solution.


# Visibilize

  

Visibilize is a gem that automatically creates *friendly visible ID's* for *ActiveRecord* instances.


Whenever you need an ID that **can be exposed** to end-users or a custom identifier for your models, visibilize can help.

It:
 - Can generate random `strings and integers` with `custom length` as identifier
 - Can generate identifiers from `SecureRandom` methods like `uuid`, `hex` or `base64` 
 - Can be triggered from different `ActiveRecord callbacks` to suit your needs  
 - Can make the identifiers `unique` for each record
 - Can create identifiers from provided `lambda` methods

  

## Installation

  

Add this line to your application's Gemfile:  

```ruby

gem  'visibilize'

```

  

And then execute:

  
```
$ bundle
```
  

Or install it yourself as:

  
```
$ gem install visibilize
```
  

## Usage

### Creating Attribute
First you need to create an identifier column (attribute) for your ActiveRecord model, if not already exists.

Run the command to create a migration:

```
rails g migration AddVisibleIdToUsers visible_id
```
You can name the column however you like. 
You should also set the column type according to format of the identifier. You can make it an integer if you want your visible id to be numeric, otherwise string should work for most cases.

Then run `rails db:migrate` to execute the migration. This will create the visible_id column in your table.

---

### Editing the Model
After the database is ready, open the `app/models/user.rb` file and call `visibilize` 

```ruby
class User < ActiveRecord::Base
  visibilize
end
```
That's it.
Whenever a record is being created it will fill the visible_id column with random unique integers automatically. 

You can retrieve records with usual ActiveRecord calls:
```ruby
User.find_by_visible_id(params[:id])
User.where(visible_id: params[:id]).first
User.find_by(visible_id: params[:id])
```

---
### Options
Visibilize can be customized with provided options:
```ruby
class User < ActiveRecord::Base
  visibilize  column:   :serial_number, # The column that will be used to store idenitifer
              type:     :string, 	# Type/format of the created identifier
              callback: :before_create, # ActiveRecord callback that ID will be created
              length:   50,
              unique:   true  
end
```


#### Type
Visibilize has its own generators for string and integer types. You can provide either `:string` or `:integer` as type. Bear in mind that random strings can also contain numbers inside them.

Both string and integer values are being generated with respect to length option.

The type also supports `SecureRandom` methods. For example:
```ruby
class User < ActiveRecord::Base
  # The value will be generated from SecureRandom.uuid
  # For more info about SecureRandom visit: https://apidock.com/ruby/SecureRandom
  visibilize type: :uuid
end
```  
The default type is `:integer`.

#### Length
The length specifies the length of the created string or integer. The `default length is 8`.

If you are calling a SecureRandom method with type, the length will be sent as an argument to that method (if expected).
Note that some SecureRandom methods does not use length parameter (like UUID, has fixed length 36)  so visibilize option for length will be unnecessary.


#### Unique
It simply specifies whether the provided value must be non existent in previous records of the model.
By default this is set to `true`.
The uniqueness will be checked with a loop in plain ruby, not on the database.
```
! CAUTION !
If you're expecting the values to be unique, 
you must consider the type and length of the generated identifier.
The next available ID must be easy to find, 
otherwise the loop can be iterate for too long 
or even infinitely if no ID is available. 
```


#### Callback
ActiveRecord supports multiple callbacks for different actions. You can provide the name of the callback that visibilize will be executed. The default callback is `before_create`.

```ruby
class User < ActiveRecord::Base
  visibilize type:      :uuid,
             callback:  :before_update
end
```  
Note that visibilize **does not save** the record when it is called. You must save the generated value manually by calling `instance.save` whenever is fit, or use a callback that is just before the saving progress like `before_create`. 

#### Lambda
You can provide a lambda method to generate a value by custom conditions.
If you provide a lambda, visibilize will automatically use it and skip its own generators.
```ruby
class User < ActiveRecord::Base
  visibilize  column: :token,
              lambda: ->() {return  Digest::MD5.hexdigest('foobar')}
end
```  
Visibilize **cannot modify length** or **promise uniqueness** when using lambdas since the value will be generated from provided lambda method.

## Bugs
Please report any bugs by [creating issues on Github](https://github.com/FEApaydin/visibilize/issues).
  
  

## Contribution

### Setup
The tests are using ActiveRecord `6.0` which requires ruby `2.5.0` or further. The recommended ruby version is `2.7.0`. Make sure you have the correct Ruby version.

To install the gem requirements, run the command:

```
bin/setup
```

### Development
All of the core files of the gem is under `lib/` directory. 
You can develop your own generators inside `lib/visibilize/generator.rb` . 
If you name your generator method in the `generate_md5` format, it will automatically be available to use with `type: :md5` option.

### Testing
Visibilize uses `rspec` for testing.
Since the gem works on top of ActiveRecord, a database connection is required.
Create a database and enter the credentials to `spec/db/database.yaml`. 
Then run:
```
bundle exec rspec
```  
Rspec will automatically connect to the database, execute migrations for test tables and perform tests.
It destroys all of the records from previous tests but does not truncate or drop the database.

If somehow you cannot use migrations, there is a `spec/db/mysql.sql` file that contains plain SQL for creating the tables manually. 

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
