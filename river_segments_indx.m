% 26th July, 2024
%Alba Sofia Carvajal Useche
%
%Code to extract river segment's indexes using the Topotoolbox
%Then export the output to a csv file.
%
%%
%Load input DEM into a GRIDobj
dem_path = 'D:\PC Alba Carvajal\Proyecto_Neotectonica_Dagua-Calima_ASC\Morfometria\Topotoolbox\Input_Rasters\Raster_Cuencas_Ord5-4\Anch.tif'; %Add you raster path
dem = GRIDobj(dem_path);

%Calculate flow direction using the FLOWobj tool
fd = FLOWobj(dem, 'preprocess', 'carve');

%Carved dem using fd
carved_dem = imposemin(fd, dem);

%Calculate flow accumulation
A = flowacc(fd)

%% Extract rivers
% Set the critical drainage area
A_river=2e6/(10^2); % m^2 %Set your own value
W = A>A_river;
% Extract the wanted network
S = STREAMobj(fd,W);

%% River segments
% Extract segment and compute their orientations
mnratio=0.45;
[segment]=networksegment(S, fd, dem, A, mnratio)
%%
% Plot results
plotsegmentgeometry(S,segment)

%%
%Prepare output to export

%For future plots, we will need the coordinates pair of each segment
%Create X and Y variables.

for i=1:segment.n
     %segments
     X(i,:) = [S.x(segment.ix(i,1)) S.x(segment.ix(i,2))];
     Y(i,:) = [S.y(segment.ix(i,1)) S.y(segment.ix(i,2))];
     %S(i,:) = [segments_copy.strahler];

end
%% Create a new copy of the extructure with those variables
segments_copy = segment
segments_copy.x = X
segments_copy.y = Y

%% Create a table with all that info
% Create variables of associated IX of each segment point

columns = {'IX_1', 'IX_2', 'ix_1', 'ix_2', 'x_1', 'x_2', 'y_1', 'y_2', 'strahler', 'angle', 'length', 'flength', 'sinuosity', 'dz', 'slope', 'amean', 'ksn'};

%segments_table = table(segments_copy.angle, segments_copy.length)

%%
segments_table = table(segment.IX(:,1), segment.IX(:,2), segment.ix(:,1), segment.ix(:,2), ...
                       X(:, 1), X(:, 2), Y(:, 1), Y(:, 2), segment.strahler, segment.angle, segment.length, segment.flength, ...
                       segment.sinuosity, segment.dz, segment.slope, segment.Amean, segment.ksn, 'VariableNames', columns);

%%
%Write table to csv
out_csv_path = 'myData.csv' %Set your folder ad filename path.
writetable(segments_table, out_csv_path, 'Delimiter',';')