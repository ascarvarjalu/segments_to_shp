# segments_to_shp

This is a simple, not-so-sophisticated workflow to convert the output of the `networksegment` function from TopoToolbox into a shapefile.

The process is divided into two parts:

### 1. 'river_segments_indx.m' (MATLAB)
This script uses the 'networksegment' Topotoolbox function along with a few custom MATLAB operations to compute segment index values. It outputs a '.csv' file (named 'myData.csv') containing the necessary information to later generate a shapefile.

### 2. 'shp_segments_indx.py' (Python in QGIS environment)
This script reads 'myData.csv' and converts it into a shapefile using the 'pointstopath' tool available in QGIS (via the Processing Toolbox).

💡 **Note:**  
If you have trouble running the Python script directly, you can also copy and paste the code into the QGIS Python Console to execute it manually.

![image](https://github.com/user-attachments/assets/f5abce29-9978-4da2-bade-e8b99862090f)


