# frozen_string_literal: true
require 'ShiftyRequest/Model/clock_time'

RSpec.describe 'clock_time test' do
  describe 'proper_time 메소드' do
    it '10 to 7을 지켰다면' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T19:00:00+09:00',
      )

      expect(clock_time.proper_time?).to be_truthy
    end

    it '1시간 늦게 출근했다면' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T11:00:00+09:00',
        '2023-06-05T19:00:00+09:00',
      )

      expect(clock_time.proper_time?).to be_falsey
    end

    it '1시간 빨리 퇴근했다면' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T18:00:00+09:00',
      )

      expect(clock_time.proper_time?).to be_falsey
    end
  end

  describe 'work_time 메소드' do
    it '2 시간' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T12:00:00+09:00',
      )

      work_time = clock_time.work_time

      expect(work_time).to eq(Rational(2, 24))
    end

    it '9 시간' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T19:00:00+09:00',
      )

      work_time = clock_time.work_time

      expect(work_time).to eq(Rational(9, 24))
    end
  end

  describe 'over_time 메소드' do
    it '1시간 초과 근무 했다면' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T20:00:00+09:00', # 1시간 늦게 퇴근
      )

      over_time = clock_time.over_time

      expect(over_time).to eq(Rational(1, 24))
    end
  end
end
