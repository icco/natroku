module Natroku
  class Cli < Thor
    include Thor::Actions

    desc "start user/repo", "Start a server based on a location spec"
    def start text_spec
      spec = Spec.parse text_spec
      server = Cloud::Server.new spec
      server.start!
    end

    desc "restart user/repo", "Restart a server based on a location spec"
    def restart spec
      stop spec
      start spec
    end

    desc "stop user/repo", "Stop a server based on a location spec"
    def stop spec
    end
  end
end
