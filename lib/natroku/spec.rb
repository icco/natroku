module Natroku
  class Spec
    attr_reader :user, :project, :ref

    def self.parse text_spec
      return Spec.new
    end
  end
end
