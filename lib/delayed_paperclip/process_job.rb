require "active_job"

module DelayedPaperclip
  class ProcessJob < ActiveJob::Base
    def self.enqueue_delayed_paperclip(instance, attachment_name)
      queue_name = instance.class.paperclip_definitions[attachment_name][:delayed][:queue]
      set(:queue => queue_name).perform_later(instance, attachment_name.to_s)
    end

    def perform(instance, attachment_name)
      DelayedPaperclip.process_job(instance, attachment_name.to_sym)
    end
  end
end
