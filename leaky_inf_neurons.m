Rm = 50 * (10^6);
Cm = 200 * (10^-12);
Ve = -70 * (10^-3);
Vth = -40 * (10^-3);
Vreset = -80 * (10^-3);
delta_t = 10 * (10^-6);

Im1 = 100 * (10^-12);
Im2 = 1 * (10^-9);
Im3 = 10 * (10^-9);

x_values =(0:delta_t:0.1);
y_values1 = [];
y_values2 = [];
y_values3 = [];
new_y1 = Ve;
new_y2 = Ve;
new_y3 = Ve;
for i = 0:delta_t:0.1
    new_y1 = Vm_function(Im1, new_y1);
    y_values1 = [y_values1 new_y1];
    new_y2 = Vm_function(Im2, new_y2);
    y_values2 = [y_values2 new_y2];
    new_y3 = Vm_function(Im3, new_y3);
    y_values3 = [y_values3 new_y3];
end

figure(1)
hold on
subplot(3,1,1)
plot(x_values, y_values1);
subplot(3,1,2)
plot(x_values, y_values2);
subplot(3,1,3)
plot(x_values, y_values3);
hold off

function Vm = Vm_function(Im, old_Vm)
    Rm = 50 * (10^6);
    Cm = 200 * (10^-12);
    Ve = -70 * (10^-3);
    Vth = -40 * (10^-3);
    Vreset = -80 * (10^-3);
    delta_t = 10 * (10^-6);
    
    Vm = old_Vm + (( -old_Vm + (Im*Rm) + Ve) * delta_t / (Rm*Cm));
    
    if Vm >= Vth
        Vm = Vreset;
    end
end
