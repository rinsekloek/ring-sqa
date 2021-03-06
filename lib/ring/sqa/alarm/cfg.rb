module Ring
class SQA

  class Alarm
    Config = Asetus.new name: 'sqa', load: false, usrdir: File.join(Directory, "local"), cfgfile: 'alarm.conf'
    Config.default.email.to        = false
    Config.default.email.from      = "ring-sqa@" + CFG.host.name
    Config.default.email.prefix    = false
    Config.default.irc.host        = '213.136.8.179'
    Config.default.irc.port        = 5502
    Config.default.irc.password    = 'shough2oChoo'
    Config.default.irc.target      = '#ring'
    Config.default.exec.command    = false
    Config.default.exec.arguments  = false
    Config.default.recovery.notify = true

    begin
      Config.load
    rescue => error
      raise InvalidConfig, "Error loading alarm.conf configuration: #{error.message}"
    end
    CFG = Config.cfg
    Config.create
  end

end
end
