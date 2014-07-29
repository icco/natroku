module Natroku
  module Cloud
    class Server
      attr_accessor :spec, :connection

      def initialize spec, env = {}
        @hostname = nil
        @users = [ENV['USER']]
        @spec = spec

        if !spec.is_a Natroku::Spec
          raise "Spec must be a valid Spec."
        end

        self.connection = Fog::Compute.new({ :provider => "Google" })
      end

      def start!
        package_list = File.readlines('packages.txt').map {|l| l.strip }
        script = StartupScript.new(@hostname, package_list, @users).to_s

        name = spec.valid_cloud_name

        disk = connection.disks.create({
          :name => name,
          :size_gb => 10,
          :zone_name => Natroku::Cloud::ZONE,
          :source_image => Natroku::Cloud::BASE_IMAGE,
        })

        disk.wait_for { disk.ready? }

        server = connection.servers.bootstrap{
          :name => name,
          :disks => [ disk.get_as_boot_disk(true), ],
          :machine_type => Natroku::Cloud::MACHINE_TYPE,
          :zone_name => Natroku::Cloud::ZONE,
          :private_key_path => File.expand_path("~/.ssh/id_rsa"),
          :public_key_path => File.expand_path("~/.ssh/id_rsa.pub"),
          :user => @users[0],
          :tags => ["fog", "natroku"],
          :metadata => {
            # https://developers.google.com/compute/docs/howtos/startupscript#example
            'startup-script' => script,
          },
        })

        server.wait_for? { ready? }

        return server
      end
    end
  end
end
