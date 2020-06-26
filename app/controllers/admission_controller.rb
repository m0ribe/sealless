class AdmissionController < ApplicationController

def create
  @admission = Admission.new
  redirect_to requests_path
end

end
