%

% data1 = voltaje referencia, data2 = voltaje capacitor
[t, data1, data2] = filter_data('./data.csv', 40, 5/125, 200, 400);

% remover plot luego
plot(data1);
hold on
plot(data2);

% System Constants
R1 = 1000;
R2 = 500;
R3 = 750;
C1 = 1e-6;
C2 = 1e-6; 
V = 10.00; %Voltage Source
qK = C1)

% F1
f1 = (R3*V+ V2*R1 - V1*(R1+R3))/()
%

function [t, data1, data2] = filter_data(file, offset, scale, start_x, end_x)
    data_temp = readtable(file);
    
    t = 0:0.004:(size(data_temp.CH1, 1)-1)*0.004;
    t = t';
    
    t = t(1:(end_x - start_x + 1));
    
    data1 = (data_temp.CH1(start_x:end_x) - offset)*scale;
    data2 = (data_temp.CH2(start_x:end_x) - offset)*scale;

end