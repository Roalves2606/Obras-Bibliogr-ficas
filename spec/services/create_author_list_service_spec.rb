require 'rails_helper'

RSpec.describe CreateAuthorListService do
  describe '.call' do
    context 'with valid params' do
      let(:service_call) { described_class.call(valid_params) }

      let(:valid_params) { attributes_for(:author_list) }

      let(:author_list) do
        AuthorList.where(original_list: valid_params[:original_list]).take
      end

      let(:formatted_list_response) do
        { formatted_list: author_list.formatted_list }
      end

      it 'creates an author list' do
        expect { service_call }.to change(AuthorList, :count).by(1)
      end

      it 'returns formatted list response' do
        expect(service_call).to eq(formatted_list_response)
      end
    end

    context 'with invalid params' do
      let(:empty_error) { "can't be blank" }
      let(:array_type_error) { 'list must be an array' }
      let(:blank_records_error) { "list can't have blank records" }
      let(:lenght_error) { "length doesn't match specified records" }

      context 'when original list is not an array' do
        let(:service_call) { described_class.call(invalid_params) }

        let(:invalid_params) { { records: 1 } }

        let(:error_response) { [empty_error, array_type_error, lenght_error] }

        it 'does not create an author list' do
          expect { service_call }.not_to change(AuthorList, :count)
        end

        it 'returns correct errors response' do
          errors = service_call[:error][:original_list]

          expect(errors).to match_array(error_response)
        end
      end

      context 'when original list is empty' do
        let(:service_call) { described_class.call(invalid_params) }

        let(:invalid_params) { attributes_for(:author_list, original_list: []) }

        let(:expected_errors) { [empty_error, lenght_error] }

        it 'does not create an author list' do
          expect { service_call }.not_to change(AuthorList, :count)
        end

        it 'returns correct errors response' do
          errors = service_call[:error][:original_list]

          expect(errors).to match_array(expected_errors)
        end
      end

      context 'when original list has blank records' do
        let(:service_call) { described_class.call(invalid_params) }

        let(:invalid_params) do
          attributes_for(:author_list, original_list: [''])
        end

        let(:expected_errors) { [blank_records_error, lenght_error] }

        it 'does not create an author list' do
          expect { service_call }.not_to change(AuthorList, :count)
        end

        it 'returns correct errors response' do
          errors = service_call[:error][:original_list]

          expect(errors).to match_array(expected_errors)
        end
      end

      context "when records doesn't match original list length" do
        let(:service_call) { described_class.call(invalid_params) }

        let(:invalid_params) do
          attributes_for(:author_list, original_list: ['A'])
        end

        it 'does not create an author list' do
          expect { service_call }.not_to change(AuthorList, :count)
        end

        it 'returns correct errors response' do
          errors = service_call[:error][:original_list]

          expect(errors).to match_array([lenght_error])
        end
      end
    end
  end
end
