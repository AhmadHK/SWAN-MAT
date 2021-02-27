function plotgrid(basename)
% Plots unstructured grid generated by TRIANGLE
%
% Example:
%
% TRIANGLE generated files with basename 'f32hari', e.g. 'f32hari.node' and 'f32hari.ele'
% To make a plot of the unstructured grid, give the following command in Matlab:
%
%     plotgrid('f32hari')
%
%
% Author  : Marcel Zijlema
% Date    : February 13, 2008
% Version : 1.0

if nargin~=1
   error('Wrong number of arguments. See "help plotgrid"')
end

nodefile=[basename '.node'];
elefile=[basename '.ele'];
fid = fopen(nodefile);                        % load TRIANGLE vertex based connectivity file
[nnode] = fscanf(fid,'%i',[1 4]);             % get number of nodes
ncol = 3+nnode(3)+nnode(4);                   % specify number of columns in nodefile
data = fscanf(fid,'%f',[ncol nnode(1)])';     % get data
x=data(:,2); y=data(:,3);                     % get coordinates
fid = fopen(elefile);                         % load TRIANGLE element based connectivity file
[nelem] = fscanf(fid,'%i',[1 3]);             % get number of triangles
ncol = 4+nelem(3);                            % specify number of columns in elefile
tri = fscanf(fid,'%i',[ncol nelem(1)])';      % get connectivity table
trimesh(tri(:,2:4),x,y, zeros(size(x)), ...   % make grid using trimesh
                  'EdgeColor', 'k', ...
                  'FaceColor', 'none', ...
                  'LineWidth', 0.5)
view(2)                                       % make 2D view
axis equal                                    % equal axes