class Folly < Formula
  desc "Collection of reusable C++ library artifacts developed at Facebook"
  homepage "https://github.com/facebook/folly"
  url "https://github.com/facebook/folly/archive/v2018.06.18.00.tar.gz"
  sha256 "aa4aa8f4ef18a3bddf06a7ed9349f172b2bbad11cbc0606cdc91517ffe7ee809"
  head "https://github.com/facebook/folly.git"

  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "double-conversion"
  depends_on "gflags"
  depends_on "glog"
  depends_on "libevent"
  depends_on "lz4"
  depends_on macos: :el_capitan
  depends_on "openssl"
  depends_on "snappy"
  depends_on "xz"

  # https://github.com/facebook/folly/issues/451

  # needs :cxx11

  # Known issue upstream. They're working on it:
  # https://github.com/facebook/folly/pull/445
  # fails_with :gcc => "6"

  def install
    ENV.cxx11

    cd "build" do
      system "cmake", "..", "-DOPENSSL_ROOT_DIR=#{Formula["openssl"].opt_prefix}", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cc").write <<~EOS
      #include <folly/FBVector.h>
      int main() {
        folly::fbvector<int> numbers({0, 1, 2, 3});
        numbers.reserve(10);
        for (int i = 4; i < 10; i++) {
          numbers.push_back(i * 2);
        }
        assert(numbers[6] == 12);
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cc", "-I#{include}", "-L#{lib}",
                    "-lfolly", "-o", "test"
    system "./test"
  end
end
