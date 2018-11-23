

H1 = 58.71/2;
H2 = 1.676/2;
w1 = 0.005; %rad/s
w2 = 0.05;  %rad/s

T = sqrt((H2^2*w2^2 - H1^2*w1^2) / (H1^2*w1^4 - H2^2*w2^4));
K = H1*w1*sqrt(T^2*w1^2 + 1);
pxx_peak = 0.0007919; % Value at omega_0
sigma = sqrt(pxx_peak);

w0 = 0.7823; % Peak frequency
lambda = 0.09; % Trial and error
Kw = 2*lambda*w0*sigma;

T_d = T; 
K_pd = 0.839;
T_f = 8.4;



    %e      psi_w       psi     r       b
A = [0      1           0       0       0;
    -w0*w0  2*lambda*w0 0       0       0;
    0       0           0       1       0;
    0       0           0      -1/T     -K/T;
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

C = [0 1 1 0 0];
D = [0];

T_s = 0.1;
[~, Bd] = c2d(A,B,T_s);
[Ad, Ed] = c2d(A,E,T_s);
Cd = C;
Dd = D;

sim('ship');
variance = var(mn*pi/180);
R = variance/T_s;

Q = [30 0;
    0 10^-6];

P_0 = [1    0      0    0   0;
       0    0.013  0    0   0;
       0    0      pi^2 0   0;
       0    0      0    1   0;
       0    0      0    0   2.5*10^-4];
   
x_0 = [zeros(10,1);P_0(:)];
I = eye(5);
       
psi_r = 30;
data = struct('Ad',Ad,'Bd',Bd,'Cd',Cd,'Ed', Ed, 'Q',Q,'R', R,'P_0',P_0,'x_0',x_0, 'I', I);
          
figure(1)

subplot(2,1,1);
plot(rudder.Time,rudder.Data,bias.Time,bias.Data,'--','LineWidth',1.2);
grid on;

title('Rudder input and bias, PD controller with KF');
legend('$\delta$','$b$') % Up rigth corner legends
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

title('Compass course, PD controller with KF');
legend('$\psi$','$\psi_r$') % Up rigth corner legends
handles(1) = xlabel('Time'); % xLabel
handles(2) = ylabel('Compass course'); %yLabel
set(legend, 'Interpreter' , 'Latex');
set(legend, 'FontSize' , 14);
set(handles, 'Interpreter' , 'Latex'); % Making them in latex
set(handles, 'Fontsize' , 14); % Fontsize
axis([0 500 0 40]);

set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 P5p5d_rudder_heading.eps %Sets the filename for export
%close;

