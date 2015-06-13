class ConsultationsController < ApplicationController
	def new
		@consultation = Consultation.new
	end

	def create
	    @consultation = Consultation.new(consultation_params)

	    respond_to do |format|
	      if @consultation.save
	      	consultation = @consultation
	      	ConsultationMailer.new_message(consultation).deliver
	        format.html { redirect_to '/lawyers/websites', notice: 'Your Consultation Request Has Been Sent.' }
	        format.json { render :show, status: :created, location: @consultation }
	      else
	        format.html { render :new }
	        format.json { render json: @consultation.errors, status: :unprocessable_entity }
	      end
	    end
	  end


	private

	def consultation_params
      params.require(:consultation).permit(:name, :email, :description)
    end

end