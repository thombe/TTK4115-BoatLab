function [sys,x0,str,ts] = DiscKal(t,x,u,flag,data)
    % Shell for the discrete kalman filter made by Jørgen Spjøtvold

  switch flag

  % Initialization %
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes(data);

  % Outputs   %  
  case 3
    sys=mdlOutputs(t,x,u,data);
    
  % Terminate %  
  case 2
    sys=mdlUpdate(t,x,u,data);
  
  case {1,4,}
    sys=[];

  case 9
      sys=mdlTerminate(t,x,u);
  
  % Unexpected flags %
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
  end
end

function [sys,x0,str,ts]=mdlInitializeSizes(data)   

    sizes = simsizes;

    sizes.NumContStates  = 0;
    sizes.NumDiscStates  = 35;
    sizes.NumOutputs     = 3;
    sizes.NumInputs      = 2;
    sizes.DirFeedthrough = 0;                             
    sizes.NumSampleTimes = 1;

    sys = simsizes(sizes);

    x0  = data.x_0;
    
    
    str = [];

    ts  = [-1 0]; % Sample time.
end

function x=mdlUpdate(t,x,u,data)
    I = eye(5);
    
    P_pri = reshape(x(11:35),5,5);
    
    L = P_pri*(data.Cd)'*(data.Cd*P_pri*(data.Cd)'+data.R)^-1;
    
    x_pri = x(1:5);
    
    x_post = x_pri + L*(u(2)-data.Cd*x_pri);
    
    P_post = (I-L*data.Cd)*P_pri*(I-L*data.Cd)'+L*data.R*L';
    
    x_next = data.Ad*x_post + data.Bd*u(1);
    
    P_next = data.Ad*P_post*(data.Ad)' + data.Ed*data.Q*(data.Ed)';
    
    x(1:5) = x_next;
    x(6:10) = x_post;
    x(11:35) = P_next;
    %sys=[x_next; x_post; P_next(:)];
    %x = sys;
end

function sys=mdlOutputs(t,x,u, data)
    sys=[x(8); x(10); x(7)]; % psi, b , psi_w
end

function sys=mdlTerminate(t,x,u) 
    sys = [];
end



