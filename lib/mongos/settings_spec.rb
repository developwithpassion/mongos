module Mongos
  describe Settings do
    context 'running configuration' do
      subject { Object.new.extend Settings }

      before (:each) do
        subject.configure({
          name: 'JP'
        })
      end

      it 'configures configatron' do
        expect(configatron.name).to eql('JP')
      end
    end
  end
end
