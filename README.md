# scoped_id

Generates scoped unique identifiers.

## Installation

Add `scoped_id` to your Gemfile:

    gem 'scoped_id', '~> 0.0.1'

## Usage

```
class Project < ActiveRecord::Base
  include ScopedId::Concern
  scoped_id :per_owner_id, scope: :owner_id
end

jacks_project = Project.create(owner_id: 1)
jacks_project.per_owner_id # => 1

johns_project = Project.create(owner_id: 2)
johns_project.per_owner_id # => 1
```

The scoped_id is generated in a `before_create` callback unless it has been manually set.

The scoped_id will be marked as readonly and will validate the uniqueness of its value.

### Options

#### Scope (required)

The scope by which to determine the next identifier when creating a new object.

## Contributing

1. Fork it ( http://github.com/mbillard/scoped_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
