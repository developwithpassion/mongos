module Mongos
  class DBConfig
    include Initializer
    include ::Mongos::Settings

    def create_connection(collection_name)
      raise "Collection: #{collection_name} - is not configured in config" unless settings.db.reports.has_key?(collection_name)

      connection = settings.db.reports[collection_name].connection
      connection
    end
  end
end
