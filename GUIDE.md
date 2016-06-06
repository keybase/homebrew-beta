### Updating the Formula

These steps can apply to all formulas in this repo.
This example assumes the version is `1.2.3-400`.

- Edit the source archive URL:

    `https://github.com/keybase/client/archive/v1.2.3-400.tar.gz`

- Calculate the sha256:

    `curl -L -s https://github.com/keybase/client/archive/v1.2.3-400.tar.gz | shasum -a 256`

- Update the formula version:

    `version "1.2.3-400"`

- Comment out the bottle section (if present). We will update it later.

### Testing

To test the formula:

    cp keybase.rb /usr/local/Library/Taps/keybase/homebrew-beta
    brew install keybase

Be sure to revert any changes in `/usr/local/Library/Taps/keybase/homebrew-beta`:

    git checkout keybase.rb

### Bottling

    brew uninstall --force keybase
    brew install --build-bottle keybase/beta/keybase
    brew postinstall keybase/beta/keybase
    brew bottle keybase/beta/keybase

Copy the bottle into the formula. In the bottle block, update the root_url for the bottle section of keybase.rb and push to the repo. It doesn't include the `tar.gz` file name:

    root_url "https://github.com/keybase/client/releases/download/v1.2.3-400/"

In the `keybase/client` repository, draft a new release. Select the correct/matching tag version from the drop down.
Update the release title (you can use the version `v1.2.3-400`) and description should include changes from the previous release. Then upload the `kbstage-1.2.3-400.yosemite.bottle.tar.gz` file, mark pre-release and hit Publish.

Then try testing the bottle by uninstalling and re-installing.

### Testing Upgrades

```sh
# Uninstall existing keybase
keybase uninstall

# Install older version from brew (e.g. 1.0.9)
brew uninstall --force keybase
cd 10009
brew install keybase.rb
brew link --overwrite keybase

# Make sure service is running for 1.0.9
keybase install
keybase version # Should say 1.0.9 for both client and server

# Install new version
brew uninstall --force keybase
cd 10013
brew install keybase.rb
brew link --overwrite keybase

keybase version # Should show a version mismatch
keybase id # Should trigger a service restart and then continue
```

#### Clearing Local State

In the rare case you need to clear your local state, you should stop the service first before removing the application directory.

For example:

          keybase launchd stop homebrew.mxcl.keybase
          rm -rf ~/Library/Application\ Support/Keybase
          keybase launchd start homebrew.mxcl.keybase

### Building into Brew or Keybase.app

Sometimes it's useful to build a new version of a keybase binary directly over
the existing brew or app install.

For example, keybase:

```
GO15VENDOREXPERIMENT=1 go build -a -tags "production brew" -o /usr/local/opt/kbstage/bin/kbstage github.com/keybase/client/go/keybase
```

### Uninstalling Service

```
# For keybase
kbstage launchd uninstall homebrew.mxcl.keybase
kbstage launchd uninstall keybase.service
```
