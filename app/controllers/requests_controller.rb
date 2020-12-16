class RequestsController < ApplicationController

  def index
    request = Request.where(user_id: current_user.id)
    @request_unapproved = request.where(status: 1)
    @request_approved = request.where(status: 2)
    @request_deniel = request.where(status: 3)
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
      @request.pass.requested_user = @request.pass.final_user_id
    end
    if @request.save
       redirect_to requests_path
    else
      flash.now[:danger] = '必須事項を入力してください'
      render :new
    end
  end


  def edit
    @request = Request.find(params[:id])
    @request.admission = Request.find(params[:id]).admission
    @request.pass = Request.find(params[:id]).pass
  end

  def update
    @request = Request.find(params[:id])
    if @request.update(request_params)
      @request.update(status: "1")
      redirect_to root_path
    else
      @request.admission = Request.find(params[:id]).admission
      @request.pass = Request.find(params[:id]).pass
      flash.now[:danger] = '必須事項を入力してください'
      render "edit"
    end
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
      Pass.where( request_id: params[:id] ).update( requested_user: @pass.pluck(:second_user_id))[0]
    elsif current_user.id == @pass.pluck(:second_user_id)[0]
      Pass.where( request_id: params[:id] ).update( requested_user: @pass.pluck(:third_user_id)[0])
      binding.pry
    elsif current_user.id == @pass.pluck(:third_user_id)[0]
      Pass.where( request_id: params[:id] ).update( requested_user: @pass.pluck(:final_user_id)[0])
    elsif current_user.id == @pass.pluck(:final_user_id)[0]
      Request.find(params[:id]).update(status: "2")
    end
    redirect_to root_path
  end

  def unapprove
    @pass = Pass.where(request_id: params[:id])
    Request.find(params[:id]).update(status: "3")
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
                                    admission_attributes: [:user_id,
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
                                    pass_attributes: [:request_id,
                                                      :first_user_id,
                                                      :second_user_id,
                                                      :third_user_id,
                                                      :final_user_id,
                                                      :requested_user])
                              .merge(user_id: current_user.id)
  end
end