include Mongos::Settings

configure({
  db: {
    connections: {
      connection_1: delayed {
        MongoClient.new.db('first')
      },

      connection_2: delayed {
        MongoClient.new.db('second')
      },
    },

    reports: {
      collection_1: {
        connection: delayed {
          settings.db.connections.connection_1
        }
      },

      collection_2: {
        connection: delayed {
          settings.db.connections.connection_1
        }
      },

      collection_3: {
        connection: delayed {
          settings.db.connections.connection_2
        }
      },

    }
  }
})
