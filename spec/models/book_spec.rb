require 'rails_helper'

RSpec.describe Book, type: :model do
  scenario ""
  let(:instance) { Book.new(title: 'My diaries', isbn: '9783161484100') }


  context "with no title" do
    before do
      instance.title = ''
    end

    it "is invalid" do
      expect(instance.valid?).to be_falsey
      expect(instance.errors[:title].count).to eq 1
    end
  end

  context "with no isbn" do
    before do
      instance.isbn = ''
    end

    it "is invalid" do
      expect(instance.valid?).to be_falsey
      expect(instance.errors[:isbn].count).to eq 1
    end
  end


end
