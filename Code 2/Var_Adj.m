function [beta Beta]=Var_Adj(C,etha,R)

Beta=newfis('Var_Adj');

%% Inputs %%
% Temperature %
N=[0 6];
B=[4 10 16];
M=[14 19 24];
MB=[22 27 32];
E=[30 36];

Beta= addvar(Beta,'input','Temperature',[0,35]);
Beta= addmf(Beta,'input',1,'Lower','zmf',N);
Beta= addmf(Beta,'input',1,'Low','trimf',B);
Beta= addmf(Beta,'input',1,'Equal','trimf',M);
Beta= addmf(Beta,'input',1,'High','trimf',MB);
Beta= addmf(Beta,'input',1,'Higher','smf',E);

% Rain %
N=[0 0 1];
B=[.8 1.5 2.2];
M=[1.9 3.8 6];
MB=[5 8 12];
E=[10 18 25 35];

Beta= addvar(Beta,'input','Rain',[0,40]);
Beta= addmf(Beta,'input',2,'Lower','zmf',N);
Beta= addmf(Beta,'input',2,'Low','trimf',B);
Beta= addmf(Beta,'input',2,'Equal','trimf',M);
Beta= addmf(Beta,'input',2,'High','trimf',MB);
Beta= addmf(Beta,'input',2,'Higher','smf',E);

% Solar Radiation %
N=[0,150];
B=[120,180,240];
M=[220,400,580];
MB=[560,700,840];
E=[820,1000];

Beta= addvar(Beta,'input','Solar',[0,1200]);
Beta= addmf(Beta,'input',3,'Lower','zmf',N);
Beta= addmf(Beta,'input',3,'Low','trimf',B);
Beta= addmf(Beta,'input',3,'Equal','trimf',M);
Beta= addmf(Beta,'input',3,'High','trimf',MB);
Beta= addmf(Beta,'input',3,'Higher','smf',E);

%  Wind Speed %
N=[0,5];
B=[4,8,12];
M=[10,15,20];
MB=[18,25,32];
E=[30,40];

Beta= addvar(Beta,'input','WindSpeed',[0,50]);
Beta= addmf(Beta,'input',4,'Lower','zmf',N);
Beta= addmf(Beta,'input',4,'Low','trimf',B);
Beta= addmf(Beta,'input',4,'Equal','trimf',M);
Beta= addmf(Beta,'input',4,'High','trimf',MB);
Beta= addmf(Beta,'input',4,'Higher','smf',E);

% Evapotranspiration %
N=[0,0,1]; %(x,[0,0,0.8]);
B=[0.6,1.6,2.6]; %(x,[0.6,1.2,1.8]);
M=[2.3,3.3,4.3]; 
MB=[4,5,6];
E=[5.7,6.7,9.9,10];

Beta= addvar(Beta,'input','Et',[0,10]);
Beta= addmf(Beta,'input',5,'Lower','zmf',N);
Beta= addmf(Beta,'input',5,'Low','trimf',B);
Beta= addmf(Beta,'input',5,'Equal','trimf',M);
Beta= addmf(Beta,'input',5,'High','trimf',MB);
Beta= addmf(Beta,'input',5,'Higher','smf',E);


%% Outputs %%
Uo=[-0.35,0.35];
Low=[-0.3,-0.1];
BLow=[-0.09,-0.05,-0.01];
Equal=[-0.03,0,0.03];
BHigh=[0.01,0.05,0.09];
High=[0.1,0.3];

% Low %
Beta= addvar(Beta,'output','Temperature',Uo);
Beta= addmf(Beta,'output',1,'Low','zmf',Low);
Beta= addmf(Beta,'output',1,'BLow','trimf',BLow);
Beta= addmf(Beta,'output',1,'Equal','trimf',Equal);
Beta= addmf(Beta,'output',1,'BHigh','trimf',BHigh);
Beta= addmf(Beta,'output',1,'High','smf',High);
% Barely Low %
Beta= addvar(Beta,'output','Rain',Uo);
Beta= addmf(Beta,'output',2,'Low','zmf',Low);
Beta= addmf(Beta,'output',2,'BLow','trimf',BLow);
Beta= addmf(Beta,'output',2,'Equal','trimf',Equal);
Beta= addmf(Beta,'output',2,'BHigh','trimf',BHigh);
Beta= addmf(Beta,'output',2,'High','smf',High);
% Equal %
Beta= addvar(Beta,'output','Solar',Uo);
Beta= addmf(Beta,'output',3,'Low','zmf',Low);
Beta= addmf(Beta,'output',3,'BLow','trimf',BLow);
Beta= addmf(Beta,'output',3,'Equal','trimf',Equal);
Beta= addmf(Beta,'output',3,'BHigh','trimf',BHigh);
Beta= addmf(Beta,'output',3,'High','smf',High);
% Barely High %
Beta= addvar(Beta,'output','Wind',Uo);
Beta= addmf(Beta,'output',4,'Low','zmf',Low);
Beta= addmf(Beta,'output',4,'BLow','trimf',BLow);
Beta= addmf(Beta,'output',4,'Equal','trimf',Equal);
Beta= addmf(Beta,'output',4,'BHigh','trimf',BHigh);
Beta= addmf(Beta,'output',4,'High','smf',High);
% High %
Beta= addvar(Beta,'output','Et',Uo);
Beta= addmf(Beta,'output',5,'Low','zmf',Low);
Beta= addmf(Beta,'output',5,'BLow','trimf',BLow);
Beta= addmf(Beta,'output',5,'Equal','trimf',Equal);
Beta= addmf(Beta,'output',5,'BHigh','trimf',BHigh);
Beta= addmf(Beta,'output',5,'High','smf',High);

%% Rules %%
[R t x]=xlsread('Reglas.xlsx','A1:L236');
Beta=addrule(Beta,R);

%% Evaluación %%
beta=evalfis(C,Beta);



end