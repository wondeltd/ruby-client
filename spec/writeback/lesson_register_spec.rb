# frozen_string_literal: true

require_relative '../../lib/writeback/lessonregister'
require_relative '../../lib/writeback/lessonattendancerecord'

describe Wonde::LessonRegister do
  subject(:register) { described_class.new }

  let(:attendance1) { Wonde::LessonAttendanceRecord.new }
  let(:attendance2) { Wonde::LessonAttendanceRecord.new }
  let(:attendances) { [attendance1] + [attendance2] }

  let(:param1) do
    {
      student_id: 'A1849765024',
      lesson_id: 'A1964735203',
      attendance_code_id: 'A186523258',
      comment: 'test comment',
      minutes_late: '5'
    }
  end

  let(:param2) do
    {
      student_id: 'A0249765030',
      lesson_id: 'A1964735203',
      attendance_code_id: 'A196523215',
      comment: 'test comment',
      minutes_late: '10'

    }
  end

  let(:params) { [param1] + [param2] }

  before do
    attendances.each_with_index do |attendance, index|
      attendance.setStudentId(params[index][:student_id])
      attendance.setLessonId(params[index][:lesson_id])
      attendance.setAttendanceCodeId(params[index][:attendance_code_id])
      attendance.setComment(params[index][:comment])
      attendance.setMinutesLate(params[index][:minutes_late])
    end
  end

  it 'assigns many attendances to the attendance array' do
    expect(register.attendance).to be_empty

    register.add(attendance1)
    register.add(attendance2)

    expect(register.attendance).to eq(params)
  end
end
