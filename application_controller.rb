class ApplicationController < Sinatra::Base
  set :views, proc { File.join(root, 'views') }

  get '/' do
    erb :'index.html'
  end

  post '/' do
    begin
      Mailer.new(params).send
      redirect to('/success')
    rescue
      redirect to('/failure')
    end
  end

  get '/success' do
    erb :'success.html'
  end

  get '/failure' do
    erb :'failure.html'
  end
end
