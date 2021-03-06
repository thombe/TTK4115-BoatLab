load('wave.mat')
window = 4096;
x = psi_w(2,:)*pi/180;
fs = 10;
[pxx,f] = pwelch(x,window, [], [], fs);
pxx=pxx./(2*pi);
f=f.*2*pi;

omega_0 = 0.7823; % Peak frequency
pxx_peak = 0.0007919; % Value at omega_0
sigma = sqrt(pxx_peak);

lambda = 0.09; % Trial and error
K_w = 2*lambda*omega_0*sigma;

 
c = 5; 
omega = 1:2049;
P_psi = zeros(length(omega),1);

%for i=1:2049
%    P_psi(i) = (K_w^2)*i^2*c /(i^4+omega_0^2*(4*lambda^2+2)*i^2+omega_0^4);
%end
P_psi = (K_w^2*f.^2)./ (f.^4+omega_0^4+2*f.^2*omega_0^2*(-1+2*lambda^2));
figure(1)

len = 120;
plot(f(1:len), pxx(1:len),'LineWidth',1.2);

legend('$S_{\psi_\omega}$','$P_{\psi_\omega}$') % Up rigth corner legends
handles(1) = xlabel('Frequency [Rad/s]'); % xLabel
handles(2) = ylabel('Power Density [J/Rad]'); %yLabel
set(legend, 'Interpreter' , 'Latex');
set(legend, 'FontSize' , 14);
set(handles, 'Interpreter' , 'Latex'); % Making them in latex
set(handles, 'Fontsize' , 14); % Fontsize
%set(get(gca,'ylabel'),'rotation',0) % % Rotates text on ylabel

set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 P5p2a_PSD.eps %Sets the filename for export



