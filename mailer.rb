class Mailer
  attr_reader :name, :location, :wearing, :contact

  def initialize(params)
    @name, @location, @wearing, @contact = params.values
  end

  def send
    client = SendGrid::Client.new(api_user: ENV['SENDGRID_USERNAME'],
                                  api_key: ENV['SENDGRID_PASSWORD'])
    client.send(email)
  end

  private

  def email_body
    body = "#{name} needs help at #{location}."
    body += " He/she is wearing #{wearing}." unless wearing.empty?
    body += " Contact him/her at #{contact}" unless contact.empty?
    body
  end

  def email
    SendGrid::Mail.new do |m|
      m.to = ENV['EMAIL']
      m.from = 'help@cis196.party'
      m.subject = "#{name} needs help"
      m.html = email_body
    end
  end
end
