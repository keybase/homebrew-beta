class Keybase < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-19.tar.gz"
  sha256 "d06a334d383d1fac58e8535214706924844e63ae39f75ab0b6ea595645b1c78c"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-19"

  # bottle do
  #   cellar :any_skip_relocation
  #   revision 1
  #   root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-19/"
  #   sha256 "60a2ae85806d09833eb9ac17fd6447806f41389c83145c43c9f202a398e758f7" => :yosemite
  # end

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
