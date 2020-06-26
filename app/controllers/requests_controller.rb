class RequestsController < ApplicationController
  before_action :set_admission

  def index
  end

  def new
    @requests = Request.new
  end

  def create
    if Request.create(request_params)
      redirect_to requests_path
    end
  end


  private
  def request_params
    params.require(:request).permit!.merge(user_id: current_user.id)
  end

  def set_admission
    @admission = Admission.new
  end

end
