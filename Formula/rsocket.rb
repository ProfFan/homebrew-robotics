class Rsocket < Formula
  desc "C++ implementation of RSocket"
  homepage "https://github.com/rsocket/rsocket-cpp"
  url "https://github.com/rsocket/rsocket-cpp/archive/v0.10.0.tar.gz"
  sha256 "47aa62c34654c3511fd014393b89491f81a828c53c2f89168e21145c9bb58ff0"
  head "https://github.com/rsocket/rsocket-cpp.git"

  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "libevent"
  depends_on "xz"
  depends_on "snappy"
  depends_on "lz4"
  depends_on "openssl"
  depends_on "folly"

  depends_on :macos => :el_capitan

  needs :cxx11

  def install
    ENV.cxx11
    mkdir "build" do
      system "cmake", "..", "-DCMAKE_BUILD_TYPE=Release", "-DOPENSSL_ROOT_DIR=#{Formula["openssl"].opt_prefix}", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "true"
  end
end
