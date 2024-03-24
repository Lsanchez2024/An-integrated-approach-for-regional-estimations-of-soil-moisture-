function M=Evaluacion(A)
%Orden LLuvia Temperatura Radiación solar, Viento, ET
R_M_A=[0,5,0,0,0;
       2,4,1,0,1;
       2,4,1,0,2;
       2,4,1,0,3;
       2,4,2,0,1;
       2,4,2,0,2;
       2,4,2,0,3;
       3,4,1,0,1;
       3,4,1,0,2;
       3,4,1,0,3;
       3,4,2,0,1;
       3,4,2,0,2;
       3,4,2,0,3;
       4,4,1,0,1;
       4,4,1,0,2;
       4,4,1,0,3;
       5,4,1,0,1;
       5,4,1,0,2;
       5,4,1,0,3;];
   
R_A=[2,4,1,0,4;
    2,4,2,0,1;
    2,4,2,0,2;
    2,4,2,0,3;
    2,4,3,0,1;
    2,4,3,0,2;
    2,4,3,0,3;
    3,4,1,0,4;
    3,4,2,0,1;
    3,4,2,0,2;
    3,4,2,0,3;
    3,4,3,0,1;
    3,4,3,0,2;
    3,4,3,0,3;
    4,4,1,0,4;
    4,4,2,0,1;
    4,4,2,0,2;
    4,4,2,0,3;
    4,4,3,0,1;
    4,4,3,0,2;
    4,4,3,0,3;
    5,4,1,0,4;
    5,4,2,0,1;
    5,4,2,0,2;
    5,4,2,0,3;
    5,4,3,0,1;
    5,4,3,0,2;
    5,4,3,0,3;
    2,3,1,1,1;
    2,3,1,1,2;
    2,3,1,1,3;
    2,3,2,1,1;
    2,3,2,1,2;
    2,3,2,1,3;
    3,3,1,1,1;
    3,3,1,1,2;
    3,3,1,1,3;
    3,3,2,1,1;
    3,3,2,1,2;
    3,3,2,1,3;
    ];

R_M=[2,3,3,1,1;
    2,3,3,1,2;
    2,3,3,1,3;
    2,3,3,2,1;
    2,3,3,2,2;
    2,3,3,2,3;
    3,3,3,1,1;
    3,3,3,1,2;
    3,3,3,1,3;
    3,3,3,2,1;
    3,3,3,2,2;
    3,3,3,2,3;
    4,3,1,1,1;
    4,3,1,1,2;
    4,3,1,1,3;
    4,3,1,2,1;
    4,3,1,2,2;
    4,3,1,2,3;
    4,3,2,1,1;
    4,3,2,1,2;
    4,3,2,1,3;
    4,3,2,2,1;
    4,3,2,2,2;
    4,3,2,2,3;
    4,3,3,1,2;
    4,3,3,1,3;
    4,3,3,2,2;
    4,3,3,2,3;
    5,3,1,1,1;
    5,3,1,1,2;
    5,3,1,1,3;
    5,3,1,2,1;
    5,3,1,2,2;
    5,3,1,2,3;
    5,3,2,1,1;
    5,3,2,1,2;
    5,3,2,1,3;
    5,3,2,2,1;
    5,3,2,2,2;
    5,3,2,2,3;
    5,3,3,1,1;
    5,3,3,1,2;
    5,3,3,1,3;
    5,3,3,2,1;
    5,3,3,2,2;
    5,3,3,2,3;
    2,1,1,2,1;
    2,1,1,2,2;
    2,1,1,2,3;
    2,1,2,2,1;
    2,1,2,2,2;
    2,1,2,2,3;
    3,1,1,2,1;
    3,1,1,2,2;
    3,1,1,2,3;
    3,1,2,2,1;
    3,1,2,2,2;
    3,1,2,2,3;
    2,1,1,0,1;
    2,1,1,0,2;
    2,3,1,2,1;
    2,3,1,2,2;
    2,3,1,2,3;
    2,3,2,2,1;
    2,3,2,2,2;
    2,3,2,2,3;
    3,3,1,2,1;
    3,3,1,2,2;
    3,3,1,2,3;
    3,3,2,2,1;
    3,3,2,2,2;
    3,3,2,2,3];


