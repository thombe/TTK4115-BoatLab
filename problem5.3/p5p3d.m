% From part 1
H1 = 58.71/2;
H2 = 1.676/2;
w1 = 0.005; %rad/s
w2 = 0.05;  %rad/s

T = sqrt((H2^2*w2^2 - H1^2*w1^2) / (H1^2*w1^4 - H2^2*w2^4));
K = H1*w1*sqrt(T^2*w1^2 + 1);

T_d = T; 
K_pd = 0.839;
T_f = 8.4;

psi_r = 30;

figure(1)

subplot(2,1,1);
ref = psi_r.*ones(length(heading.Time),1);
plot(rudder.Time,rudder.Data,'LineWidth',1.2);
grid on;

title('Rudder input, PD controller with wave disturbance');
legend('$\delta$','$\psi_r$') % Up rigth corner legends
handles(1) = xlabel('Time'); % xLabel
handles(2) = ylabel('Rudder input'); %yLabel
set(legend, 'Interpreter' , 'Latex');
set(legend, 'FontSize' , 14);
set(handles, 'Interpreter' , 'Latex'); % Making them in latex
set(handles, 'Fontsize' , 14); % Fontsize
axis([0 500 -50 50]);

subplot(2,1,2);
ref = psi_r.*ones(length(heading.Time),1);
plot(heading.Time,heading.Data,heading.Time,ref,'--','LineWidth',1.2);
grid on;

title('Compass course, PD controller with wave disturbance');
legend('$\psi$','$\psi_r$') % Up rigth corner legends
handles(1) = xlabel('Time'); % xLabel
handles(2) = ylabel('Compass course'); %yLabel
set(legend, 'Interpreter' , 'Latex');
set(legend, 'FontSize' , 14);
set(handles, 'Interpreter' , 'Latex'); % Making them in latex
set(handles, 'Fontsize' , 14); % Fontsize
axis([0 500 0 40]);

set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 P5p3d_rudder_heading.eps %Sets the filename for export
%close;