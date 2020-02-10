require 'rails_helper'

RSpec.describe LogEvent, :type => :model do
  let(:start_time) { Time.zone.now.beginning_of_day }
  let(:teacher_1) { FactoryGirl.create(:teacher) }

  describe 'scopes' do
    describe '.order_by_latest' do
      let!(:log_event_1) do
        FactoryGirl.create(:log_event,
                           teacher: teacher_1,
                           event_type: 'check_in',
                           event_time: start_time + 1.hour)
      end
      let!(:log_event_2) do
        FactoryGirl.create(:log_event,
                           teacher: teacher_1,
                           event_time: start_time + 2.hours,
                           event_type: 'check_out')
      end

      subject { LogEvent.order_by_latest }

      it { is_expected.to eq [log_event_2, log_event_1]  }
    end

    describe '.for_teacher' do
      let!(:log_event_1) do
        FactoryGirl.create(:log_event,
                           teacher: teacher_1,
                           event_type: 'check_in')
      end
      let(:teacher_2) { FactoryGirl.create(:teacher) }
      let!(:log_event_2) do
        FactoryGirl.create(:log_event,
                           teacher: teacher_2,
                           event_type: 'check_in')
      end

      subject { LogEvent.for_teacher(teacher_1) }

      it { is_expected.to include(log_event_1) }
      it { is_expected.not_to include(log_event_2) }
    end

    describe '.events_during' do
      let!(:log_event_1) do
        FactoryGirl.create(:log_event,
                           teacher: teacher_1,
                           event_type: 'check_in',
                           event_time: start_time + 5.hours)
      end
      let!(:log_event_2) do
        FactoryGirl.create(:log_event,
                           teacher: teacher_1,
                           event_time: log_event_1.event_time + 5.hours,
                           event_type: 'check_out')
      end
      let(:start_at) { start_time + 2.hours }
      let(:end_at) { start_time + 12.hours }

      subject { LogEvent.events_during(start_at, end_at) }

      context 'when the start at and end at includes both events' do
        it { is_expected.to include(log_event_1) }
        it { is_expected.to include(log_event_2) }
      end

      context 'when the start at is after log event 1 event time' do
        let(:start_at) { log_event_1.event_time + 1.hour }

        it { is_expected.not_to include(log_event_1) }
        it { is_expected.to include(log_event_2) }
      end

      context 'when the end at is before the event time of log event 2' do
        let(:end_at) { log_event_2.event_time - 1.hour }

        it { is_expected.to include(log_event_1) }
        it { is_expected.not_to include(log_event_2) }
      end
    end
  end

  describe '.validations' do
    describe '.previous_event_conflict' do
      let!(:teacher) { FactoryGirl.create(:teacher) }
      let(:log_event_1) do
        FactoryGirl.create(:log_event,
                           teacher: teacher,
                           event_type: 'check_in',
                           event_time: start_time + 2.hours)
      end
      let(:log_event_2) do
        FactoryGirl.build(:log_event,
                          teacher: teacher,
                          event_time: start_time + 4.hours,
                          event_type: 'check_out')
      end

      let(:log_event_3) do
        FactoryGirl.create(:log_event,
                          teacher: teacher,
                          event_time: start_time + 3.hours,
                          event_type: 'check_out')
      end

      subject { log_event_2.valid? }

      context 'when there is a previous event' do
        before(:each) { log_event_1 }

        context 'when there is a previous event with same event type' do
          before(:each) { log_event_3 }

          it { is_expected.to be false }
        end

        context 'when the previous event is different event type' do
          it { is_expected.to be true }
        end
      end
    end

    describe '#first_event_is_check_in' do
      let!(:teacher) { FactoryGirl.create(:teacher) }
      let(:log_event_1) do
        FactoryGirl.create(:log_event,
                           teacher: teacher,
                           event_type: 'check_in',
                           event_time: start_time + 2.hours)
      end
      let(:log_event_2) do
        FactoryGirl.build(:log_event,
                           teacher: teacher,
                           event_time: start_time + 4.hours,
                           event_type: 'check_out')
      end

      subject { log_event_2.valid? }

      context 'when this the first event of the day' do
        it { is_expected.to be false }
      end

      context 'when this is after a check in' do
        before(:each) { log_event_1 }

        it { is_expected.to be true }
      end
    end
  end

  describe '#previous_event_for_the_day' do
    let!(:teacher) { FactoryGirl.create(:teacher) }
    let!(:log_event_1) do
      FactoryGirl.create(:log_event,
                         teacher: teacher,
                         event_type: 'check_in',
                         event_time: start_time + 2.hours)
    end
    let!(:log_event_2) do
      FactoryGirl.create(:log_event,
                         teacher: teacher,
                         event_time: start_time + 4.hours,
                         event_type: 'check_out')
    end

    subject { log_event_2.previous_event_for_the_day }

    it { is_expected.to eq log_event_1 }
  end
end
