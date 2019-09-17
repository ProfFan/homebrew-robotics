class OgreAT112 < Formula
    desc "Scene-oriented 3D engine written in c++"
    homepage "https://www.ogre3d.org/"
    url "https://github.com/OGRECave/ogre/archive/v1.12.2.zip"
    version "1.12.2"
    sha256 "75739230ffa6a677fe40b33edc1f93fb800e6ad507ea287c92a83e775fbc8826"
    revision 1

    option "with-cg"
  
    depends_on "cmake" => :build
    depends_on "boost"
    depends_on "doxygen"
    depends_on "freeimage"
    depends_on "freetype"
    depends_on "libzzip"
    depends_on "tbb"
    depends_on :x11
  
    conflicts_with "ogre", :because => "Differing version of the same formula"

    def install
      ENV.m64
  
      cmake_args = [
        "-DCMAKE_OSX_ARCHITECTURES='x86_64'",
        "-DOGRE_BUILD_LIBS_AS_FRAMEWORKS=OFF",
        "-DOGRE_FULL_RPATH:BOOL=FALSE",
        "-DOGRE_BUILD_DOCS:BOOL=FALSE",
        "-DOGRE_INSTALL_DOCS:BOOL=FALSE",
        "-DOGRE_BUILD_SAMPLES:BOOL=FALSE",
        "-DOGRE_INSTALL_SAMPLES:BOOL=FALSE",
        "-DOGRE_INSTALL_SAMPLES_SOURCE:BOOL=FALSE",
      ]
      cmake_args << "-DOGRE_BUILD_PLUGIN_CG=OFF" if build.without? "cg"
      cmake_args.concat(std_cmake_args)
      cmake_args << ".."
  
      mkdir "build" do
        system "cmake", *cmake_args
        system "make", "install"
      end
  
      # Put these cmake files where Debian puts them
      (share/"OGRE/cmake/modules").install Dir[prefix/"CMake/*.cmake"]
      rmdir prefix/"CMake"
  
      # This is necessary because earlier versions of Ogre seem to have created
      # the plugins with "lib" prefix and software like "rviz" now has Mac
      # specific code that looks for the plugins with "lib" prefix. Hence we add
      # symlinks with the "lib" prefix manually, but their use is deprecated.
      Dir.glob(lib/"OGRE/*.dylib") do |path|
        filename = File.basename(path)
        symlink path, lib/"OGRE/lib#{filename}"
      end
    end
  
    test do
      (testpath/"test.mesh.xml").write <<-EOS
        <mesh>
          <submeshes>
            <submesh material="BaseWhite" usesharedvertices="false" use32bitindexes="false" operationtype="triangle_list">
              <faces count="1">
                <face v1="0" v2="1" v3="2" />
              </faces>
              <geometry vertexcount="3">
                <vertexbuffer positions="true" normals="false" texture_coords="0">
                  <vertex>
                    <position x="-50" y="-50" z="50" />
                  </vertex>
                  <vertex>
                    <position x="-50" y="-50" z="-50" />
                  </vertex>
                  <vertex>
                    <position x="50" y="-50" z="-50" />
                  </vertex>
                </vertexbuffer>
              </geometry>
            </submesh>
          </submeshes>
          <submeshnames>
            <submeshname name="submesh0" index="0" />
          </submeshnames>
        </mesh>
      EOS
      system "#{bin}/OgreXMLConverter", "test.mesh.xml"
      system "du", "-h", "./test.mesh"
      # check for Xcode frameworks in bottle
      cmd_not_grep_xcode = "! grep -rnI 'Applications[/]Xcode' #{prefix}"
      system cmd_not_grep_xcode
    end
  end
  