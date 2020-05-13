require 'rails_helper'

RSpec.describe AuthorList do
  describe 'validations' do
    let(:empty_error) { "can't be blank" }
    let(:array_type_error) { 'list must be an array' }
    let(:blank_record_error) { "list can't have blank records" }
    let(:lenght_error) { "length doesn't match specified records" }

    it { is_expected.to validate_presence_of(:records) }
    it { is_expected.to validate_presence_of(:original_list) }

    describe '.is_array?' do
      context 'when original list is an array' do
        let(:valid_list) { create(:author_list) }

        it 'returns valid object' do
          expect(valid_list).to be_valid
        end
      end

      context "when original list isn't an array" do
        subject(:invalid_list) { described_class.new(invalid_attributes) }

        let(:invalid_attributes) { { records: 1 } }

        let(:expected_errors) { [empty_error, array_type_error, lenght_error] }

        it 'returns invalid object' do
          expect(invalid_list).to be_invalid
        end

        it 'returns correcr error messages' do
          invalid_list.valid?
          errors = invalid_list.errors.messages[:original_list]

          expect(errors).to eq(expected_errors)
        end
      end
    end

    describe '.check_blan k_records' do
      context 'when original list has no blank record' do
        let(:valid_list) { create(:author_list) }

        it 'returns valid object' do
          expect(valid_list).to be_valid
        end
      end

      context 'when original list has a blank record' do
        subject(:invalid_list) { described_class.new(invalid_attributes) }

        let(:invalid_attributes) do
          attributes_for(:author_list, original_list: [''])
        end

        let(:expected_errors) { [blank_record_error, lenght_error] }

        it 'returns invalid object' do
          expect(invalid_list).to be_invalid
        end

        it 'returns correcr error messages' do
          invalid_list.valid?
          errors = invalid_list.errors.messages[:original_list]

          expect(errors).to eq(expected_errors)
        end
      end
    end

    describe '.check_list_length' do
      context 'when list lenght matches records' do
        let(:valid_list) { create(:author_list) }

        it 'returns valid object' do
          expect(valid_list).to be_valid
        end
      end

      context "when list lenght doesn't match records" do
        subject(:invalid_list) { described_class.new(invalid_attributes) }

        let(:invalid_attributes) { attributes_for(:author_list, records: 1) }

        it 'returns invalid object' do
          expect(invalid_list).to be_invalid
        end

        it 'returns lenth error message object' do
          invalid_list.valid?
          errors = invalid_list.errors.messages[:original_list]

          expect(errors).to eq([lenght_error])
        end
      end
    end
  end
end
