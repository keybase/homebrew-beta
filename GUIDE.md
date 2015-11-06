### Updating the Formula

These steps can apply to all formulas in this repo.
This example assumes the version is `1.2.3-400`.

- Edit the source archive URL:

    https://github.com/keybase/client/archive/v1.2.3-400.tar.gz

- Calculate the sha256:

    curl -L -s https://github.com/keybase/client/archive/v1.2.3-400.tar.gz | shasum -a 256

- Update the formula version:

    version "1.2.3-400"

- Comment out the bottle section (if present). We will update it later.

### Testing

To test the formula:

    cp kbstage.rb /usr/local/Library/Taps/keybase/homebrew-beta
    brew install kbstage

Be sure to revert any changes in `/usr/local/Library/Taps/keybase/homebrew-beta`:

    git checkout kbstage.rb

### Bottling

    brew uninstall --force kbstage
    brew install --build-bottle keybase/beta/kbstage
    brew postinstall keybase/beta/kbstage
    brew bottle keybase/beta/kbstage

Copy the bottle into the formula. In the bottle block, update the root_url for the bottle section of keybase.rb and push to the repo. It doesn't include the `tar.gz` file name:

    root_url "https://github.com/keybase/client/releases/download/v1.2.3-400/"

In the `keybase/client` repository, draft a new release. Select the correct/matching tag version from the drop down.
Update the release title (you can use the version `v1.2.3-400`) and description should include changes from the previous release. Then upload the `kbstage-1.2.3-400.yosemite.bottle.tar.gz` file, mark pre-release and hit Publish.

Then try testing the bottle by uninstalling and re-installing.

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

### Building into Brew

Sometimes it's useful to build a new version of a keybase binary directly over
the existing brew install.

For example, kbstage:

```
go build -a -tags "staging brew" -o /usr/local/opt/kbstage/bin/kbstage github.com/keybase/client/go/keybase
/usr/local/opt/kbstage/bin/kbstage launchd install homebrew.mxcl.keybase.staging /usr/local/opt/kbstage/bin/kbstage service
```

For example, kbfsstage:

```
go build -a -tags "staging brew" -o /usr/local/opt/kbfsstage/bin/kbfsstage github.com/keybase/kbfs/kbfsfuse
/usr/local/opt/kbstage/bin/kbstage launchd install homebrew.mxcl.kbfs.staging  /usr/local/opt/kbfsstage/bin/kbfsstage $HOME/Keybase.stage
```
