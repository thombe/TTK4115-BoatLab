%constants
w0 = 1;
lambda = 1;
%K = 1;
%T = 5;
Kw = 1;
%syms w0 lambda T K Kw;

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

h = tf(sys);

%[u,t] = gensig('sine',10,10,0.01);
%lsim(h,u,t);

%figure(1)
%stepplot(sys);
figure(2)
[y,t] = (step(sys,500));
plot(heading_step , t ,y(:,2) ,'--');
%plot(t,y);


