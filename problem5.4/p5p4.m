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
Kw = 2*lambda*omega_0*sigma;


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
sys = ss(A,B,C,D);

% With all disturbances
disp(rank(obsv(A, C)) == length(A));

%Without disturbances
Anone = [0 1; 0 -1/T];
Cnone = [1 0];
disp(rank(obsv(Anone, Cnone)) == length(Anone));

% With waves
Awave = [0 1 0 0;
        -w0*w0 -2*lambda*w0 0 0;
        0 0 0 1;
        0 0 0 -1/T];
Cwave =  [0 1 1 0];
disp(rank(obsv(Awave, Cwave)) == length(Awave));

% With current
Acurr = [0 1 0;
        0 -1/T -K/T;
        0 0 0];
Ccurr = [1 0 0];
disp(rank(obsv(Acurr, Ccurr)) == length(Acurr));



