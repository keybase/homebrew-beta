
## Keybase Homebrew Tap

### Tap

To install the keybase tap:

`brew tap keybase/keybase`

To prioritize this tap over the default:

`brew tap-pin keybase/keybase`

### Updating the Formula

This example assumes the version is `1.0.0-15`.

- Edit the URL: `https://github.com/keybase/client-beta/archive/v1.0.0-15.tar.gz`
- Update the sha256: `shasum -a 256 v1.0.0-15.tar.gz`
- Update the version: `version "1.0.0-15"`

Create the bottle:

    brew install --build-bottle keybase
    brew bottle keybase

In the `keybase/client-beta` repository, draft a new release. Select the correct/matching tag version from the drop down.
Update the release title (you can use the version `v1.0.0-15`) and description should include changes from the previous release. Then upload the `keybase-1.0.0-15.yosemite.bottle.tar.gz` file, mark pre-release and hit Publish.

Update the root_url for the bottle section of keybase.rb and push to the repo. It doesn't include the `tar.gz` file name.

    root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-15/"

Commit and push the changes. After pushing, update your tap: `brew update`.
