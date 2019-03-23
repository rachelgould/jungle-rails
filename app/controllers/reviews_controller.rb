class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end
 
  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to :back
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :product_id,
      :user_id,
      :description,
      :rating
    )
  end

end
