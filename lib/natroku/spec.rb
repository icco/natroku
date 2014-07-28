module Natroku
  class Spec
    attr_reader :user, :project, :ref

    def initialize user, project, ref
      @user = user
      @project = project
      @ref = ref
    end

    def self.parse text_spec
      matchdata = text_spec.match /([\w\-\.]+)\/([\w\-\.]+)(\@([\w\-\.]+))?/
      user = matchdata[1]
      project = matchdata[2]
      ref = matchdata[4] || "HEAD"

      return Spec.new user, project, ref
    end
  end
end
