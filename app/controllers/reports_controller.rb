class ReportsController < ApplicationController
  def new
    @report = Report.new
    @comment_id = params[:comment]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @report = Report.create report_params
    unless @report.save
      flash[:danger] = "Fail report"
      redirect_to root_url
    end
    redirect_to request.referrer
  end

  private
    def report_params
      params.require(:report).permit :user_id, :reason, :comment_id
    end
end
