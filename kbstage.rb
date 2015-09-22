class Kbstage < Formula
  desc "Keybase (Staging)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-23.tar.gz"
  sha256 "ff901b137148bddf7940eec05358af3744496fb7b66e8f1f7abc927aa7d63144"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-23"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/client/go/keybase"
    system "go", "build", "-tags", "staging brew", "-o", "kbstage", "github.com/keybase/client/go/keybase"

    bin.install "kbstage"
  end

  def post_install
    # Uninstall previous conflicting beta homebrew install. This is only temporary.
    system "#{opt_bin}/kbstage", "launchd", "uninstall", "homebrew.mxcl.keybase"

    system "#{opt_bin}/kbstage", "launchd", "install", "homebrew.mxcl.keybase.staging", "#{opt_bin}/kbstage"
  end

  test do
    system "#{bin}/kbstage", "version", "-d"
  end
end
