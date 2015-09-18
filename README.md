## Keybase Beta

The repository contains formulas for installing and testing beta builds across different environments.

### Install

These instructions will allow you to install a beta version of the Keybase command line client that hits a staging environment.

1. Add our `keybase/beta` tap (you only need to do this once):

          brew tap keybase/beta
          
1. Update Homebrew (formulas change a lot):

          brew update

1. Install Keybase (staging):
          
          brew install keybase/beta/kbstage


This installs `kbstage` (not `keybase`), so we don't conflict with your regular installation. Use `kbstage` when issuing commands. For example:

          kbstage id gabrielh
          kbstage login
          kbstage search max


### API/Website

The staging website is located at [stage0.keybase.io](https://stage0.keybase.io/).

**Warning**: We may periodically wipe the staging environment, so consider anything performed here to be transient.

### Reporting Issues

Any security related issues should be reported through [HackerOne/keybase](https://hackerone.com/keybase/).

Other issues can be reported to [keybase-issues](https://github.com/keybase/keybase-issues/issues). Please attach a `stage0` label.

### External Sites

Any external tweets/gists still need to be public but should eventually be deleted. You can prefix your tweets with @keybaseio to avoid follower spam if you want.

### More

Details about how we handle environments, update formulas, bottle releases and more can be found in the [Guide](https://github.com/keybase/homebrew-beta/blob/master/GUIDE.md).
