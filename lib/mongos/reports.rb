module Mongos
  class Reports
    include Single

    class << self
      def method_missing(name, *args, &block) 
        define_collection_accessor(name) unless respond_to?(name)
        instance.send(name, *args, &block)
      end

      def define_collection_accessor(name)
        instance_eval do
          variable_name = "@#{name}"

          define_method name do
            result = instance_variable_get(variable_name)
            unless result
              collection = ::Mongos::DB[name]
              result = DocumentCollection.new(collection)
              instance_variable_set(variable_name, result)
            end
            result
          end
        end
      end
    end
  end

  class DocumentCollection
    include Initializer

    initializer :underlying_collection

    def find_by_guid(guid)
      find("guid" => guid).first
    end

    def delete_by_guid(guid)
      doc = find_by_guid(guid)
      remove(doc)
    end

    def find(options, &block)
      underlying_collection.find(options, &block)
    end

    def insert(document)
      underlying_collection.insert(document)
    end

    def remove(doc)
      underlying_collection.remove("_id" => doc["_id"])
    end
  end
end
