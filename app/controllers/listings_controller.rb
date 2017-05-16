class ListingsController < ApplicationController
before_action :find_listing, only: [:show, :edit, :update]

	def new
		@listing = Listing.new
	end

	def index
		@listing = Listing.all
	end
		
	def create
		@listing = Listing.new(strong_params)
		@listing.user_id = current_user.id
		@listing.save
		redirect_to @listing
	end

	def show
		@reservation = @listing.reservations.new
	end

	def edit	
		@listing = Listing.find(params[:id])	
	end

	def update
    if @listing.update(listing_params)
      flash[:success] = "Successfully updated the listing"
      redirect_to @listing
    else
      flash[:error] = "Error updating listing"
      render :edit
    end
	end

  def find_listing
    @listing = Listing.find(params[:id])
  end

	private
	def strong_params
		params.require(:listing).permit(:title, :price, :place, :user_id)
	end
end
