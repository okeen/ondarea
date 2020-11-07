require 'rails_helper'

RSpec.describe NewUploadNotificationJob, type: :job do
  include ActiveJob::TestHelper
  subject(:job) { described_class.perform_later(1) }
  let(:service) { NewUploadNotificationService.new(nil) }

  it 'is in the default queue' do
    expect(NewUploadNotificationJob.new.queue_name).to eq('default')
  end

  it 'invokes execute on a NewUploadNotificationService' do
    expect(NewUploadNotificationService).to receive(:new).and_return service
    expect(service).to receive(:execute)
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
