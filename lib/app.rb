require 'sinatra'
require 'haml'
require 'right_aws'

class S3Test < Sinatra::Base
  AWS_ACCESS_KEY = ''
  AWS_SECRET_ACCESS_KEY = ''
  AWS_BUCKET = ''

  put '/' do
    s3 = RightAws::S3.new(AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY)
    bobbins_bucket = s3.bucket(AWS_BUCKET, true, 'public-read' )
    bobbins_bucket.put('S3Test/test.jpg', request.body)
  end

  get '/' do
    page = "<img src='http://s3.amazonaws.com/robbiebobbins/S3Test/test.jpg'/>"
    haml page
  end

  get '/list' do
    s3 = RightAws::S3.new(AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY)
    bucket_names = s3.buckets.map{|bucket| bucket.name}
    bobbins_bucket = s3.bucket(AWS_BUCKET)
    "Buckets on S3: #{bucket_names.join(', ')} Keys in robbiebobbins #{bobbins_bucket.keys.join(', ')}"
  end

end
