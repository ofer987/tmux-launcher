require 'rspec/its'

RSpec.describe Session do
  let(:line) { '0: 3 windows (created Tue Dec 27 14:04:45 2016) [90x43] (attached)' }

  context '0: 3 windows (created Tue Dec 27 14:04:45 2016) [90x43] (attached)' do
    subject { described_class.new(line) }

    its(:id) { should eq('0') }
  end
end
