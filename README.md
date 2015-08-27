# kitsune
**kitsune** is a nonintrusive application fingerprinting tool which detects deployed applications installed on a system without having prior knoweledge of the location of deployed applications on a system.

## Installation

**Stable Release (Ruby Gem)**

  coming soon

**From Source**

```
  git clone https://github.com/sikula/kitsune.git
  cd kitsune
  gem build kitsune.gemspec
  gem install kitsune-*.gem
```

**Database**

You can download the database file from [here](https://www.dropbox.com/s/dtj91gpxgexnctc/webapps.sqlite?dl=0)

Then move webapps.sqlite to the 'db' directory in the kitsune folder
```
mv webapps.sqlite /kitsune/db
```

## Usage

**Basic Usage**
```
  kitsune --help
```

**Simple Scan**
```
  kitsune --path /var/www/html/
```

**Running With Custom Database**
```
  kitsune --path /var/www/html/ --database /path/to/custom/database
```

**Filtering**
```
  kitsune --path /var/www/html/ --webapp "joomla"
  kitsune --path /var/www/html/ --app-version "3.3.6"
  kitsune --path /var/www/html/ --webapp "joomla" --app-version "3.3.6"
  kitsune --path /var/www/html/ --webapp "wordpress" --probability 0.8
```


## Contributing

1. Fork it
2. Create a new branch (```git checkout -b your-new-feature```)
3. Commit the changes (```git commit -am 'Some feature added'```)
4. Push to the branch (```git push origin your-new-feature```)
5. Create a new Pull Request


## License

This code is licensed under the MIT license.


## Note

Adding database files soon
