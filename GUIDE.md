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

    cp kbstage.rb /usr/local/Library/Taps/keybase/homebrew-beta
    brew install kbstage

Be sure to revert any changes in `/usr/local/Library/Taps/keybase/homebrew-beta`:

    git checkout kbstage.rb

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
# Install older version
brew uninstall --force keybase
cd 109 # Formula for 1.0.9 is in there
brew install keybase.rb

# Make sure service is running for 1.0.9
keybase ctl restart
keybase version # Should say 1.0.9 for both client and server

# Install from HEAD
brew uninstall --force keybase
brew install --HEAD keybase

keybase version # Should show a version mismatch
keybase id # Should trigger a service restart and then continue
```

### Environments

 Env     | Command                             | Executable
 ------- | ----------------------------------- | ----------
 Prod    | `brew install keybase/beta/keybase` | `keybase`  
 Staging | `brew install keybase/beta/kbstage` | `kbstage`  
 Devel   | `brew install keybase/beta/kbdev`   | `kbdev`    

**Note**: Production (release) build is currently disabled until we deem it safe to run against prod.

To (force) install Keybase from source (this is the default if there is no bottle), use `--build-from-source`. For example:

          brew install --build-from-source keybase/beta/kbstage


Because Keybase has multiple environments (run modes) for development and testing there are different app directories and service launchd labels.

 Env     | App Directory                                   | Service (launchd) Label
 ------- | ----------------------------------------------- | ----------
 Prod    | `~/Library/Application\ Support/Keybase`        | `homebrew.mxcl.keybase`  
 Staging | `~/Library/Application\ Support/KeybaseStaging` | `homebrew.mxcl.keybase.staging`  
 Devel   | `~/Library/Application\ Support/KeybaseDevel`   | `homebrew.mxcl.keybase.devel`

#### Clearing Local State

In the rare case you need to clear your local state, you should stop the service first before removing the application directory.

For example, for staging:

          kbstage launchd stop homebrew.mxcl.keybase.staging
          rm -rf ~/Library/Application\ Support/KeybaseStaging
          kbstage launchd start homebrew.mxcl.keybase.staging

### Building into Brew or Keybase.app

Sometimes it's useful to build a new version of a keybase binary directly over
the existing brew or app install.

For example, kbstage:

```
GO15VENDOREXPERIMENT=1 go build -a -tags "staging brew" -o /usr/local/opt/kbstage/bin/kbstage github.com/keybase/client/go/keybase
```

For KeybaseStage.app:

```
GO15VENDOREXPERIMENT=1 go build -a -tags "staging" -o /Applications/KeybaseStage.app/Contents/SharedSupport/bin/kbstage github.com/keybase/client/go/keybase
```

For example, kbfsstage:

```
GO15VENDOREXPERIMENT=0 go build -a -tags "staging brew" -o /usr/local/opt/kbfsstage/bin/kbfsstage github.com/keybase/kbfs/kbfsfuse
```

### Uninstalling Service

```
# For kbstage
kbstage launchd uninstall homebrew.mxcl.keybase.staging
kbstage launchd uninstall keybase.service.staging

# For keybase
kbstage launchd uninstall homebrew.mxcl.keybase
kbstage launchd uninstall keybase.service
```
