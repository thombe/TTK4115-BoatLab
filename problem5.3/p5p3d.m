
s = tf('s'); 
T_d = T; 
K_pd = 0.841;
T_f = 8.35;
%H_ship = K/(s*(T*s+1));
%H_pd = K_pd*(1+T_d*s)/(1+T_f*s); 
H_t = K_pd/(1+T_f*s);
H_pi = K/s;

%H = H_ship*H_pd;
%figure(1)
%margin(H_pi);
%figure(2)
%margin(H_t);
%figure(3)
%margin(H_pi * H_t);

psi_r = 30;

figure(1)

ref = 30.*ones(length(heading.Time),1);
plot(rudder.Time,rudder.Data,'LineWidth',1.2);

title('Rudder input, PD controller with current disturbance');
legend('$\delta$','$\delta$') % Up rigth corner legends
handles(1) = xlabel('Time'); % xLabel
handles(2) = ylabel('Rudder angle'); %yLabel
set(legend, 'Interpreter' , 'Latex');
set(legend, 'FontSize' , 20);
set(handles, 'Interpreter' , 'Latex'); % Making them in latex
set(handles, 'Fontsize' , 20); % Fontsize
%set(get(gca,'ylabel'),'rotation',0) % % Rotates text on ylabel