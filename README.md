### Want to Help Test?

Right now, Keybase is developing desktop & mobile apps that do great things with files and messaging.

To prepare, Keybase is adding support for device-specific keys in the command-line client. This will give you crypto on multiple computers without needing to move a PGP private key around. Ultimately, this'll make Keybase more convenient and more secure against the loss of any device.

### How to Install

Our Go client is almost ready. If you're a mac user with [Homebrew](http://brew.sh/) installed, you can start exploring this faster, better multi-key CLI today. Here's how you get it:

          brew tap keybase/beta
          brew update
          brew install keybase/beta/kbstage

Now you can start playing:

          kbstage id gabrielh
          kbstage login
          kbstage search max

### Staging is a Keybase Fork

The `kbstage` command is reading and writing data from [stage0.keybase.io](https://stage0.keybase.io), which is a fork of Keybase. So when you do things with `kbstage`, you are not clobbering your real data on Keybase. Similarly, changes to the live site will not affect the `kbstage` experience. So have at it!

Since it is a fork, you might already have an account on stage0. If so, you can log right in. If not, you can join using the signup code `stage0`.

Note that any data you put on [stage0.keybase.io](https://stage0.keybase.io) might get deleted or reset at any time.

### What We're Looing For

- Testing the [stage0.keybase.io](https://stage0.keybase.io) site in tandem with the app (please, use both!)
- Anything that you can break
- Anything that is confusing (prompts, error messages, etc)
- Security issues
- 
The signup code stage0 can be used repeatedly. Signup as much as you want for testing. Please just don't hammer us with a script, as we are not load testing that server right now.

### Doing Proofs

Proving account ownership is an important part of Keybase, so you'll want to do that with real Twitter, Github, etc. accounts. If you're tweeting, you can always prefix your proof tweet with @keybaseio to keep down the chatter. And proving a stage0 Keybase account will not break your real proofs.

### Sending Us Feedback

Any security related issues should be reported through [HackerOne/keybase](https://hackerone.com/keybase/).

Other issues can be reported to [keybase-issues](https://github.com/keybase/keybase-issues/issues). Please attach a `stage0` label.

### Source Code & More

The source code is located at [keybase/client-beta](https://github.com/keybase/client-beta).

There are more gory details about how we handle environments, update formulas, bottle releases and more, which can be found in the more advanced [Guide](https://github.com/keybase/homebrew-beta/blob/master/GUIDE.md).
