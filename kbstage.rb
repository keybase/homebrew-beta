class Kbstage < Formula
  desc "Keybase (Staging)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client/archive/v1.0.3-0.tar.gz"
  sha256 "e384c1dfadb1f1def2cc7f66134fff4992ee3c5083acceacd3f1efd1ea17d8b3"

  head "https://github.com/keybase/client.git"
  version "1.0.3-0"

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

    system "go", "build", "-a", "-tags", "staging brew", "-o", "kbstage", "github.com/keybase/client/go/keybase"

    bin.install "kbstage"
  end

  def post_install
    system "#{opt_bin}/kbstage", "launchd", "restart", "homebrew.mxcl.keybase.staging"
  end

  test do
    system "#{bin}/kbstage", "help"
  end
end
