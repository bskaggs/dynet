Dockerfiles for building DyNet in Ubuntu 16.04 with Jupyter for testing.


To build the CPU version, from this directory run:

```
docker build -t dynet:cpu  ..
```

DyNet can be optimized to use the Intel Math Kernel Library. To build DyNet with a trial license of the Intel MKL, you must indicate that you accept the MKL license agreement. Note that the trial license prohibits you from redistributing the library, so don't publish the resulting image publicly to Docker Hub.

```
docker build -t dynet:mkl --build-arg ACCEPT_MKL_EULA=accept -f Dockerfile.mkl ..
```

To run one of these containers with Jupyter, simply run:

```
docker run -it --rm -p 8888:8888 dynet:cpu
```

or

```
docker run -it --rm -p 8888:8888 dynet:mkl
```

and then visit http://localhost:8888 in your browser.
