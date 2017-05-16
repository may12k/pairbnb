class ReservationsController < ApplicationController
	def create
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.listing_id = params[:listing_id]
		@listing = Listing.find(params[:listing_id])
		if @reservation.save
			# byebug
			UserMailer.booking_email(current_user).deliver_now
			redirect_to [@listing, @reservation]
		else
			redirect_to @listing
		end
	end

	def new
		@reservation = Reservation.new
	end

	def index
		@reservation = Reservation.all
	end

	def show
		@reservation = Reservation.find(params[:id])
		
	end
		

	def destroy
	end

	private

	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date, :number_of_guests)
	end
end

