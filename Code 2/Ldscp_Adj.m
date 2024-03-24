function [alpha Alpha]=Ldscp_Adj(comp)

Alpha=newfis('Lscp_Adj');

%% Inputs %%
Ui=[-1,1];
L=[-0.6,-0.2];
E=[-0.4,0,0.4];
H=[0.2,0.6];
% Grassland %
Alpha= addvar(Alpha,'input','Grassland',Ui);
Alpha= addmf(Alpha,'input',1,'Lower','zmf',L);
Alpha= addmf(Alpha,'input',1,'Equal','trimf',E);
Alpha= addmf(Alpha,'input',1,'Higer','smf',H);
% Tree Cover areas %
Alpha= addvar(Alpha,'input','TreeCover',Ui);
Alpha= addmf(Alpha,'input',2,'Lower','zmf',L);
Alpha= addmf(Alpha,'input',2,'Equal','trimf',E);
Alpha= addmf(Alpha,'input',2,'Higer','smf',H);
% Buildings %
Alpha= addvar(Alpha,'input','Building',Ui);
Alpha= addmf(Alpha,'input',3,'Lower','zmf',L);
Alpha= addmf(Alpha,'input',3,'Equal','trimf',E);
Alpha= addmf(Alpha,'input',3,'Higer','smf',H);
% Elevation %
Alpha= addvar(Alpha,'input','Elevation',Ui);
Alpha= addmf(Alpha,'input',4,'Lower','zmf',L);
Alpha= addmf(Alpha,'input',4,'Equal','trimf',E);
Alpha= addmf(Alpha,'input',4,'Higer','smf',H);
% Spatial Configuration %
Alpha= addvar(Alpha,'input','Spatial',Ui);
Alpha= addmf(Alpha,'input',5,'Lower','zmf',L);
Alpha= addmf(Alpha,'input',5,'Equal','trimf',E);
Alpha= addmf(Alpha,'input',5,'Higer','smf',H);

%% Outputs %%
Uo=[-0.35,0.35];
Low=[-0.3,-0.1];
BLow=[-0.09,-0.05,-0.01];
Equal=[-0.03,0,0.03];
BHigh=[0.01,0.05,0.1];
High=[0.1,0.3];

% Low %
Alpha= addvar(Alpha,'output','Temperature',Uo);
Alpha= addmf(Alpha,'output',1,'Low','zmf',Low);
Alpha= addmf(Alpha,'output',1,'BLow','trimf',BLow);
Alpha= addmf(Alpha,'output',1,'Equal','trimf',Equal);
Alpha= addmf(Alpha,'output',1,'BHigh','trimf',BHigh);
Alpha= addmf(Alpha,'output',1,'High','smf',High);
% Barely Low %
Alpha= addvar(Alpha,'output','Rain',Uo);
Alpha= addmf(Alpha,'output',2,'Low','zmf',Low);
Alpha= addmf(Alpha,'output',2,'BLow','trimf',BLow);
Alpha= addmf(Alpha,'output',2,'Equal','trimf',Equal);
Alpha= addmf(Alpha,'output',2,'BHigh','trimf',BHigh);
Alpha= addmf(Alpha,'output',2,'High','smf',High);
% Equal %
Alpha= addvar(Alpha,'output','Solar',Uo);
Alpha= addmf(Alpha,'output',3,'Low','zmf',Low);
Alpha= addmf(Alpha,'output',3,'BLow','trimf',BLow);
Alpha= addmf(Alpha,'output',3,'Equal','trimf',Equal);
Alpha= addmf(Alpha,'output',3,'BHigh','trimf',BHigh);
Alpha= addmf(Alpha,'output',3,'High','smf',High);
% Barely High %
Alpha= addvar(Alpha,'output','Wind',Uo);
Alpha= addmf(Alpha,'output',4,'Low','zmf',Low);
Alpha= addmf(Alpha,'output',4,'BLow','trimf',BLow);
Alpha= addmf(Alpha,'output',4,'Equal','trimf',Equal);
Alpha= addmf(Alpha,'output',4,'BHigh','trimf',BHigh);
Alpha= addmf(Alpha,'output',4,'High','smf',High);
% High %
Alpha= addvar(Alpha,'output','Et',Uo);
Alpha= addmf(Alpha,'output',5,'Low','zmf',Low);
Alpha= addmf(Alpha,'output',5,'BLow','trimf',BLow);
Alpha= addmf(Alpha,'output',5,'Equal','trimf',Equal);
Alpha= addmf(Alpha,'output',5,'BHigh','trimf',BHigh);
Alpha= addmf(Alpha,'output',5,'High','smf',High);

%% Rules %%

