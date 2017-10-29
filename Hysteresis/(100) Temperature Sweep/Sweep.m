% T Sweep

Ts = [-30 : 10 : 50];

for T_ind = 1 : numel(Ts)

    Main(Ts(T_ind), sprintf('./%g/', Ts(T_ind)),1);
   
end