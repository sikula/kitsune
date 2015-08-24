# kitsune
**kitsune** is a nonintrusive application fingerprinting tool which detects deployed applications installed on a system without having prior knoweledge of the location of deployed applications on a system.

INSTALLATION
===

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

USAGE
===

```
  kitsune --help
```


Note: Adding database files soon
