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

  def build_objects_arr
    @bucket.objects.each_with_object([]) do |obj, arr|

      separated_elements = parse_tabs(obj.read)

      separated_elements.each do |contents|

        arr << {"filename" => obj.key, "key" => contents.first.strip, "value" => contents.last.strip}
      end
    end
  end

end