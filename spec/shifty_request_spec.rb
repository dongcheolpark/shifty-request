# frozen_string_literal: true

RSpec.describe 'test', :type => :request do
  describe 'check smth' do
    it 'should be eq' do
      expect(3).to eq(3)
    end
  end
end
