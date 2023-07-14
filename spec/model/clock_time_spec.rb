# frozen_string_literal: true

require 'ShiftyRequest/Model/clock_time'

RSpec.describe('clock_time test') do
  def working_time
    ShiftyRequest::Model::WorkingTime.new(
      Time.new(1, 1, 1, 10, 0, 0, '+09'),
      Time.new(1, 1, 1, 19, 0, 0, '+09'),
    )
  end

  describe 'proper_time 메소드' do
    it '10 to 7을 지켰다면' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T19:00:00+09:00',
      )

      expect(clock_time.proper_time?).to(be_truthy)
    end

    it '초과근무 했다면' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T09:00:00+09:00',
        '2023-06-05T20:00:00+09:00',
      )

      expect(clock_time.proper_time?).to(be_truthy)
    end

    it '1시간 늦게 출근했다면' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T11:00:00+09:00',
        '2023-06-05T19:00:00+09:00',
      )

      expect(clock_time.proper_time?).to(be_falsey)
    end

    it '1시간 빨리 퇴근했다면' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T18:00:00+09:00',
      )

      expect(clock_time.proper_time?).to(be_falsey)
    end
  end

  describe 'work_time 메소드' do
    it '2 시간' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T12:00:00+09:00',
      )

      work_time = clock_time.work_time

      expect(work_time).to(eq(2.hour))
    end

    it '9 시간' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T19:00:00+09:00',
      )

      work_time = clock_time.work_time

      expect(work_time).to(eq(9.hour))
    end
  end

  describe 'over_time 메소드' do
    it '1시간 초과 근무 했다면' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T10:00:00+09:00',
        '2023-06-05T20:00:00+09:00', # 1시간 늦게 퇴근
      )

      over_time = clock_time.over_time

      expect(over_time).to(eq(1.hour))
    end
  end

  describe 'get_time_aligned_by_start_time 테스트' do
    it '시작 시간으로 맞춰져야 함' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T09:00:00+09:00', # 1시간 빠름
        '2023-06-05T19:00:00+09:00',
      )

      new_clock_time = clock_time.get_time_aligned_by_start_time

      expect(new_clock_time.in_time).to(eq(Time.parse('2023-06-05T10:00:00+09:00')))
      expect(new_clock_time.out_time).to(eq(Time.parse('2023-06-05T20:00:00+09:00')))
    end

    it '시작 시간으로 맞춰져야 함' do
      clock_time = ShiftyRequest::Model::ClockTime.new(
        '2023-06-05T11:00:00+09:00', # 1시간 느림
        '2023-06-05T19:00:00+09:00',
      )

      new_clock_time = clock_time.get_time_aligned_by_start_time

      expect(new_clock_time.in_time).to(eq(Time.parse('2023-06-05T10:00:00+09:00')))
      expect(new_clock_time.out_time).to(eq(Time.parse('2023-06-05T18:00:00+09:00')))
    end
  end
end
