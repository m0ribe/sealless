class RequestsController < ApplicationController
  before_action :sign_in

  def index
    request = Request.where(user_id: current_user.id)
    @request_unapproved = request.where(status: 1)
    @request_approved = request.where(status: 2)
    requested_id = Pass.where(requested_user: current_user.id).select(:request_id)
    approve = Request.where(id: requested_id)
    @approve_unapproved = approve.where(status: 1)
    @approve_approved = approve.where(status: 2)
  end

  def new
    @request = Request.new
    @request.admission
    @request.pass
  end

  def create
    @request = Request.new(request_params)
    if @request.pass.first_user_id.present?
      @request.pass.requested_user = @request.pass.first_user_id
    elsif @request.pass.second_user_id.present?
      @request.pass.requested_user = @request.pass.second_user_id
    elsif @request.pass.third_user_id.present?
      @request.pass.requested_user = @request.pass.third_user_id
    elsif @request.pass.final_user_id.present?
      @request.pass.requested_user = @request.pass.first_user_id
    end
    if @request.save
       redirect_to requests_path
    end
  end


  def edit
    @request = Request.find(params[:id])
    @request.admission = Request.find(params[:id]).admission
    @request.pass = Request.find(params[:id]).pass
    @request.comments = Request.find(params[:id]).comments
    @comment  = @request.comments.build(user_id: current_user.id)
    # @request.comments.new
  end

  def update
    @request = Request.find(params[:id])
    @request.update(request_params)
    binding.pry
    redirect_to root_path
    # else
    #   @request.admission = Request.find(params[:id]).admission
    #   @request.pass = Request.find(params[:id]).pass
    #   render "edit"
    # end
  end

  def destroy
    request = Request.find(params[:id])
    if request.destroy
      flash[:notice] = "削除が完了しました。"
      redirect_to root_url
    else
      flash[:alert] = "削除できませんでした。"
      redirect_to root_url
    end
  end

  def approve
    @pass = Pass.where(request_id: params[:id])
    if current_user.id == @pass.pluck(:first_user_id)[0]
      Pass.where( request_id: params[:id] ).update( requested_user: @pass.pluck(:second_user_id)[0])
    elsif current_user.id == @pass.pluck(:second_user_id)[0]
      Pass.where( request_id: params[:id] ).update( requested_user: @pass.pluck(:third_user_id)[0])
    elsif current_user.id == @pass.pluck(:third_user_id)[0]
      Pass.where( request_id: params[:id] ).update( requested_user: @pass.pluck(:final_user_id)[0])
    elsif current_user.id == @pass.pluck(:final_user_id)[0]
      Request.find(params[:id]).update(status: "2")
    end
    redirect_to root_path
  end

  private
  def request_params
    params.require(:request).permit(:title,
                                    :pdf,
                                    :message,
                                    :user_id,
                                    :kind,
                                    :deadline,
                                    :status,
                                    admission_attributes: [:id,
                                                            :user_id,
                                                            :request_id,
                                                            :title,
                                                            :start,
                                                            :finish,
                                                            :detail,
                                                            :prace,
                                                            :aerial,
                                                            :firearm,
                                                            :campany,
                                                            :representative,
                                                            :tell,
                                                            :worker1,
                                                            :worker2,
                                                            :worker3,
                                                            :worker4,
                                                            :notice],
                                    pass_attributes: [:id,
                                                      :request_id,
                                                      :first_user_id,
                                                      :second_user_id,
                                                      :third_user_id,
                                                      :final_user_id,
                                                      :requested_user],
                                    comments_attributes: [:id,
                                                          :request_id,
                                                          :content])
                              .merge(user_id: current_user.id)
  end

  def sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end