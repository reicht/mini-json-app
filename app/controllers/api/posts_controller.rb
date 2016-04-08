class Api::PostsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    user = User.find(params.fetch(:user_id))
    render json: user.posts
  end

  def show
    render json: Post.find(params.fetch(:id)).to_json
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end

  def create
    post = Post.create(user_id: params[:user_id])
    if post.save
        render json: {
          status: 200,
          message: "Successfully created Post.",
          post: post
        }.to_json
    else
      render json: {
        status: 400,
        message: "Failed to create Post.",
        post: post
      }.to_json
    end
  end

  def update
    post = Post.find(params[:id])
    post.update(id: params[:id], user_id: params[:user_id])
    render json: post
  rescue ActiveRecord::RecordInvalid
    render json: { message: "Invalid Inputs", status: 400 }, status: 400
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    render json: { message: "Post Deleted" }
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Not found", status: 404 }, status: 404
  end
end
