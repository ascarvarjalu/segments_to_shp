#Import QGIS Libraries - Make sure you instaled it
from qgis.core import *
import qgis.utils
import processing
from qgis.analysis import QgsNativeAlgorithms
import processing
from processing.core.Processing import Processing
Processing.initialize()
QgsApplication.processingRegistry().addProvider(QgsNativeAlgorithms())

#Set path of table and work folder
folder = 'D:/PC Alba Carvajal/Proyecto_Neotectonica_Dagua-Calima_ASC/Codigos/extraccion_segmentos/'
idx_table = 'Z:/Neotectonica_Zona_B/6_CODIGOS/indices_segmento/myData.csv'
CRS = 'EPSG:4326'

#From MATLAB table to shp.
processing.run("native:createpointslayerfromtable", {'INPUT': idx_table,'XFIELD':'x_1','YFIELD':'y_1','ZFIELD':'','MFIELD':'','TARGET_CRS':CRS,'OUTPUT': folder + 'start_points.shp'})
processing.run("native:createpointslayerfromtable", {'INPUT': idx_table,'XFIELD':'x_2','YFIELD':'y_2','ZFIELD':'','MFIELD':'','TARGET_CRS':CRS,'OUTPUT':folder + 'end_points.shp'})
processing.run("native:mergevectorlayers", {'LAYERS':[folder + 'start_points.shp',folder + 'end_points.shp'],'CRS':CRS,'OUTPUT': folder + 'merged_points.shp'})
processing.run("native:pointstopath", {'INPUT': folder + 'merged_points.shp','GROUP_EXPRESSION':'"IX_1"', 'TARGET_CRS':CRS, 'OUTPUT':folder + 'segments.shp'})
processing.run("native:joinattributestable", {'INPUT':folder + 'segments.shp','FIELD':'IX_1','INPUT_2':folder + 'start_points.shp','FIELD_2':'IX_1','FIELDS_TO_COPY':['IX_1','strahler','angle','length','flength','sinuosity','dz','slope','amean','ksn'],'METHOD':1,'DISCARD_NONMATCHING':False,'PREFIX':'','OUTPUT':folder + 'segments_indx.shp'})
print("Check the layer segments_indx.shp in folder:" + folder)
