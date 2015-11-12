class Keybase < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client/archive/v1.0.0-47.tar.gz"
  sha256 "a026fa0df54909989a50d607c0ac942857aa4ca7de00d5adef8ef30f403a082d"

  head "https://github.com/keybase/client.git"
  version "1.0.0-47"

  depends_on "go" => :build

  # bottle do
  #   cellar :any_skip_relocation
  #   sha256 "c04b868ba22b8ce2742d3031c9b342cdaa4e5629915e9219e1fa3cb5938c2d07" => :yosemite
  #   root_url "https://github.com/keybase/client/releases/download/v1.0.0-27"
  # end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"
    system "mkdir", "-p", "src/github.com/keybase/client/"
    system "mv", "go", "src/github.com/keybase/client/"

    system "go", "build", "-a", "-tags", "production brew", "github.com/keybase/client/go/keybase"

    bin.install "keybase"
  end

  def post_install
    system "#{opt_bin}/keybase", "launchd", "restart", "homebrew.mxcl.keybase"
  end

  test do
    system "#{bin}/keybase", "help"
  end
end
