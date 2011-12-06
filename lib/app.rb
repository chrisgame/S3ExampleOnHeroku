require 'sinatra'
require 'haml'
require 'right_aws'

class S3Test < Sinatra::Base
  AWS_ACCESS_KEY = 'AKIAI3HDDHE7NJ2HWRQA'
  AWS_SECRET_ACCESS_KEY = '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'
  AWS_BUCKET = 'robbiebobbins'

  put '/' do
    s3 = RightAws::S3.new(AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY)
    bobbins_bucket = s3.bucket(AWS_BUCKET, true, 'public-read' )
    bobbins_bucket.put('S3Test/test.jpg', request.body)
  end

  get '/' do
    puts 'Hit get on root'
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