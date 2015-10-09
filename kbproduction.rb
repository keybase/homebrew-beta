class Kbprod < Formula
  desc "Keybase (Production)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-31.tar.gz"
  sha256 "28f3e950416462e39fc9c6abc9ec01891e44a2bdb164d7062f334d5799eaed22"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-31"

  depends_on "go" => :build

  # bottle do
  #   cellar :any_skip_relocation
  #   sha256 "c04b868ba22b8ce2742d3031c9b342cdaa4e5629915e9219e1fa3cb5938c2d07" => :yosemite
  #   root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-27"
  # end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "build", "-a", "-tags", "release brew", "github.com/keybase/client/go/keybase"

    bin.install "keybase"
  end

  def post_install
    system "#{opt_bin}/keybase", "launchd", "install", "homebrew.mxcl.keybase.production", "#{opt_bin}/keybase", "service"
  end

  test do
    system "#{bin}/kbprod", "version"
  end
end
