class Kbstage < Formula
  desc "Keybase (Staging)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-25.tar.gz"
  sha256 "47f29fbce993dcacbfa790476699d8946bded97e2053310744dfff36475f1cba"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-25"

  depends_on "go" => :build

  # bottle do
  #   cellar :any_skip_relocation
  #   root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-24/"
  #   sha256 "92e6fe3931d7121551881b8a8a5661b512b4f7c66f56836a3a0c3dc2f32ebb4b" => :yosemite
  # end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/client/go/keybase"
    system "go", "build", "-a", "-tags", "staging brew", "-o", "kbstage", "github.com/keybase/client/go/keybase"

    bin.install "kbstage"
  end

  def post_install
    # Uninstall previous conflicting beta homebrew install. This is only temporary.
    system "#{opt_bin}/kbstage", "launchd", "uninstall", "homebrew.mxcl.keybase"

    system "#{opt_bin}/kbstage", "launchd", "install", "homebrew.mxcl.keybase.staging", "#{opt_bin}/kbstage"
  end

  test do
    system "#{bin}/kbstage", "version"
  end
end
