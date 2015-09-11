
## Keybase Brew

This guide explains how to install beta versions of Keybase via homebrew.

### Install

To install keybase (from this tap): `brew install keybase/beta/keybase`.

To install keybase from source: `brew install --build-from-source keybase/beta/keybase`.

### Run Modes

The brew beta currently runs in `staging` run mode. This will later be changed to run in `prod` mode.

If you want to install an additional homebrew service that uses `devel` run mode, you can run:

`keybase launchd install homebrew.mxcl.keybase.devel /usr/local/opt/keybase/bin/keybase --run-mode=devel`

**Warning**: We don't currently prevent you from installing multiple services with the same run mode, which will cause the newly installed service to fail (since one already exists). I'll be working on this soon.

### Updating the Formula

This example assumes the version is `1.0.0-15`.

- Edit the URL: `https://github.com/keybase/client-beta/archive/v1.0.0-15.tar.gz`
- Download the binary and calculate the sha256:

          wget https://github.com/keybase/client-beta/archive/v1.0.0-15.tar.gz
          shasum -a 256 v1.0.0-15.tar.gz

- Update the version: `version "1.0.0-15"`
- Comment out the bottle section. We will update it below.
- Commit and push the changes. After pushing, update your tap: `brew update`.

### Bottling

    brew uninstall keybase    
    brew install --build-bottle keybase
    brew postinstall keybase/keybase/keybase
    brew bottle keybase

In the `keybase/client-beta` repository, draft a new release. Select the correct/matching tag version from the drop down.
Update the release title (you can use the version `v1.0.0-15`) and description should include changes from the previous release. Then upload the `keybase-1.0.0-15.yosemite.bottle.tar.gz` file, mark pre-release and hit Publish.

Update the root_url for the bottle section of keybase.rb and push to the repo. It doesn't include the `tar.gz` file name.

    root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-15/"

Commit and push the changes. After pushing, update your tap: `brew update`.

Then try testing the bottle by uninstalling and re-installing.
