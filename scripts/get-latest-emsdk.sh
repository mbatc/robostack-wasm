
mkdir -p "../downloads/"

cd ../downloads

if [ ! -d "emsdk/.git" ]; then
  echo Cloning emsdk
  cd ../downloads
  git clone https://github.com/emscripten-core/emsdk.git
fi

echo Reset to origin/main

cd emsdk
git fetch --all
git checkout --force main
git reset --hard origin/main
git submodule update --init --recursive

echo Install latest sdk

./emsdk install latest
./emsdk activate latest
