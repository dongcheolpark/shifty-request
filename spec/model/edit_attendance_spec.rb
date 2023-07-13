# frozen_string_literal: true
require 'ShiftyRequest/Model/attendance'
require 'ShiftyRequest/Model/edit_attendance'

RSpec.describe 'edit_attendance test' do
  describe 'get_adjusted_clock_time 테스트' do
    it 'attendance가 적절한 시간을 가지고 있지 않다면' do
      attendance = ShiftyRequest::Model::Attendance.new(
        {
          attendance_id: '1234',
          clock_in_time: '2023-06-05T11:00:00+09:00', # 지각
          clock_out_time: '2023-06-05T19:00:00+09:00',
        }
      )
      edit_attendance = ShiftyRequest::Model::EditAttendance.new(attendance)

      result = edit_attendance.get_adjusted_clock_time

      expect(result).to be_nil
    end
  end
end
