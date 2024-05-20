class RepostsController < ApplicationController
  before_action :set_post

  def create
    if Repost.find_by(customer_id: current_customer.id, post_id: @post.id)
      redirect_to root_path, alert: '既にリポスト済みです'
    else
      @repost = Repost.create(user_id: current_customer.id, post_id: @post.id)
    end
  end

  def destroy
    @repost = current_customer.reposts.find_by(post_id: @post.id)
    if @repost.present?
      @repost.destroy
    else
      redirect_to root_path, alert: '既にリポストを取り消し済みです'
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
    if @post.nil?
      redirect_to root_path, alert: '該当の投稿が見つかりません'
    end
  end
end