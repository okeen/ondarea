require 'rails_helper'

RSpec.describe NewUploadNotificationService, type: :model do

  subject { NewUploadNotificationService.new(import) }
  let(:import) { BulkBooksImport.new(uploaded_file_url: 'foo.bar') }

  describe "execute" do
    after do
      subject.execute
    end

    context "with a valid BulkBooksImport instance" do
      it "POSTs to the endpoint with the uploaded file url" do
        expect(subject).to receive(:do_notification).with('foo.bar')
      end
    end
  end


  describe "do_notification" do
    
  end
end