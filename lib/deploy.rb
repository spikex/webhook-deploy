class Deploy < Sinatra::Base
  HMAC_DIGEST = OpenSSL::Digest::Digest.new('sha1')

  def verify_signature(body)
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['SECRET'], body)
    Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end

  post '/' do
    halt 403 unless verify_signature(body)
    Dir.chdir('/var/www/html') do
      system('/usr/bin/git pull')
    end
  end
end
