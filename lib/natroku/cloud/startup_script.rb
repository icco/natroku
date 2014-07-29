module Natroku
  module Cloud
    class StartupScript
      def initialize hostname, package_list = ["htop"], users = [], disk2 = false
        @commands = []

        @commands.push "apt-get update"
        @commands.push "apt-get -y install aptitude vim git make curl software-properties-common dnsutils"
        @commands.push "sed -i 's/^# d/d/g' /etc/apt/sources.list"
        @commands.push "aptitude update && sudo DEBIAN_FRONTEND=noninteractive aptitude -y upgrade"
        if package_list.is_a? Array and !package_list.empty?
          @commands.push "DEBIAN_FRONTEND=noninteractive aptitude -y install #{package_list.join ' '}"
        end

        if !hostname.empty?
          @commands.push "echo '#{hostname}' > /etc/hostname && invoke-rc.d hostname.sh start"
        end

        @commands.push "echo net.ipv4.ip_forward=1 > /etc/sysctl.d/99-docker.conf"
        @commands.push "sysctl --system"

        if disk2
          @commands.push "echo ';' | sfdisk /dev/sdb"
          @commands.push "parted -s /dev/sdb rm 1"
          @commands.push "parted -s /dev/sdb mkpart primary 0% 100%"
          @commands.push "mkfs.ext4 /dev/sdb1"
        end

        @commands.push "mkdir -p /var/lib/docker"
        @commands.push "mount -t ext4 /dev/sdb1 /var/lib/docker"
        @commands.push "curl https://go.googlecode.com/files/go1.2.1.linux-amd64.tar.gz > /tmp/go1.2.1.linux-amd64.tar.gz"
        @commands.push "tar -C /usr/local -xzf /tmp/go1.2.1.linux-amd64.tar.gz"
        @commands.push "curl get.docker.io | bash"
        @commands.push "update-rc.d docker defaults"
        @commands.push "su nat -c '\\curl -sSL https://get.rvm.io | bash -s stable --ruby'"

        if users.is_a? Array and !users.empty?
          @commands.push "usermod -a -G docker #{users.join ' '}"
        end

        @commands.push "/usr/local/go/bin/go get github.com/azer/boxcars/boxcars"
        @commands.push "echo 'DONE!' > /tmp/done.txt"
      end

      def to_s
        return <<-EOF
#!/bin/bash
#{@commands.join("\n")}
EOF
      end
    end
  end
end
