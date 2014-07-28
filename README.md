# Natroku

Natroku, is what I like to call "dumb people hosting". Not because because it is stupid simple or because you'd have to be dumb to use it. But rather it is a hosting tool that explicitly throws away most of the common sense behind good hosting. There is no replication. There are no backups. There is no monitoring.

## Installation

    $ gem install natroku

## Usage

Boot a new server based on a github project

 > `$ natroku icco/sadnat.com start`

Destroy a running server

 > `$ natroku icco/sadnat.com stop`

Restart (create a new one and destroy old one)

 > `$ natroku icco/sadnat.com restart`

Projects must have the following specs: `user/project` and by default have `@HEAD` appended to them. You can use any normal git commit reference to deploy from a different point in history.

## Contributing

 1. Fork it ( http://github.com/icco/natroku/fork )
 2. Create your feature branch (`git checkout -b my-new-feature`)
 3. Commit your changes (`git commit -am 'Add some feature'`)
 4. Push to the branch (`git push origin my-new-feature`)
 5. Create new Pull Request
