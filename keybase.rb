class Keybase < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-18.tar.gz"
  sha256 "fa6d91ca154de050eebeb6ecf25c6d083720c86e4f6977084a760b56d7fe4f20"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-18"

  bottle do
    cellar :any_skip_relocation
    root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-18/"
    sha256 "44e2e10b93aa4ec5d17ed6d10ca50b2ac518c0f2ac26d03fdbc0247eed3fb753" => :yosemite
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/client/go/keybase"
    system "go", "build", "-tags", "release", "github.com/keybase/client/go/keybase"

    bin.install "keybase"
  end

  def post_install
    system "#{opt_bin}/keybase", "launchd", "install", "homebrew.mxcl.keybase", "#{opt_bin}/keybase"
  end

  test do
    system "#{bin}/keybase", "version", "-d"
  end
end
