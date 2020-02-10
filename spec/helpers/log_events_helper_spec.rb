require './app/helpers/log_events_helper'

RSpec.configure do |c|
  c.include LogEventsHelper
end

RSpec.describe '#event_types_to_select' do
  subject { event_types_to_select }
  let(:event_types) { [['check in', 'check_in'], ['check out', 'check_out']] }

  it { is_expected.to match_array event_types }
end
