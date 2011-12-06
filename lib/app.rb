require 'sinatra'
require 'haml'

class S3Test < Sinatra::Base

  put '/' do
    puts 'Hit put on root'
    AWS::S3::S3Object.store(params['S3Test/test.jpg'], request.body, AWS_CONFIG['robbiebobbins'])
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