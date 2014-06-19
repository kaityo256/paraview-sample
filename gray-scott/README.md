# Gray-Scott model

## Summary
An example of 2-D visualization on ParaView.

## Usage

``` 
$ make
$ ./gs
``` 

## Visualization

1. Open file conf..vtk in ParaView, and Apply
2. Move to Last Frame, Rescale to Data Range in Display at Object Inspector
3. Apply filter - Delaunay 2D
4. Apply filter - Warp by Scalar with Scale Factor 10
5. Save Animation will give you the following images.

![Image1](gs1.png)
![Image2](gs2.png)
![Image3](gs3.png)
![Image4](gs4.png)
