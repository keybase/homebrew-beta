class KeybaseStaging < Formula
  desc "Keybase (Staging)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-21.tar.gz"
  sha256 "e081c154ad2c270f849850337969891059b1c2a86f17761de178f75fa78750d5"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-21"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/client/go/keybase"
    system "go", "build", "-tags", "staging", "-o", "kbstage", "github.com/keybase/client/go/keybase"

    bin.install "kbstage"
  end

  def post_install
    system "#{opt_bin}/kbstage", "launchd", "install", "homebrew.mxcl.keybase.staging", "#{opt_bin}/kbstage"
  end

  test do
    system "#{bin}/kbstage", "version", "-d"
  end
end
