require 'rails_helper'

RSpec.describe FormatAuthorListService do
  describe '.call' do
    context 'with only one name' do
      let(:service_call) { described_class.call(name_array) }

      let(:name_array) { %w[Rodrigo Mariana] }
      let(:expected_list) { %w[RODRIGO MARIANA] }

      it 'returns correct formatted list' do
        expect(service_call).to match_array(expected_list)
      end
    end

    context 'with simple names' do
      let(:service_call) { described_class.call(name_array) }

      let(:name_array) { ['Rodrigo Nunes', 'Mariana Avila'] }
      let(:expected_list) { ['NUNES, Rodrigo', 'AVILA, Mariana'] }

      it 'returns correct formatted list' do
        expect(service_call).to match_array(expected_list)
      end
    end

    context 'with names with conjunctions and last names exceptions' do
      let(:service_call) { described_class.call(name_array) }

      let(:name_array) { ['Rodrigo de Neto', 'Mariana das Dores Filha'] }
      let(:expected_list) { ['NETO, Rodrigo de', 'DORES FILHA, Mariana das'] }

      it 'returns correct formatted list' do
        expect(service_call).to match_array(expected_list)
      end
    end

    context 'with names with conjunctions' do
      let(:service_call) { described_class.call(name_array) }

      let(:name_array) { ['Rodrigo da Silva', 'Mariana do Amaral'] }
      let(:expected_list) { ['SILVA, Rodrigo da', 'AMARAL, Mariana do'] }

      it 'returns correct formatted list' do
        expect(service_call).to match_array(expected_list)
      end
    end

    context 'with names with last name exceptions' do
      let(:service_call) { described_class.call(name_array) }

      let(:name_array) { ['Rodrigo NETO', 'Mariana Avila Filha'] }
      let(:expected_list) { ['NETO, Rodrigo', 'AVILA FILHA, Mariana'] }

      it 'returns correct formatted list' do
        expect(service_call).to match_array(expected_list)
      end
    end
  end
end
