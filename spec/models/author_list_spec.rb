require 'rails_helper'

RSpec.describe AuthorList do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:records) }
    it { is_expected.to validate_presence_of(:original_list) }

    describe '.original_list_length' do
      context 'when list lenght matches records' do
        let(:valid_list) { create(:author_list) }

        it 'returns valid object' do
          expect(valid_list).to be_valid
        end
      end

      context "when list lenght doesn't match records" do
        subject(:invalid_list) { described_class.new(invalid_attributes) }

        let(:invalid_attributes) { attributes_for(:author_list, records: 1) }

        let(:length_error) do
          { original_list: ["length doesn't match specified records"] }
        end

        it 'returns invalid object' do
          expect(invalid_list).to be_invalid
        end

        it 'returns lenth error message object' do
          invalid_list.valid?
          error_message = invalid_list.errors.messages

          expect(error_message).to eq(length_error)
        end
      end
    end
  end
end
