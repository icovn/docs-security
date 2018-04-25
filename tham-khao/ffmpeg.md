```
apt-get update -qq && apt-get -y install \
  autoconf \
  automake \
  build-essential \
  cmake \
  git \
  libass-dev \
  libfreetype6-dev \
  libsdl2-dev \
  libtheora-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  mercurial \
  pkg-config \
  texinfo \
  wget \
  zlib1g-dev

 mkdir -p /u01/ffmpeg_sources /u01/applications /u01/bin/

cd /u01/ffmpeg_sources && \
wget http://www.nasm.us/pub/nasm/releasebuilds/2.13.02/nasm-2.13.02.tar.bz2 && \
tar xjvf nasm-2.13.02.tar.bz2 && \
cd nasm-2.13.02 && \
./autogen.sh && \
PATH="/u01/bin/:$PATH" ./configure --prefix="/u01/applications/ffmpeg" --bindir="/u01/bin/" && \
make && \
make install

cd /u01/ffmpeg_sources && \
wget -O yasm-1.3.0.tar.gz https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz && \
tar xzvf yasm-1.3.0.tar.gz && \
cd yasm-1.3.0 && \
./configure --prefix="/u01/applications/ffmpeg" --bindir="/u01/bin/" && \
make && \
make install

cd /u01/ffmpeg_sources && \
git -C x264 pull 2> /dev/null || git clone --depth 1 https://git.videolan.org/git/x264 && \
cd x264 && \
PATH="/u01/bin/:$PATH" PKG_CONFIG_PATH="/u01/applications/ffmpeg/lib/pkgconfig" ./configure --prefix="/u01/applications/ffmpeg" --bindir="/u01/bin/" --enable-static --enable-pic && \
PATH="/u01/bin/:$PATH" make && \
make install

cd /u01/ffmpeg_sources && \
if cd x265 2> /dev/null; then hg pull && hg update; else hg clone https://bitbucket.org/multicoreware/x265; fi && \
cd x265/build/linux && \
PATH="/u01/bin/:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/u01/applications/ffmpeg" -DENABLE_SHARED:bool=off ../../source && \
PATH="/u01/bin/:$PATH" make && \
make install

cd /u01/ffmpeg_sources && \
git -C libvpx pull 2> /dev/null || git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git && \
cd libvpx && \
PATH="/u01/bin/:$PATH" ./configure --prefix="/u01/applications/ffmpeg" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm && \
PATH="/u01/bin/:$PATH" make && \
make install


cd /u01/ffmpeg_sources && \
git -C fdk-aac pull 2> /dev/null || git clone --depth 1 https://github.com/mstorsjo/fdk-aac && \
cd fdk-aac && \
autoreconf -fiv && \
./configure --prefix="/u01/applications/ffmpeg" --disable-shared && \
make && \
make install


cd /u01/ffmpeg_sources && \
wget -O lame-3.100.tar.gz https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz && \
tar xzvf lame-3.100.tar.gz && \
cd lame-3.100 && \
PATH="/u01/bin/:$PATH" ./configure --prefix="/u01/applications/ffmpeg" --bindir="/u01/bin/" --disable-shared --enable-nasm && \
PATH="/u01/bin/:$PATH" make && \
make install

cd /u01/ffmpeg_sources && \
git -C opus pull 2> /dev/null || git clone --depth 1 https://github.com/xiph/opus.git && \
cd opus && \
./autogen.sh && \
./configure --prefix="/u01/applications/ffmpeg" --disable-shared && \
make && \
make install

cd /u01/ffmpeg_sources && \
wget -O ffmpeg-3.4.2.tar.bz2 https://ffmpeg.org/releases/ffmpeg-3.4.2.tar.bz2 && \
tar xjvf ffmpeg-3.4.2.tar.bz2 && \
cd ffmpeg-3.4.2 && \
PATH="/u01/bin/:$PATH" PKG_CONFIG_PATH="/u01/applications/ffmpeg/lib/pkgconfig" ./configure \
  --prefix="/u01/applications/ffmpeg" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I/u01/applications/ffmpeg/include" \
  --extra-ldflags="-L/u01/applications/ffmpeg/lib" \
  --extra-libs="-lpthread -lm" \
  --bindir="/u01/bin/" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree && \
PATH="/u01/bin/:$PATH" make && \
make install && \
hash -r

```



