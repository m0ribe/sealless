class RequestsController < ApplicationController
  before_action :set_admission

  def index
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new
    redirect_to requests_path
  end

  def set_admission
    @admission = Admission.new
end