ruleList=[
    1 1 1 0 1  5 4 5 3 4 1 1
    1 1 1 0 2  5 4 5 2 4 1 1
    1 1 1 0 3  5 4 5 1 4 1 1 
    
    1 1 2 0 1  4 4 4 3 3 1 1
    1 1 2 0 2  4 4 4 3 3 1 1
    1 1 2 0 3  4 4 4 2 3 1 1
    
    1 1 3 0 1  3 3 3 2 3 1 1
    1 1 3 0 2  3 3 3 1 3 1 1
    1 1 3 0 3  3 3 3 1 3 1 1
    
    1 2 1 0 1  3 3 4 4 3 1 1
    1 2 1 0 2  3 3 3 3 3 1 1
    1 2 1 0 3  3 3 3 2 3 1 1
    
    1 2 2 0 1  3 3 3 3 4 1 1
    1 2 2 0 2  3 3 3 2 4 1 1  
    1 2 2 0 3  3 3 3 1 4 1 1 
    
    1 2 3 0 1  2 3 2 2 3 1 1
    1 2 3 0 2  2 3 2 2 2 1 1
    1 2 3 0 3  2 3 2 1 2 1 1
    
    1 3 1 0 1  2 2 2 2 3 1 1
    1 3 1 0 2  2 2 2 2 3 1 1
    1 3 1 0 3  2 2 2 1 3 1 1
        
    1 3 2 0 1  2 2 2 2 3 1 1 
    1 3 2 0 2  2 2 2 1 3 1 1
    1 3 2 0 3  2 2 2 1 3 1 1
        
    1 3 3 0 1  1 2 1 1 2 1 1
    1 3 3 0 2  1 2 1 1 2 1 1
    1 3 3 0 3  1 2 1 1 2 1 1
   
    2 1 1 0 1  4 4 4 4 3 1 1  
    2 1 1 0 2  4 4 4 3 3 1 1  
    2 1 1 0 3  4 4 4 3 3 1 1  
        
    2 1 2 0 1  4 4 4 3 3 1 1 
    2 1 2 0 2  4 4 4 3 3 1 1  
    2 1 2 0 3  4 4 4 2 3 1 1 
       
    2 1 3 0 1  3 3 3 3 3 1 1 
    2 1 3 0 2  3 3 3 2 3 1 1
    2 1 3 0 3  3 3 2 2 3 1 1
    
    2 2 1 0 1  4 4 4 4 3 1 1  
    2 2 1 0 2  4 4 4 3 3 1 1  
    2 2 1 0 3  4 4 4 3 3 1 1  
        
    2 2 2 0 1  4 4 4 3 3 1 1 
    2 2 2 0 2  4 4 4 3 3 1 1  
    2 2 2 0 3  4 4 4 2 3 1 1 
       
    2 2 3 0 1  3 3 3 3 3 1 1 
    2 2 3 0 2  3 3 3 2 3 1 1
    2 2 3 0 3  3 3 2 2 3 1 1
          
    2 3 1 0 1  2 2 2 3 2 1 1
    2 3 1 0 2  2 2 2 3 2 1 1 
    2 3 1 0 3  2 2 2 2 2 1 1
       
    2 3 2 0 1  2 2 2 3 2 1 1
    2 3 2 0 2  2 2 2 3 2 1 1
    2 3 2 0 3  2 2 2 2 2 1 1
       
    2 3 3 0 1  2 2 2 2 2 1 1
    2 3 3 0 2  2 2 2 2 2 1 1
    2 3 3 0 3  2 2 2 1 2 1 1
       
    3 1 1 1 1  5 5 5 5 5 1 1
    3 1 1 1 2  5 5 5 4 5 1 1
    3 1 1 1 3  5 5 5 3 5 1 1
        
    3 1 2 1 1  5 5 5 4 5 1 1
    3 1 2 1 2  5 5 5 4 5 1 1
    3 1 2 1 3  5 5 5 3 5 1 1
        
    3 1 3 1 1  5 4 4 3 4 1 1
    3 1 3 1 2  5 4 4 2 4 1 1
    3 1 3 1 3  5 4 4 1 4 1 1
        
    3 2 1 1 1  5 5 4 4 4 1 1
    3 2 1 1 2  5 5 4 4 4 1 1
    3 2 1 1 3  5 5 4 3 4 1 1
        
    3 2 2 1 1  5 5 4 4 4 1 1
    3 2 2 1 2  5 5 4 3 4 1 1
    3 2 2 1 3  5 5 4 2 4 1 1
        
    3 2 3 1 1  4 4 4 3 4 1 1
    3 2 3 1 2  4 4 4 3 4 1 1
    3 2 3 1 3  4 4 4 3 4 1 1
        
    3 3 1 1 1  4 4 4 4 4 1 1
    3 3 1 1 2  4 4 4 3 4 1 1
    3 3 1 1 3  4 4 4 3 4 1 1
    
    3 3 2 1 1  4 4 4 4 4 1 1 
    3 3 2 1 2  4 4 4 3 4 1 1
    3 3 2 1 3  4 4 4 2 4 1 1
        
    3 3 3 1 1  3 3 3 3 3 1 1
    3 3 3 1 2  3 3 3 2 3 1 1
    3 3 3 1 3  3 3 3 2 3 1 1
    ];

Alpha=addrule(Alpha,ruleList);

%% Evaluación %%

alpha=evalfis(comp,Alpha);
end