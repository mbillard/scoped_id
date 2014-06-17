require 'active_record'
require 'active_support/concern'

module ScopedId

  ScopedIdDefinition = Struct.new(:attr_name, :scope_attr)

  module Concern
    extend ActiveSupport::Concern

    included do
      before_create :generate_next_scoped_ids
    end

    module ClassMethods
      def scoped_id(attr_name, options = {})
        scope = options[:scope]
        if scope.nil?
          raise ArgumentError.new(":scope is not defined. It is a mandatory option of scoped_id.")
        end

        scoped_ids_definitions << ScopedIdDefinition.new(attr_name, scope)

        attr_readonly attr_name

        validates_uniqueness_of attr_name, scope: scope
      end

      def scoped_ids_definitions
        @scoped_ids_definitions ||= []
      end
    end

    def generate_next_scoped_ids
      self.class.scoped_ids_definitions.each do |definition|
        attr_name = definition.attr_name
        if send("#{attr_name}").nil?
          send "#{attr_name}=", send("get_next_scoped_id", definition)
        end
      end
    end

    def get_next_scoped_id(scoped_id_definition)
      attr_name  = scoped_id_definition.attr_name
      scope_attr = scoped_id_definition.scope_attr

      scope = self.class.where(scope_attr => read_attribute(scope_attr))
      current_max_scoped_id = scope.maximum(attr_name) || 0
      current_max_scoped_id + 1
    end

  end
end

# Uncomment to auto-extend ActiveRecord, probably not a good idea
# ActiveRecord::Base.send(:extend, ScopedId)
