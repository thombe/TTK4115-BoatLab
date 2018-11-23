H1 = 58.71/2;
H2 = 1.676/2;
w1 = 0.005; %rad/s
w2 = 0.05;  %rad/s

T = sqrt((H2^2*w2^2 - H1^2*w1^2) / (H1^2*w1^4 - H2^2*w2^4));
K = H1*w1*sqrt(T^2*w1^2 + 1);

A = [0      1           0       0       0;
    -w0*w0  2*lambda*w0 0       0       0;
    0       0           0       1       0;
    0       0           0      -1/T     K/T;
    0       0           0       0       0];

B = [0;
    0;
    0;
    K/T;
    0];

E = [0  0;
    Kw  0;
    0   0;
    0   0;
    0   1];

C = [0 1 0 0 0;
     0 0 1 0 0];

D = [0;
    0];

sys = ss(A,B,C,D);

figure(2)
[y,t] = (step(sys,2000));
plot(heading_step , t ,y(:,2) ,'--','LineWidth',1.2);

grid on;

title('Step plot');
legend('$\psi$','$\psi_{model}$') % Up rigth corner legends
handles(1) = xlabel('Time'); % xLabel
handles(2) = ylabel('Compass course'); %yLabel
set(legend, 'Interpreter' , 'Latex');
set(legend, 'FontSize' , 14);
set(handles, 'Interpreter' , 'Latex'); % Making them in latex
set(handles, 'Fontsize' , 14); % Fontsize


set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 P5p1dheading.eps %Sets the filename for export
%close;

