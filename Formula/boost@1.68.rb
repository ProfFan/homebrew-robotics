class BoostAT168 < Formula
    desc "Collection of portable C++ source libraries"
    homepage "https://www.boost.org/"
    url "https://dl.bintray.com/boostorg/release/1.68.0/source/boost_1_68_0.tar.bz2"
    sha256 "7f6130bc3cf65f56a618888ce9d5ea704fa10b462be126ad053e80e553d6d8b7"
  
    keg_only :versioned_formula
  
    def install
      # Force boost to compile with the desired compiler
      open("user-config.jam", "a") do |file|
        file.write "using darwin : : #{ENV.cxx} ;\n"
      end
  
      # libdir should be set by --prefix but isn't
      bootstrap_args = %W[
        --prefix=#{prefix}
        --libdir=#{lib}
        --without-icu
      ]
  
      # Handle libraries that will not be built.
      without_libraries = ["mpi"]
  
      # Boost.Log cannot be built using Apple GCC at the moment. Disabled
      # on such systems.
      without_libraries << "log" if ENV.compiler == :gcc
  
      bootstrap_args << "--without-libraries=#{without_libraries.join(",")}"
  
      # layout should be synchronized with boost-python
      args = %W[
        --prefix=#{prefix}
        --libdir=#{lib}
        -d2
        -j#{ENV.make_jobs}
        --layout=tagged
        --user-config=user-config.jam
        install
        threading=multi,single
        link=shared,static
        cxxstd=17
      ]
  
      system "./bootstrap.sh", *bootstrap_args
      system "./b2", "headers"
      system "./b2", *args
    end
  
    def caveats
      s = ""
      # ENV.compiler doesn't exist in caveats. Check library availability
      # instead.
      if Dir["#{lib}/libboost_log*"].empty?
        s += <<~EOS
          Building of Boost.Log is disabled because it requires newer GCC or Clang.
        EOS
      end
  
      s
    end
  
    test do
      (testpath/"test.cpp").write <<~EOS
        #include <boost/algorithm/string.hpp>
        #include <string>
        #include <vector>
        #include <assert.h>
        using namespace boost::algorithm;
        using namespace std;
  
        int main()
        {
          string str("a,b");
          vector<string> strVec;
          split(strVec, str, is_any_of(","));
          assert(strVec.size()==2);
          assert(strVec[0]=="a");
          assert(strVec[1]=="b");
          return 0;
        }
      EOS
      system ENV.cxx, "-I#{include}", "test.cpp", "-std=c++1y", "-L#{lib}",
             "-lboost_system", "-o", "test"
      system "./test"
    end
  end