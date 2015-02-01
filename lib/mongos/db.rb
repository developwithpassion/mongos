module Mongos
  class DB
    include Single
    include Initializer

    initializer r(:client_cache, deferred('Hash.new')),
      r(:db_config, deferred('::Mongos::DBConfig.new'))

    def [](name_or_symbol)
      key = name_or_symbol.to_sym
      unless client_cache.has_key?(key)
        client = db_config.create_connection(key)
        client_cache[key] = client
        return client[key]
      end

      client = client_cache[key]
      client[key]
    end
  end
end
