class QueryController < ApplicationController
  respond_to :json

  def index
    @results = AwsApi.new(params[:sort]).bucket_list
    respond_with @results
  end
end