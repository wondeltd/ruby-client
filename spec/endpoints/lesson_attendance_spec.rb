# frozen_string_literal: true

require_relative '../../lib/endpoints'
require_relative '../../lib/endpoints/lessonattendance'
require_relative '../../lib/writeback/lessonregister'

describe Wonde::LessonAttendance do
  subject(:attendance_endpoint) { described_class.new(token) }
  let(:token) { '1264927d6d88734d698c1288b8a28d7f5f60a39b' }
  let(:attendance) do
    [
      {
        student_id: 'A424469134',
        lesson_id: 'AG665491614',
        attendance_code_id: 'A1329183376',
        comment: 'test comment',
        minutes_late: '5'
      },
      {
        student_id: 'A424469134',
        lesson_id: 'AG572997976',
        attendance_code_id: 'A1329183376',
        comment: 'test comment 2',
        minutes_late: '10'
      }
    ]
  end

  let(:lesson_register_constant) { Wonde::LessonRegister }
  let(:lesson_register_instance) do
    instance_double(lesson_register_constant, attendance:, class: lesson_register_constant)
  end

  before do
    allow(lesson_register_constant).to receive(:new).and_return(lesson_register_instance)
  end

  describe '#lesson_register' do
    it 'calls post endpoint with the correct attributes' do
      expect(attendance_endpoint).to receive(:post).with(
        { attendance: lesson_register_instance.attendance }
      )
      attendance_endpoint.lesson_register(lesson_register_instance)
    end
  end
end
