class Api::UsersController < ApplicationController
    protect_from_forgery with: :null_session

  def index
    render json: User.all
  end

  def show
    render json: User.find(params.fetch(:id)).to_json(methods: [:prev, :next], include: :posts)
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end

  def create
    user = User.create
    if user.save
        render json: {
          status: 200,
          message: "Successfully created User.",
          user: user
        }.to_json
    else
      render json: {
        status: 400,
        message: "Failed to create User.",
        user: user
      }.to_json
    end
  end

  def update
    user = User.find(params[:id])
    user.update(id: params[:id])
    render json: user
  rescue ActiveRecord::RecordInvalid
    render json: { message: "Invalid Inputs", status: 400 }, status: 400
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: "User Deleted" }
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end

end
