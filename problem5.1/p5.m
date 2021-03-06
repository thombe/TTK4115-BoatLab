
%constants
w0 = 1;
lambda = 1;
K = 1;
T = 5;



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

h = tf(sys);


