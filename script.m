%

% data1 = voltaje referencia, data2 = voltaje capacitor
[t1, clk1, data1] = filter_data('./data_1uF.csv', 40, 5/125, 42, 253);
[t2, clk2, data2] = filter_data('./data_10uF.csv', 40, 5/125, 428, 670);

% Global
global R1 R2 R3 C1 C2 V qK q2

% System Constants
R1 = 330;
R2 = 330;
R3 = 330;
C1 = 1e-6;
C2 = 10e-6; 
V = 5.00; %Voltage Source
qK = C1*(R3*(R1+R2)+R1*R2); %F1 Den Constant
q2 = C2*R3; % F2 Den Constant
h = 0.00001;
V1 = 0;
V2 = 0;
V1_f = [V1];
V2_f = [V2];
l = linspace(0,h,5000);


for i = 1:size(l, 2)
    [K11] = f1_get(V1_f(i), V2_f(i));
    [K12] = f2_get(V1_f(i), V2_f(i), K11);

    [K21] = f1_get((V1_f(i)+ (3/4)*h*K11),(V2_f(i) + (3/4)*h*K12));
    [K22] = f2_get((V1_f(i)+ (3/4)*h*K11),(V2_f(i) + (3/4)*h*K12), K21);

    m = V1_f(i)+ ((1/3)*K11 + (2/3)*K21)*h;
    V1_f = [V1_f m];
    
    n = V2_f(i)+ ((1/3)*K12 + (2/3)*K22)*h;
    V2_f = [V2_f n];
end

% plots

t = (0:h:h*(size(V1_f, 2)-1));

figure(1)
plot(t, V1_f);
hold on
plot(t1, data1);
title('Voltaje C1')
xlabel('Tiempo (s)')
ylabel('Voltaje (V)')
legend('Metodo Ralston','Experimental', 'Location', 'se')


figure(2)
plot(t, V2_f);
hold on
plot(t2, data2);
title('Voltaje C2')
xlabel('Tiempo (s)')
ylabel('Voltaje (V)')
legend('Metodo Ralston','Experimental', 'Location', 'se')



function [t, data1, data2] = filter_data(file, offset, scale, start_x, end_x)
    data_temp = readtable(file);
    
    t = 0:0.0002:(size(data_temp.CH1, 1)-1)*0.0002;
    t = t';
    
    t = t(1:(end_x - start_x + 1));
    
    data1 = (data_temp.CH1(start_x:end_x) - offset)*scale;
    data2 = (data_temp.CH2(start_x:end_x) - offset)*scale;

end

function [f1] = f1_get(V1, V2) 
    global R1  R3  V qK 
    f1 = (R3*V+ V2*R1 - V1*(R1+R3))/(qK);
end

function [f2] = f2_get(V1, V2, dV1)
    global  R2  C1  q2 
    f2 = (V1-V2+C1*R2*dV1)/(q2);
end

