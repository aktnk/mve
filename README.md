# Introduction ![Build Status](https://travis-ci.org/simonfuhrmann/mve.svg?branch=master)

The Multi-View Environment, MVE, is an implementation of a complete
end-to-end pipeline for image-based geometry reconstruction. It features
Structure-from-Motion, Multi-View Stereo and Surface Reconstruction.
Further, this is an effort to ease the work with multi-view datasets and
to support the development of algorithms based on multiple views. MVE has
been developed at the TU Darmstadt by Michael Goesele's research group,
and is cucrently in maintenance mode, i.e., new features are rarely added.

This README covers compilation and basic information about the pipeline.
For documentation, please refer to the Wiki pages on GitHub.

 * https://github.com/simonfuhrmann/mve/wiki

MVE is written in C++ and comes with a set of easy-to-use, cross-platform
libraries. The code runs on Linux, MacOS X and (sometimes) Windows. MVE has
minimal dependencies on external libraries; it depends on `libpng`,
`libjpeg` and `libtiff`. A front-end QT-based application called UMVE is
built on top of these libraries, for visualization of the datasets.

If you use our system and want to mention MVE in your publications, please
cite the following paper:

**MVE – A Multi-View Reconstruction Environment** —
[Paper, 10MB](http://www.simonfuhrmann.de/papers/gch2014-mve.pdf)<br>
Simon Fuhrmann, Fabian Langguth and Michael Goesele<br>
In: *Proceedings of the Eurographics Workshop on Graphics and Cultural
Heritage, Darmstadt, Germany, 2014.*

# Building MVE and UMVE

## Compiling on Linux

To download and build MVE, type:

    $ git clone https://github.com/simonfuhrmann/mve.git
    $ cd mve
    $ make -j8

To compile and run UMVE, the Qt user interface, type:

    $ cd apps/umve/
    $ qmake && make -j8
    $ ./umve

System requirements to compile and run MVE or UVME are:

 * libjpeg (for MVE, http://www.ijg.org/)
 * libpng (for MVE, http://www.libpng.org/pub/png/libpng.html)
 * libtiff (for MVE, http://www.libtiff.org/)
 * OpenGL (for libogl in MVE and UMVE)
 * Qt 5 (for UMVE, http://www.qt.io)

## Using Docker

To download and build the docker image, type:

    $ git clone https://github.com/simonfuhrmann/mve.git
    $ cd mve
    $ chmod -R 777 data
    $ docker build .

To run the docker container, type:

    $ docker compose up -d

Next, copy the image files to the data/image directory.
And run the reconstruction pipeline.

    $ docker compose exec mve ./reconst_pipe.sh

As a result, the PLY files are saved in the data/scene directory.

    $ ls data/scene/
    prebundle.sfm  pset-L2.ply  surface-L2-clean.ply  surface-L2.ply  synth_0.out  views

If you wish to execute individual commands, type the command you want to execute after `"docker compose exec mve "` . For example, in the case of the makescene command, type:

    $ docker compose exec mve makescene -i data/image data/scene
    MVE Makescene (built on Jun  3 2023, 01:53:34)

    ** Warning: Output dir already exists.
    ** This may leave old views in your scene.
    -> Press ENTER to continue, or CTRL-C to exit.

    Found 15 directory entries.
    Creating output directories...
    Skipping file .gitkeep, cannot load image.
    Importing image: IMG_3472.jpg, writing MVE view: view_0000.mve...
    ...

To stop execution of the docker container, type:

    $ docker compose down
    [+] Running 2/2
     ✔ Container mve-mve-1 Removed
     ✔ Network mve_default  Removed

## Compiling on Windows and OS X

Windows and OS X: Please refer to the Wiki pages for instructions.

# The Reconstruction Pipeline

The MVE reconstruction pipeline is composed of the following components:

 * Creating a dataset, by converting input photos into the MVE File Format.
 * Structure from Motion, which reconstructs the camera parameters.
 * Multi-View Stereo, which reconstructs dense depth maps for each photo.
 * Surface Reconstruction, which reconstructs a surface mesh.

The individual steps of the pipeline are available as command line applications
in the `mve/apps/` directory. Please refer to the
[MVE Users Guide](https://github.com/simonfuhrmann/mve/wiki/MVE-Users-Guide)
for a more detailed description how to use these tools. Note that UMVE is
merely an interface for scene inspection and does not support reconstruction.

# Licensing

See the LICENSE.txt file and the source file headers for more details.
