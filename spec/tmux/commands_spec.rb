RSpec.describe Tmux::Commands do
  subject { described_class.new }

  it 'returns two sessions' do
    expect(subject.sessions.count).to eq(2)
  end

  it 'returns two sessions objects' do
    subject.sessions.each do |session|
      expect(session).to be_a Session
    end
  end
end
