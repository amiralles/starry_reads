require 'rails_helper'

RSpec.describe SearchResult, type: :model do
  describe 'validations' do
    subject { build(:search_result) }

    it { is_expected.to validate_presence_of(:isbn) }
    it { is_expected.to validate_presence_of(:source) }
    it { is_expected.to validate_presence_of(:payload) }

    context 'when isbn length is invalid' do
      before { subject.isbn = '123456789' }

      it 'is not valid' do
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:isbn]).to include("length must be either 10 or 13 numbers")
      end
    end

    context 'when isbn length is 10' do
      before { subject.isbn = '1234567890' }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when isbn length is 13' do
      before { subject.isbn = '1234567890123' }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end
  end

  describe 'before validation' do
    let(:search_result) { build(:search_result) }

    context 'when normalizing source' do
      before do
        search_result.source = 'Some Source'
        search_result.validate
      end

      it 'downcases and replaces spaces with underscores' do
        expect(search_result.source).to eq('some_source')
      end
    end

    context 'when normalizing isbn' do
      before do
        search_result.isbn = '123-456-7890'
        search_result.validate
      end

      it 'removes non-numeric characters' do
        expect(search_result.isbn).to eq('1234567890')
      end
    end
  end
end
