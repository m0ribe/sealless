class RequestsController < ApplicationController

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
end

def destroy
  redirect_to root_url
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
                                                           :campany,
                                                           :representative,
                                                           :tell,
                                                           :worker1,
                                                           :worker2,
                                                           :worker3,
                                                           :worker4,
                                                           :aerial,
                                                           :firearm,
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