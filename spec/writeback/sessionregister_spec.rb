# frozen_string_literal: true

require_relative '../../lib/writeback/sessionregister'
require_relative '../../lib/writeback/sessionattendancerecord'

describe Wonde::SessionRegister do
  subject(:register) { described_class.new }

  let(:attendance_1) { Wonde::SessionAttendanceRecord.new }
  let(:attendance_2) { Wonde::SessionAttendanceRecord.new }
  let(:attendances) { [attendance_1] + [attendance_2] }

  let(:param_1) do
    {
      student_id: 'A1849765024',
      date: '2023-02-22',
      session: 'AM',
      attendance_code_id: 'A186523258',
      comment: 'test comment',
      minutes_late: '5',
      employee_id: 'A1329183376'
    }
  end

  let(:param_2) do
    {
      student_id: 'A0249765030',
      date: '2023-02-22',
      session: 'PM',
      attendance_code_id: 'A196523215',
      comment: 'test comment',
      minutes_late: '10',
      employee_id: 'A1229137683'
    }
  end

  let(:params) { [param_1] + [param_2] }

  before do
    attendances.each_with_index do |attendance, index|
      attendance.setStudentId(params[index][:student_id])
      attendance.setDate(params[index][:date])
      attendance.setSession(params[index][:session])
      attendance.setAttendanceCodeId(params[index][:attendance_code_id])
      attendance.setComment(params[index][:comment])
      attendance.setMinutesLate(params[index][:minutes_late])
      attendance.setEmployeeId(params[index][:employee_id])
    end
  end

  it 'assigns many attendances to the attendance array' do
    expect(register.attendance).to be_empty

    register.add(attendance_1)
    register.add(attendance_2)

    expect(register.attendance).to eq(params)
  end
end
