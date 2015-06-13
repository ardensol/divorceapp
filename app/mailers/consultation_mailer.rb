class ConsultationMailer < ActionMailer::Base
	default :from => "<csolorio05@gmail.com>"


	def new_message(consultation)
		@consultation = consultation
	    mail(:subject => "New Consultation Request!",
	    	bcc: @consultation.email )
  	end
end