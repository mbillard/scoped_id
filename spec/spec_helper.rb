require 'pry'
require 'scoped_id'

# Require this file using `require 'spec_helper'` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.before :each do
    Model.delete_all
  end
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                        database: ':memory:')

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :models, force: true do |t|
    t.string :owner_id
    t.integer :owner_scoped_id
  end

end

class BaseModel < ActiveRecord::Base
  self.table_name = 'models'
  include ScopedId::Concern
end
