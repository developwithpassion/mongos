module Mongos
  describe DB do
    context 'accessing a document' do
      context 'for the first time' do
        let(:client_cache) {{}}
        let(:db_config) { fake }
        let(:document) { fake }
        let(:connection) { {
          some_collection: document
        }}
        
        subject { DB.new(client_cache, db_config) }

        before (:each) do
          db_config.stub(:create_connection).with(:some_collection).and_return(connection)
        end
        
        before (:each) do
          @result = subject[:some_collection]
        end
        
        it 'initializes the connection for the client and stores it in the client cache' do
          expect(client_cache[:some_collection]).to eql(connection)
        end

        it 'returns the document from the connection' do
          expect(@result).to eql(document)
        end
      end

      context 'subsequent times' do
        let(:connection) { fake }
        let(:client_cache) {{}}
        let(:db_config) { fake }
        let(:document) { fake }
        let(:connection) { {
          some_collection: document
        }}
        
        subject { DB.new(client_cache, db_config) }

        before (:each) do
          client_cache[:some_collection] = connection
        end
        
        before (:each) do
          @result = subject[:some_collection]
        end
        
        it 'does not try to recreate the connection from config' do
          expect(db_config.never_received?(:create_connection)).to be_true
        end

        it 'returns the document' do
          expect(@result).to eql(document) 
        end
      end
    end
  end
end
