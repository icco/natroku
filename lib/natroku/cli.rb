module Natroku
  class Cli < Thor
    include Thor::Actions

    def start spec
    end

    def restart spec
      stop spec
      start spec
    end

    def stop spec
    end
  end
end
