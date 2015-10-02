class Kbstage < Formula
  desc "Keybase (Staging)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-27.tar.gz"
  sha256 "7d22d29ef576c6acdea2de7157d7c5eb89f476ff442a92a248bb66ca5bb261a5"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-27"

  depends_on "go" => :build

  bottle do
    cellar :any_skip_relocation
    sha256 "c04b868ba22b8ce2742d3031c9b342cdaa4e5629915e9219e1fa3cb5938c2d07" => :yosemite
    root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-27"
  end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "build", "-a", "-tags", "staging brew", "-o", "kbstage", "github.com/keybase/client/go/keybase"

    bin.install "kbstage"
  end

  def post_install
    system "#{opt_bin}/kbstage", "launchd", "install", "homebrew.mxcl.keybase.staging", "#{opt_bin}/kbstage", "service"
  end

  test do
    system "#{bin}/kbstage", "version"
  end
end
