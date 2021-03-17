Rm = 50 * (10^6);
Cm = 200 * (10^-12);
Ve = -70 * (10^-3);
Vth = -40 * (10^-3);
Vreset = -80 * (10^-3);
delta_t = 10 * (10^-6);

delta_I = 100 * 10^(-12);
maxI = 10 * 10^(-9);
I_values = (0:delta_I:maxI);
modelI_values = [];
theoryI_values = [];
Ith = (Vth - Ve) / Rm;
t_ref = 3*10^(-3);
for Im = 0:delta_I:maxI
    % Thereotical
    if Im <= Ith
        theoryI = 0;
    else
        theoryI = (t_ref + (Rm*Cm*log( ((Im*Rm)+Ve-Vreset) / ((Im*Rm)+Ve-Vth) )))^(-1);
    end
    theoryI_values = [theoryI_values theoryI];
    
    % Model
    x_values = (0:delta_t:0.1);
    y_values1 = [];
    new_y1 = Ve;
    reset = 0;
    peak_values = [];
    for i = 0:delta_t:0.1
        if reset == 1
            new_y1 = Vreset;
            if i >= ready_x
                reset = 0;
            end
        else
            [new_y1, reset] = Vm_function(Im, new_y1);
            if reset == 1
                ready_x = i + t_ref;
                peak_values = [peak_values i];
            end
        end
        y_values1 = [y_values1 new_y1];
    end
    if length(peak_values) > 1
        modelI_f = (1/(peak_values(2) - peak_values(1)));
    else
        modelI_f = 0; % ._.
    end
    modelI_values = [modelI_values modelI_f];
end

figure(2)
hold on
plot(I_values, modelI_values, 'color', 'r')
plot(I_values, theoryI_values, 'color', 'b')
hold off

function [Vm, reset] = Vm_function(Im, old_Vm)
    reset = 0;
    Rm = 50 * (10^6);
    Cm = 200 * (10^-12);
    Ve = -70 * (10^-3);
    Vth = -40 * (10^-3);
    Vreset = -80 * (10^-3);
    delta_t = 10 * (10^-6);
    
    Vm = old_Vm + (( -old_Vm + (Im*Rm) + Ve) * delta_t / (Rm*Cm));
    
    if Vm >= Vth
        Vm = Vreset;
        reset = 1;
    end
end
