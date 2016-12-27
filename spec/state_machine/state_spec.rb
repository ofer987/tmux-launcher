RSpec.describe StateMachine::State do
  context 'given two sessions' do
    let(:sessions) do
      [
        Session.new('First: Foo'),
        Session.new('Second: Bar')
      ]
    end

    context 'the second session is chosen' do
      let(:index) { 1 }

      subject { described_class.new(sessions, index) }

      its(:to_s) { should eq("First\n> Second") }
    end
  end

end
