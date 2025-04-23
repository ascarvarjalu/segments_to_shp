# segments_to_shp
Download matlab segments dataset, after running networksegment Topotoolbox function, and process it with pyqgis to obtain .shp segments.

I did a non-sofisticated code to convert the output of the networksegment Topotoolbox function into a shapefile.

The process is divided int two codes. The fist one is "river_segments_indx.m", in which I calculate the segments indexes values using networksegment and a couple matlab functions to write a .csv with the necessary values to get the further shapefile, which I called "myData.csv". The second one, "shp_segments_indx.py" is a python code in the qgis enviroment to convert "myData.csv" into a shapefile using the pointstopath tool. 

If you have trouble running the .py in python, you can also run the lines in QGIS the Python Console.

![image](https://github.com/user-attachments/assets/f5abce29-9978-4da2-bade-e8b99862090f)


