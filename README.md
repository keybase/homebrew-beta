
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

Update the bottle section of keybase.rb and push to the repo.