R_B=[4,3,2,1,4;
    4,3,2,2,4;
    5,3,1,1,4;
    5,3,1,2,4;
    5,3,2,1,4;
    5,3,2,2,4;
    5,3,3,1,4;
    5,3,3,2,4;
    2,2,3,2,2;
    2,2,3,2,3;
    2,2,3,2,4;
    2,2,3,3,2;
    2,2,3,3,3;
    2,2,3,3,4;
    2,2,4,2,2;
    2,2,4,2,3;
    2,2,4,2,4;
    2,2,4,3,2;
    2,2,4,3,3;
    2,2,4,3,4;
    3,2,3,2,2;
    3,2,3,2,3;
    3,2,3,2,4;
    3,2,3,3,2;
    3,2,3,3,3;
    3,2,3,3,4;
    3,2,4,2,2;
    3,2,4,2,3;
    3,2,4,2,4;
    3,2,4,3,2;
    3,2,4,3,3;
    3,2,4,3,4;
    4,2,2,2,2;
    4,2,2,2,3;
    4,2,2,2,4;
    4,2,2,3,2;
    4,2,2,3,3;
    4,2,2,3,4;
    4,2,3,2,2;
    4,2,3,2,3;
    4,2,3,2,4;
    4,2,3,3,2;
    4,2,3,3,3;
    4,2,3,3,4;
    4,2,4,2,2;
    4,2,4,2,3;
    4,2,4,2,4;
    4,2,4,3,2;
    4,2,4,3,3;
    4,2,4,3,4;
    5,2,2,2,2;
    5,2,2,2,3;
    5,2,2,3,2;
    5,2,2,3,3;
    5,2,3,2,2;
    5,2,3,2,3;
    5,2,3,3,2;
    5,2,3,3,3;
    5,2,4,2,2;
    5,2,4,2,3;
    5,2,4,3,2;
    5,2,4,3,3;
    2,1,3,0,2;
    2,1,3,0,3;
    2,1,3,0,2;
    2,1,3,0,3;
    3,1,3,0,2;
    3,1,3,0,3;
    3,1,3,0,2;
    3,1,3,0,3;
    ];

R_M_B=[2,2,4,3,4;
    3,2,4,3,4;
    4,2,4,3,4;
    5,2,2,2,4;
    5,2,2,3,4;
    5,2,3,2,4;
    5,2,3,3,4;
    5,2,4,2,4;
    5,2,4,3,4;
    5,2,4,3,5;
    2,1,3,2,4;
    2,1,3,3,4;
    2,1,4,3,2;
    2,1,4,3,3;
    2,1,4,3,4;
    2,1,4,3,5;
    2,1,4,4,2;
    2,1,4,4,3;
    2,1,4,4,4;
    2,1,4,4,5;
    3,1,3,2,4;
    3,1,3,2,5;
    3,1,3,3,4;
    3,1,3,3,4;
    3,1,4,3,2;
    3,1,4,3,3;
    3,1,4,3,4;
    3,1,4,3,5;
    3,1,4,4,2;
    3,1,4,4,3;
    3,1,4,4,4;
    3,1,4,4,5;
    4,1,3,0,4;
    4,1,3,0,5;
    4,1,4,0,4;
    4,1,4,0,5;
    5,1,0,0,0;
    0,1,5,0,0;
    ];
switch A
    case 1
        M=R_M_B;
    case 2
        M=R_B;
    case 3
        M=R_M;
    case 4
        M=R_A;
    case 5
        M=R_M_A;
end
end                        