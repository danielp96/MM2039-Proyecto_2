

% data1 = voltaje referencia, data2 = voltaje capacitor
[t, data1, data2] = filter_data('./data.csv', 40, 5/125, 200, 400);

% remover plot luego
plot(data1);
hold on
plot(data2);

%
% CODE GOES HERE
%

function [t, data1, data2] = filter_data(file, offset, scale, start_x, end_x)
    data_temp = readtable(file);
    
    t = 0:0.004:(size(data_temp.CH1, 1)-1)*0.004;
    t = t';
    
    t = t(1:(end_x - start_x + 1));
    
    data1 = (data_temp.CH1(start_x:end_x) - offset)*scale;
    data2 = (data_temp.CH2(start_x:end_x) - offset)*scale;

end