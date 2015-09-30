class Kbdev < Formula
  desc "Keybase (Dev)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-26.tar.gz"
  sha256 "07290246b88af2bb34601144e6158b490e9deed8c445795ac119852089c12e57"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-26"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"
    # This is temporary
    system "rm", "-rf", "src/github.com/keybase/go/vendor"

    system "go", "get", "github.com/keybase/client/go/keybase"
    # No release or staging tag is a (default) devel build
    system "go", "build", "-a", "-tags", "brew", "-o", "kbdev", "github.com/keybase/client/go/keybase"

    bin.install "kbdev"
  end

  def post_install
    system "#{opt_bin}/kbdev", "launchd", "install", "homebrew.mxcl.keybase.devel", "#{opt_bin}/kbdev", "service"
  end

  test do
    system "#{bin}/kbdev", "version"
  end
end
