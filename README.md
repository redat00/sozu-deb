# sozu-deb

Small repository for building Sozu deb packages. They should work both for Ubuntu and Debian. 

While the packages work fine, this repository is more of a training for me to get started on how to build Debian packages. It is not the recommended way of building Rust packages the official Rust packaging team at Debian uses. But it works.

## Building a package

If you want to build a package by yourself on your host, you can follow the following commands.

First you should clone the Git repository. For this you have to have things in mind : 

1. Building Debian packages is quite messy, I recommend creating a folder and then cloning the repository inside it.
2. In order to build the package we require a submodule which is actually the upstream of Sozu. When cloning the repository you should also go inside and run the `git submodule update` command.


### Install required packages

```
apt-get install debhelper build-essential devscripts protobuf-compiler rustc cargo
```

### Required environment variables

debuild will read some environment variable to get some informations. You should remember to set them. Here's the one I'm using, of course adapt them to your use case. 

```
DEBEMAIL="reno@redat.me"
DEBFULLNAME="Renaud Duret"
DEB_BUILD_OPTIONS=noautodbgsym
```

### Prepare building env

```
mkdir building
cd building/
git clone https://github.com/redat00/sozu-deb
```

### Select the version of Sozu you want to compile

```
cd sozu/
git checkout -b "0.15.10"
```

### Start the build
```
./build.sh
```

Once you're done, your `.deb` file will be in the upper folder (`../`) ready to be used

## Improvements

Since Rust and Cargo allows us to build for different architecture, I will probably end up adding the build of new architectures in the future, as well as a Github Actions pipeline to publish them directly for download.
