#!/bin/bash

# Common constant
MANIFEST_PATH="sozu/Cargo.toml"
BIN_PATH="sozu/target/release/sozu"
PACKAGE_PATH="sozu"
PACKAGE_VERSION=$(git -C $PACKAGE_PATH/ describe --tags)

echo "[prerequisites] Making sure necessary packages are installed ..."
expected_packages=(
	rustc
	cargo
	build-essential
	debhelper
	protobuf-compiler
)

for package in "${expected_packages[@]}"; do
	if ! dpkg -l | grep -q "ii  $package"; then
		echo "$package is not installed. Aborting."
		exit 1
	fi
done

# Copying the debian folder to keep a clean one
cp -r debian debian.backup

# Building cargo package
cargo vendor --locked --manifest-path=$MANIFEST_PATH
cargo build --release --frozen --manifest-path=$MANIFEST_PATH

# Building deb package
debuild --no-lintian -us -uc

# Clean up 
rm -rf $PACKAGE_PATH/target
rm -rf vendor/
rm -rf debian/
mv debian.backup debian
