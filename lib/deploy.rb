class Deploy < Sinatra::Base

  post '/' do
    body = request.body.read
    halt 403 unless verify_signature(body)
    Dir.chdir('/var/www/html') do
      system('/usr/bin/git pull')
    end
  end

  def verify_signature(body)
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['SECRET'], body)
    Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end
end
