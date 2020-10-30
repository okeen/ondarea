require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "valid?" do
    subject { Book.new(title: 'My diaries', isbn: '9783161484100') }

    context "with no title" do
      before do
        subject.title = ''
      end

      it "is invalid" do
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:title]).to include("can't be blank")
      end
    end

    context "with no isbn" do
      before do
        subject.isbn = ''
      end

      it "is invalid" do
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:isbn]).to include("can't be blank")
        expect(subject.errors[:isbn]).to include("can't be blank")
      end
    end

    context "with an isbn that already exists" do
      let(:existing_book) { Book.create(title: 'More diaries', isbn: '9783161484100') }
      before do
        subject.isbn = existing_book.isbn
      end

      it "is invalid" do
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:isbn]).to include("has already been taken")
      end
    end

    context "with valid title and isbn" do
      subject { Book.new(title: 'My good diaries', isbn: '9781400132171') }

      it "is valid" do
        expect(subject.valid?).to be_truthy
        expect(subject.errors).to be_empty
      end
    end
  end
end
