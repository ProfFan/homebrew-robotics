class BoostPython168 < Formula
    desc "C++ library for C++/Python2 interoperability"
    homepage "https://www.boost.org/"
    url "https://dl.bintray.com/boostorg/release/1.68.0/source/boost_1_68_0.tar.bz2"
    sha256 "7f6130bc3cf65f56a618888ce9d5ea704fa10b462be126ad053e80e553d6d8b7"
    head "https://github.com/boostorg/boost.git"
  
    depends_on "boost@1.68"
    
    keg_only :versioned_formula

    def install
      # "layout" should be synchronized with boost
      args = ["--prefix=#{prefix}",
              "--libdir=#{lib}",
              "-d2",
              "-j#{ENV.make_jobs}",
              "--layout=tagged-1.66",
              # --no-cmake-config should be dropped if possible in next version
              "--no-cmake-config",
              "threading=multi,single",
              "link=shared,static"]
  
      # Boost is using "clang++ -x c" to select C compiler which breaks C++14
      # handling using ENV.cxx14. Using "cxxflags" and "linkflags" still works.
      args << "cxxflags=-std=c++14"
      if ENV.compiler == :clang
        args << "cxxflags=-stdlib=libc++" << "linkflags=-stdlib=libc++"
      end
  
      pyver = Language::Python.major_minor_version "python"
  
      system "./bootstrap.sh", "--prefix=#{prefix}", "--libdir=#{lib}",
                               "--with-libraries=python", "--with-python=python"
  
      system "./b2", "--build-dir=build-python", "--stagedir=stage-python",
                     "python=#{pyver}", *args
  
      lib.install Dir["stage-python/lib/*py*"]
      doc.install Dir["libs/python/doc/*"]
    end
  
    test do
      (testpath/"hello.cpp").write <<~EOS
        #include <boost/python.hpp>
        char const* greet() {
          return "Hello, world!";
        }
        BOOST_PYTHON_MODULE(hello)
        {
          boost::python::def("greet", greet);
        }
      EOS
  
      pyprefix = `python-config --prefix`.chomp
      pyincludes = Utils.popen_read("python-config --includes").chomp.split(" ")
      pylib = Utils.popen_read("python-config --ldflags").chomp.split(" ")
  
      system ENV.cxx, "-shared", "hello.cpp", "-L#{lib}", "-lboost_python27",
                      "-o", "hello.so", "-I#{pyprefix}/include/python2.7",
                      *pyincludes, *pylib
  
      output = <<~EOS
        from __future__ import print_function
        import hello
        print(hello.greet())
      EOS
      assert_match "Hello, world!", pipe_output("python", output, 0)
    end
  end