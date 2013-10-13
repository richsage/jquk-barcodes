class JobsController < ApplicationController
  def index
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(post_params)

    # handle file uploads
    uploaded_io = params[:job][:filename]
    new_filename = Rails.root.join("public", "uploads", uploaded_io.original_filename) 
    File.open(new_filename, "wb") do |file|     
      file.write(uploaded_io.read)
    end
    @job.filename = new_filename.to_s

    if @job.save
      flash[:notice] = "Job successfully created"
      redirect_to new_job_path
    else
      render "new"
    end
  end

  private
    def post_params
      params.require(:job).permit(:email, :filename)
    end
end
