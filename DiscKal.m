function [sys,x0,str,ts] = DiscKal(t,x,u,flag,data)
    % Shell for the discrete kalman filter assignment in
    % TTK4115 Linear Systems.
    %
    % Author: Jørgen Spjøtvold
    % 19/10-2003 
    %

  switch flag

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(data);%mdlInitializeSizes(data); if method 2 is used

  %%%%%%%%%%%%%
  % Outputs   %
  %%%%%%%%%%%%%
  
  case 3,
    sys=mdlOutputs(t,x,u,data); % mdlOutputs(t,x,u,data) if mathod 2 is used
  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  
  case 2,
    sys=mdlUpdate(t,x,u,data); %mdlUpdate(t,x,u, data); if method 2 is used
  
  case {1,4,}
    sys=[];

  case 9,
      sys=mdlTerminate(t,x,u);
  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
  end
end

function [sys,x0,str,ts]=mdlInitializeSizes(data) %mdlInitializeSizes(data); if method 2 is used
    % This is called only at the start of the simulation. 

    sizes = simsizes; % do not modify

    sizes.NumContStates  = 0; % Number of continuous states in the system, do not modify
    sizes.NumDiscStates  = 35; % Number of discrete states in the system, modify. 
    sizes.NumOutputs     = 2; % Number of outputs, the hint states 2
    sizes.NumInputs      = 2; % Number of inputs, the hint states 2
    sizes.DirFeedthrough = 1; % 1 if the input is needed directly in the
                              % update part
    sizes.NumSampleTimes = 1; % Do not modify  

    sys = simsizes(sizes); % Do not modify  

    x0  = data.x_0; % Initial values for the discrete states, modify

    str = []; % Do not modify

    ts  = [-1 0]; % Sample time. [-1 0] means that sampling is
    % inherited from the driving block and that it changes during
    % minor steps.

end

function sys=mdlUpdate(t,x,u,data)%mdlUpdate(t,x,u, data); if method 2 is used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update the filter covariance matrix and state etsimates here.
% example: sys=x+u(1), means that the state vector after
% the update equals the previous state vector + input nr one.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I = eye(5);
    
    P_pri = reshape(x(11:35),5,5);
    
    L = P_pri*(data.Cd)'*inv((data.Cd*P_pri*(data.Cd)'+data.R));
    
    x_pri = x(1:5);
    
    x_post = x_pri + L*(u(2)-data.Cd*x_pri);
    
    P_post = (I-L*data.Cd)*P_pri*(I-L*data.Cd)'+L*data.R*L';
    
    x_next = data.Ad*x_post + data.Bd*u(1);
    
    P_next = data.Ad*P_post*(data.Ad)' + data.Ed*data.Q*(data.Ed)';
    
    sys=[x_next; x_post; P_next(:)];
    x = sys;
end

function sys=mdlOutputs(t,x,u, data)% mdlOutputs(t,x,u,data) if mathod 2 is used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the outputs here
% example: sys=x(1)+u(2), means that the output is the first state+
% the second input. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sys=[x(8); x(10)];
end

function sys=mdlTerminate(t,x,u) 
    sys = [];
end



