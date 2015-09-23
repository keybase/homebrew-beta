class Kbdev < Formula
  desc "Keybase (Dev)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-24.tar.gz"
  sha256 "37896535cee601066f8000fcb3f6301c5987ab8eefa5cab7bf3ba4ee6f8a72f2"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-24"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/client/go/keybase"
    # No release or staging tag is a (default) devel build
    system "go", "build", "-tags", "brew", "-o", "kbdev", "github.com/keybase/client/go/keybase"

    bin.install "kbdev"
  end

  def post_install
    system "#{opt_bin}/kbdev", "launchd", "install", "homebrew.mxcl.keybase.devel", "#{opt_bin}/kbdev"
  end

  test do
    system "#{bin}/kbdev", "version"
  end
end
