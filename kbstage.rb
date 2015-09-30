class Kbstage < Formula
  desc "Keybase (Staging)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-26.tar.gz"
  sha256 "07290246b88af2bb34601144e6158b490e9deed8c445795ac119852089c12e57"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-26"

  depends_on "go" => :build

  bottle do
    cellar :any_skip_relocation
    root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-26/"
    sha256 "1e1d1c9ffd32718e69edbbd00ebfc74017df4e3aac48029d519e4d7841194d08" => :yosemite
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
    # Uninstall previous conflicting beta homebrew install. This is only temporary.
    system "#{opt_bin}/kbstage", "launchd", "uninstall", "homebrew.mxcl.keybase"

    system "#{opt_bin}/kbstage", "launchd", "install", "homebrew.mxcl.keybase.staging", "#{opt_bin}/kbstage", "service"
  end

  test do
    system "#{bin}/kbstage", "version"
  end
end
