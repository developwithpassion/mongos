module Mongos
  describe DBConfig do
    include ::Mongos::Settings

    context 'when creating a connection' do
      context 'and the config section exists' do
        context 'returns the connection from the config' do
          let(:connection) { fake }

          let!(:raw_config) {
            configure({
              db: {
                connections:{
                  first: delayed { connection }
                },

                reports: {
                  some_report: {
                    connection: delayed {
                      settings.db.connections.first}
                  }
                }
              },
            })
          }

          subject do 
            DBConfig.new
          end

          before (:each) do
            @result = subject.create_connection(:some_report)
          end

          it 'returns the connection associated with the key' do
            expect(@result).to eql(connection)
          end
        end
      end

      context 'and the config section does not exist' do
        context 'throws an error indicating the collection that is trying to be accessed' do
          let(:connection) { fake }

          let(:raw_config) {
            configure({
              db: {
                connections:{
                  first: delayed { connection }
                },

                reports: {
                  some_report: {
                    connection: delayed {
                      settings.db.connections.first}
                  }
                }
              },
            })
          }

          subject do 
            DBConfig.new
          end

          before (:each) do
            begin
              subject.create_connection(:some_reportss)
            rescue Exception => e
              @result = e
            end
          end

          it 'throws an exception indicating that the report config section is missing' do
            expect(@result.message).to match(/not configured/)
          end
        end
      end
    end
  end
end
