#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/kurt/Robotics/src/ar3"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/kurt/Robotics/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/kurt/Robotics/install/lib/python2.7/dist-packages:/home/kurt/Robotics/build/ar3/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/kurt/Robotics/build/ar3" \
    "/usr/bin/python2" \
    "/home/kurt/Robotics/src/ar3/setup.py" \
     \
    build --build-base "/home/kurt/Robotics/build/ar3" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/kurt/Robotics/install" --install-scripts="/home/kurt/Robotics/install/bin"
