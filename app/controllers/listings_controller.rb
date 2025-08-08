class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit update destroy]

  def index
    @listings = Listing.all
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user # Optional if you want logged-in users

    if @listing.save
      redirect_to @listing, notice: "Listing created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Listing updated."
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path, notice: "Listing deleted."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :price_cents)
  end
end
