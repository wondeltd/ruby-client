# frozen_string_literal: true

require_relative '../../lib/endpoints'
require_relative '../../lib/endpoints/attendance'
require_relative '../../lib/writeback/sessionregister'

describe Wonde::Attendance do
  subject(:attendance_endpoint) { described_class.new(token) }
  let(:token) { '1264927d6d88734d698c1288b8a28d7f5f60a39b' }
  let(:attendance) do
    [
      {
        date: '2023-02-27',
        session: 'AM',
        student_id: 'A585075690',
        attendance_code_id: 'A186523258',
        comment: 'test comment',
        minutes_late: '5',
        employee_id: 'A1329183376'
      },
      {
        date: '2023-02-27',
        session: 'PM',
        student_id: 'A585075690',
        attendance_code_id: 'A1329183376',
        comment: 'present',
        minutes_late: '5',
        employee_id: 'A1329183376'
      }
    ]
  end
  let(:session_register_constant) { Wonde::SessionRegister }
  let(:session_register_instance) do
    instance_double(session_register_constant, attendance:, class: session_register_constant)
  end

  before do
    allow(session_register_constant).to receive(:new).and_return(session_register_instance)
  end

  describe '#session_register' do
    it 'calls post endpoint with the correct attributes' do
      expect(attendance_endpoint).to receive(:post).with(
        { attendance: session_register_instance.attendance }
      )
      attendance_endpoint.session_register(session_register_instance)
    end
  end
end
