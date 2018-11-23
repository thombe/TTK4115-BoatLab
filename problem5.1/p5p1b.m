H1 = 58.71/2;
H2 = 1.676/2;
w1 = 0.005; %rad/s
w2 = 0.05;  %rad/s

T = sqrt((H2^2*w2^2 - H1^2*w1^2) / (H1^2*w1^4 - H2^2*w2^4));
K = H1*w1*sqrt(T^2*w1^2 + 1);


figure(1)

plot(heading_05.Time,heading_05.Data,'LineWidth',1.2);
grid on;

title('Compass course, no disturbance');
legend('$\psi$','$\psi_r$') % Up rigth corner legends
handles(1) = xlabel('Time'); % xLabel
handles(2) = ylabel('Compass course'); %yLabel
set(legend, 'Interpreter' , 'Latex');
set(legend, 'FontSize' , 14);
set(handles, 'Interpreter' , 'Latex'); % Making them in latex
set(handles, 'Fontsize' , 14); % Fontsize

set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 P5p1b_heading_005.eps %Sets the filename for export
%close;
