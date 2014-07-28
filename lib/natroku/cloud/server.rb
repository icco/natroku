module Natroku
  module Cloud
    class Server
      def initialize spec, env = {}
        if !spec.is_a Natroku::Spec
          raise "Spec must be a valid Spec."
        end

        connection = Fog::Compute.new({ :provider => "Google" })
        name = spec.valid_cloud_name

        disk = connection.disks.create({
          :name => name,
          :size_gb => 10,
          :zone_name => Natroku::Cloud::ZONE,
          :source_image => Natroku::Cloud::BASE_IMAGE,
        })

        disk.wait_for { disk.ready? }

        server = connection.servers.bootstrap{
          :name => name
          :disks => [disk],
          :machine_type => Natroku::Cloud::MACHINE_TYPE,
          :zone_name => Natroku::Cloud::ZONE,
          :private_key_path => File.expand_path("~/.ssh/id_rsa"),
          :public_key_path => File.expand_path("~/.ssh/id_rsa.pub"),
          :user => ENV['USER'],
          :tags => ["fog", "natroku"]
        })
        server.wait_for? { ready? }

        return server
      end
    end
  end
end
