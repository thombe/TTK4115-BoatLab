window = 4096;
x = psi_w(2,:)*pi/180;
fs = 10;
[pxx,f] = pwelch(x,window, [], [], fs);
pxx=pxx./(2*pi);
f=f.*2*pi;
%plot(f, pxx)

omega_0 = 0.7823; % Peak frequency
pxx_peak = 0.0007919; % Value at omega_0
sigma = sqrt(pxx_peak);

lambda = 1; % Trial and error
K_w = 2*lambda*omega_0*sigma;

 
c = ; 
omega = 0:2500;
P_psi = zeros(length(omega));
for i=0:2500
    
end
P_psi = K_w^2*omega^2*c /(omega^4+omega_0^2*(4*lambda+2)*omega^2+omega_0^4);