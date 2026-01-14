# !/bin/bash

ESCAPE=$'\e'

create_project () {
    touch CMakeLists.txt
    echo "Please number of files"
    read FILES
    touch CMakeLists.txt

    cat >> CMakeLists.txt <<'EOF'
cmake_minimum_required(VERSION 3.10)
project()
add_compile_options(-Wall -Wextra -Wpendatic)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDART_REQUIRED ON)
EOF

    for (( i = 0; i < $FILES; i++)) {
        echo "Enter the name of the file "
        read NAME
        mkdir $NAME
        cd $NAME
        touch $NAME.cc
        touch $NAME.h
        touch CMakeLists.txt
        cat >> CMakeLists.txt << 'EOF'
add_executable

target_include_directories()

target_link_libraries()

install(TARGETS)
EOF
        cd ..
        echo "add_subdirectory($NAME)" >> CMakeLists.txt

    }
}

build_app () {
    rm -rf build/ install/
    mkdir -p build install/bin install/lib
    cmake -S . -B build
    cmake -S . -B build -DCMAKE_INSTALL_PREFIX=./install

    cmake --build build                                         &&

    cmake --install build
}

execute_app() {
    if [ -z "$( ls -A './install/bin/' )" ]; then
        echo "${ESCAPE}[0;31m  There is no executable ! ${ESCAPE}[0m"
        
    else
        ./install/bin/program
    fi
}

# Source - https://stackoverflow.com/a/18560673
# Posted by konsolebox, modified by community. See post 'Timeline' for change history
# Retrieved 2026-01-14, License - CC BY-SA 3.0



echo "${ESCAPE}[1;33m The following functions are available :${ESCAPE}[0m"

echo "${ESCAPE}[1;35m  create_project()${ESCAPE}[0m"
echo "${ESCAPE}[1;35m  build_app()${ESCAPE}[0m"
echo "${ESCAPE}[1;35m  execute_app()${ESCAPE}[0m"