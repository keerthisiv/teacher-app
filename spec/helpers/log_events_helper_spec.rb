require './app/helpers/log_events_helper'

RSpec.configure do |c|
  c.include LogEventsHelper
end

describe '#event_types_to_select' do
  let(:event_types) { [['check in', 'check_in'], ['check out', 'check_out']] }

  subject { event_types_to_select }

  it { is_expected.to match_array event_types }
end

describe '#format_event_time' do
  let(:time) { Time.parse('2020-02-09 19:20:25 -0500') }
  let(:expected_format) { '09 Feb 19:20' }

  subject { format_event_time(time) }

  it { is_expected.to eq expected_format }
end
