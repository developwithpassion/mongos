module Mongos
  module Settings
    def configure(configuration)
      configatron.configure_from_hash(configuration)
    end

    def delayed(&block)
      Configatron::Delayed.new(&block)
    end

    def dynamic(&block)
      Configatron::Dynamic.new(&block)
    end

    def settings
      configatron
    end
  end
end
