# frozen_string_literal: true

RSpec.describe('edit_attendance test') do
  def working_time
    ShiftyRequest::Model::WorkingTime.new(
      Time.new(1, 1, 1, 10, 0, 0, '+09'),
      Time.new(1, 1, 1, 19, 0, 0, '+09'),
    )
  end

  describe 'get_adjusted_clock_time 테스트' do
    it 'attendance가 적절한 시간을 가지고 있다면' do
      attendance = ShiftyRequest::Model::Attendance.new(
        {
          attendance_id: '1234',
          clock_in_time: '2023-06-05T10:00:00+09:00', # 지각
          clock_out_time: '2023-06-05T19:00:00+09:00',
        },
      )
      edit_attendance = ShiftyRequest::Model::EditAttendance.new(attendance)

      result = edit_attendance.adjusted_clock_time(working_time)

      expect(result).to(be_nil)
    end

    describe '적절한 시간을 가지고 있지 않다면' do
      it '근무 시간을 초과했어도 그대로 이동해야 함' do
        attendance = ShiftyRequest::Model::Attendance.new(
          {
            attendance_id: '1234',
            clock_in_time: '2023-06-05T11:00:00+09:00',
            clock_out_time: '2023-06-05T21:00:00+09:00', # 1시간 초과
          },
        )
        edit_attendance = ShiftyRequest::Model::EditAttendance.new(attendance)

        result = edit_attendance.adjusted_clock_time(working_time)

        expect(result.work_time).to(eq(60 * 60 * 10))
        expect(result.in_time).to(be_between(
          Time.parse('2023-06-05T09:00:00+09:00'),
          Time.parse('2023-06-05T10:00:00+09:00'),
        ))
        expect(result.out_time).to(be_between(
          Time.parse('2023-06-05T19:00:00+09:00'),
          Time.parse('2023-06-05T20:00:00+09:00'),
        ))
      end

      it '1시간 덜 근무했다면 근무시간만큼 늘어나야 함' do
        attendance = ShiftyRequest::Model::Attendance.new(
          {
            attendance_id: '1234',
            clock_in_time: '2023-06-05T11:00:00+09:00',
            clock_out_time: '2023-06-05T19:00:00+09:00', # 1시간 덜 근무
          },
        )
        edit_attendance = ShiftyRequest::Model::EditAttendance.new(attendance)

        result = edit_attendance.adjusted_clock_time(working_time)

        expect(result.work_time).to(eq(60 * 60 * 9 + 3 * 60))
        expect(result.in_time).to(be_between(
          Time.parse('2023-06-05T09:00:00+09:00'),
          Time.parse('2023-06-05T10:00:00+09:00'),
        ))
        expect(result.out_time).to(be_between(
          Time.parse('2023-06-05T19:00:00+09:00'),
          Time.parse('2023-06-05T20:00:00+09:00'),
        ))
      end

      describe '실제 근무 시간이 표준 근무 시간의 2/3 미만이라면 반차로 간주' do
        it '초과 근무 했다면 근무시간 유지' do
          attendance = ShiftyRequest::Model::Attendance.new(
            {
              attendance_id: '1234',
              clock_in_time: '2023-06-05T11:00:00+09:00',
              clock_out_time: '2023-06-05T16:00:00+09:00', # 5시간 근무
            },
            )
          edit_attendance = ShiftyRequest::Model::EditAttendance.new(attendance)

          result = edit_attendance.adjusted_clock_time(working_time)

          expect(result.work_time).to(eq(60 * 60 * 5))
          expect(result.in_time).to( be_between(
            Time.parse('2023-06-05T09:00:00+09:00'),
            Time.parse('2023-06-05T10:00:00+09:00'),
          ))
          expect(result.out_time).to(be_between(
            Time.parse('2023-06-05T15:00:00+09:00'),
            Time.parse('2023-06-05T16:00:00+09:00'),
          ))
        end

        it '덜 근무하면 표준 근무 시간으로 변환' do
          attendance = ShiftyRequest::Model::Attendance.new(
            {
              attendance_id: '1234',
              clock_in_time: '2023-06-05T11:00:00+09:00',
              clock_out_time: '2023-06-05T15:00:00+09:00', # 4시간 근무
            },
            )
          edit_attendance = ShiftyRequest::Model::EditAttendance.new(attendance)

          result = edit_attendance.adjusted_clock_time(working_time)

          expect(result.work_time).to(eq(60 * 60 * 4.5 + 3 * 60))
          expect(result.in_time).to( be_between(
            Time.parse('2023-06-05T09:00:00+09:00'),
            Time.parse('2023-06-05T10:00:00+09:00'),
          ))
          expect(result.out_time).to(be_between(
            Time.parse('2023-06-05T14:30:00+09:00'),
            Time.parse('2023-06-05T15:30:00+09:00'),
          ))
        end
      end
    end
  end
end
