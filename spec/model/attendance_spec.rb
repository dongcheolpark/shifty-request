# frozen_string_literal: true
require 'ShiftyRequest/Model/attendance'

RSpec.describe 'attendance test' do
  describe 'proper_time 메소드' do
    it '10 to 7을 지켰다면' do
      attendance = ShiftyRequest::Model::Attendance.new(
        {
          attendance_id: '1234',
          clock_in_time: '2023-06-05T10:00:00+09:00',
          clock_out_time: '2023-06-05T19:00:00+09:00',
        }
      )

      expect(attendance.proper_time?).to be_truthy
    end

    it '1시간 늦게 출근했다면' do
      attendance = ShiftyRequest::Model::Attendance.new(
        {
          attendance_id: '1234',
          clock_in_time: '2023-06-05T11:00:00+09:00',
          clock_out_time: '2023-06-05T19:00:00+09:00',
        }
      )

      expect(attendance.proper_time?).to be_falsey
    end

    it '1시간 빨리 퇴근했다면' do
      attendance = ShiftyRequest::Model::Attendance.new(
        {
          attendance_id: '1234',
          clock_in_time: '2023-06-05T10:00:00+09:00',
          clock_out_time: '2023-06-05T18:00:00+09:00',
        }
      )

      expect(attendance.proper_time?).to be_falsey
    end
  end

  describe 'work_time 메소드' do
    it '2 시간' do
      attendance = ShiftyRequest::Model::Attendance.new(
        {
          attendance_id: '1234',
          clock_in_time: '2023-06-05T10:00:00+09:00',
          clock_out_time: '2023-06-05T12:00:00+09:00',
        }
      )

      work_time = attendance.work_time

      expect(work_time).to eq(Rational(2, 24))
    end

    it '9 시간' do
      attendance = ShiftyRequest::Model::Attendance.new(
        {
          attendance_id: '1234',
          clock_in_time: '2023-06-05T10:00:00+09:00',
          clock_out_time: '2023-06-05T19:00:00+09:00',
        }
      )

      work_time = attendance.work_time

      expect(work_time).to eq(Rational(9, 24))
    end
  end
end
