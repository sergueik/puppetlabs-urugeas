require 'spec_helper'

describe 'urugeas::dummy' do
  context 'with an name and param' do
    let(:title) { 'test' }

    context 'and ensure => absent' do
      let(:params) { 
        {
          :parameter1 => 'parameter1',
          :parameter2 => nil,
          :parameter3 => ['parameter3', 'parameter4'],
	  :parameter4 => 'patameter4',
        } 
      }
      it { should contain_notify('test parameter1 = parameter1').with_message('parameter1 = parameter1') }
      it do
        should contain_notify('test parameter3 = [parameter3, parameter4]')
        should contain_notify('test parameter2 = nil')
      end

    end
  end
end
