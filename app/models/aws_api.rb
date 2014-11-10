class AwsApi
  include StringParser

  def initialize(sort_opts)
    @sort_opts = sort_opts
    @bucket = connection
  end

  def bucket_list
    arr_to_sort = build_objects_arr
    Sorter.new(arr_to_sort, @sort_opts).sort
  end

  private

  def connection
    bucket_name = ENV["S3_BUCKET"]
    AWS.config(:access_key_id => ENV["AMAZON_ACCESS_KEY_ID"],
               :secret_access_key => ENV["AMAZON_SECRET_ACCESS_KEY"])
    s3 = AWS::S3.new
    s3.buckets[bucket_name]
  end

  def build_objects_arr #iterating over each object in the bucket
    @bucket.objects.each_with_object([]) { |obj, arr|
      separated_elements = parse_tabs(obj.read)#parsing contents of each file
      
      #building hash object for each filename(obj.key) with contents of each parsed tab elements, to_s handles nil values
      separated_elements.each { |contents|
        arr << {"filename" => obj.key, "key" => contents.first.to_s.strip, "value" => contents.last.to_s.strip}
      }
    }
  end
end