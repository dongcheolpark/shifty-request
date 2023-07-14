# frozen_string_literal: true

RSpec.describe('make_edit_attendance_service test') do
  def working_time
    ShiftyRequest::Model::WorkingTime.new(
      Time.new(1, 1, 1, 10, 0, 0, '+09'),
      Time.new(1, 1, 1, 19, 0, 0, '+09'),
    )
  end

  describe('run 메소드') do
    it '잘 변환되어야 함' do
      attendances = [
        ShiftyRequest::Model::Attendance.new(
          {
            attendance_id: '1',
            clock_in_time: Time.new(2023, 5, 14, 9, 0, 0, '+09'),
            clock_out_time: Time.new(2023, 5, 14, 18, 0, 0, '+09'),
          },
        ),
        ShiftyRequest::Model::Attendance.new(
          {
            attendance_id: '2',
            clock_in_time: Time.new(2023, 5, 14, 9, 0, 0, '+09'),
            clock_out_time: Time.new(2023, 5, 14, 18, 0, 0, '+09'),
          },
        ),
      ]
      make_edit_attendance_service = ShiftyRequest::Service::MakeEditAttendanceService.new

      edit_attendances = make_edit_attendance_service.run(attendances:, working_time:)

      expect(edit_attendances.length).to(be(2))
      expect(edit_attendances[0].original_attendance.attendance_id).to(eq('1'))
      expect(edit_attendances[1].original_attendance.attendance_id).to(eq('2'))
    end

    it '출퇴근 시간대에 맞는 attendance라면 변환되지 않아야 함' do
      attendances = [
        ShiftyRequest::Model::Attendance.new(
          {
            attendance_id: '1',
            clock_in_time: Time.new(2023, 5, 14, 9, 0, 0, '+09'),
            clock_out_time: Time.new(2023, 5, 14, 20, 0, 0, '+09'),
          },
        ),
        ShiftyRequest::Model::Attendance.new(
          {
            attendance_id: '2',
            clock_in_time: Time.new(2023, 5, 14, 10, 0, 0, '+09'),
            clock_out_time: Time.new(2023, 5, 14, 19, 0, 0, '+09'),
          },
        ),
      ]
      make_edit_attendance_service = ShiftyRequest::Service::MakeEditAttendanceService.new

      edit_attendances = make_edit_attendance_service.run(attendances:, working_time:)

      expect(edit_attendances.length).to(be(0))
    end
  end
end
