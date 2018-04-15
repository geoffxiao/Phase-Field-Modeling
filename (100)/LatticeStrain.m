%% NSO
a_110_NSO=sqrt(5.7761026^2+5.5761705^2); a_001_NSO=8.0033835;
a_NSO=1/4*(a_110_NSO+a_001_NSO);
%% SSO
a_110_SSO=sqrt(5.758612^2+5.5279832^2); a_001_SSO=7.9627969;
a_SSO=1/4*(a_110_SSO+a_001_SSO);
%% GSO
a_110_GSO=sqrt(5.7454058^2+5.4805002^2); a_001_GSO=7.9314013;
a_GSO=1/4*(a_110_GSO+a_001_GSO);
%% TSO
a_110_TSO=sqrt(5.7299335^2+5.4638353^2); a_001_TSO=7.9164596;
a_TSO=1/4*(a_110_TSO+a_001_TSO);
%% DSO
a_110_DSO=sqrt(5.7163901^2+5.4400236^2); a_001_DSO=7.9031349;
a_DSO=1/4*(a_110_DSO+a_001_DSO);
%% BST family
aBTO=4.006; aSTO=3.905;
s11STOs=3.52*10^-12; s12STOs=-0.85*10^-12; s44STOs=7.87*10^-12; % unit: J^-1*m^3
s11BTOs=8.33*10^-12; s12BTOs=-2.68*10^-12; s44BTOs=9.24*10^-12; % unit: J^-1*m^3
tau_BT=(s11BTOs+2*s12BTOs)/(s11STOs+2*s12STOs);
delta_BT=(aBTO-aSTO)/aSTO;
%% BT
x=1;
deltaST=-x*delta_BT/((1-x)*tau_BT+(1+delta_BT)*x);
deltaBT=(1-x)*tau_BT*delta_BT/((1-x)*tau_BT+(1+delta_BT)*x);
a_BT=aBTO*x+aSTO*(1-x);
% a_BT=((1-x)*tau_BT*aSTO+x*aBTO)/((1-x)*tau_BT+x);
s_BT=[(aSTO-a_BT)/a_BT,(a_GSO-a_BT)/a_BT,(a_SSO-a_BT)/a_BT,(a_NSO-a_BT)/a_BT]'*100;
% s_BT=[(a_GSO-a_BT)/a_GSO,(a_SSO-a_BT)/a_SSO,(a_NSO-a_BT)/a_NSO]'*100;
%% BST80/20
x=0.8;
deltaST=-x*delta_BT/((1-x)*tau_BT+(1+delta_BT)*x);
deltaBT=(1-x)*tau_BT*delta_BT/((1-x)*tau_BT+(1+delta_BT)*x);
a_BST_80_20=aBTO*x+aSTO*(1-x);
% a_BST_80_20=((1-x)*tau_BT*aSTO+x*aBTO)/((1-x)*tau_BT+x);
s_BST_80_20=[(aSTO-a_BST_80_20)/a_BST_80_20,(a_GSO-a_BST_80_20)/a_BST_80_20,(a_SSO-a_BST_80_20)/a_BST_80_20,(a_NSO-a_BST_80_20)/a_BST_80_20]'*100;
% s_BST_80_20=[(a_GSO-a_BST_80_20)/a_GSO,(a_SSO-a_BST_80_20)/a_SSO,(a_NSO-a_BST_80_20)/a_NSO]'*100;
%% BST70/30
x=0.7;
deltaST=-x*delta_BT/((1-x)*tau_BT+(1+delta_BT)*x);
deltaBT=(1-x)*tau_BT*delta_BT/((1-x)*tau_BT+(1+delta_BT)*x);
a_BST_70_30=aBTO*x+aSTO*(1-x);
% a_BST_70_30=((1-x)*tau_BT*aSTO+x*aBTO)/((1-x)*tau_BT+x);
s_BST_70_30=[(aSTO-a_BST_70_30)/a_BST_70_30,(a_GSO-a_BST_70_30)/a_BST_70_30,(a_SSO-a_BST_70_30)/a_BST_70_30,(a_NSO-a_BST_70_30)/a_BST_70_30]'*100;
% s_BST_70_30=[(a_GSO-a_BST_70_30)/a_GSO,(a_SSO-a_BST_70_30)/a_SSO,(a_NSO-a_BST_70_30)/a_NSO]'*100;
%% BST60/40
x=0.6;
deltaST=-x*delta_BT/((1-x)*tau_BT+(1+delta_BT)*x);
deltaBT=(1-x)*tau_BT*delta_BT/((1-x)*tau_BT+(1+delta_BT)*x);
a_BST_60_40=aBTO*x+aSTO*(1-x);
% a_BST_60_40=((1-x)*tau_BT*aSTO+x*aBTO)/((1-x)*tau_BT+x);
s_BST_60_40=[(aSTO-a_BST_60_40)/a_BST_60_40,(a_GSO-a_BST_60_40)/a_BST_60_40,(a_SSO-a_BST_60_40)/a_BST_60_40,(a_NSO-a_BST_60_40)/a_BST_60_40]'*100;
% s_BST_60_40=[(a_GSO-a_BST_60_40)/a_GSO,(a_SSO-a_BST_60_40)/a_SSO,(a_NSO-a_BST_60_40)/a_NSO]'*100;
%% PT family
aPTO=3.97; aSTO=3.905;
s11STOs=3.52*10^-12; s12STOs=-0.85*10^-12; s44STOs=7.87*10^-12; % unit: J^-1*m^3
s11PTOs=8.0*10^-12; s12PTOs=-2.5*10^-12; s44PTOs=9*10^-12; % unit: J*m^3*C^-2
tau_PT=(s11PTOs+2*s12PTOs)/(s11STOs+2*s12STOs);
delta_PT=(aPTO-aSTO)/aSTO;
%% PT
x=1;
deltaST=-x*delta_PT/((1-x)*tau_PT+(1+delta_PT)*x);
deltaPT=(1-x)*tau_PT*delta_PT/((1-x)*tau_PT+(1+delta_PT)*x);
% a_PST_65_35=aPTO*x+aSTO*(1-x);
a_PT=((1-x)*tau_PT*aSTO+x*aPTO)/((1-x)*tau_PT+x);
s_PT=[(a_DSO-a_PT)/a_PT,(a_TSO-a_PT)/a_PT,(a_GSO-a_PT)/a_PT,(a_SSO-a_PT)/a_PT,(a_NSO-a_PT)/a_PT]'*100;
% s_PT=[(a_DSO-a_PT)/a_DSO,(a_TSO-a_PT)/a_TSO,(a_GSO-a_PT)/a_GSO,(a_SSO-a_PT)/a_SSO,(a_NSO-a_PT)/a_NSO]'*100;
%% PST65/35
x=0.65;
deltaST=-x*delta_PT/((1-x)*tau_PT+(1+delta_PT)*x);
deltaPT=(1-x)*tau_PT*delta_PT/((1-x)*tau_PT+(1+delta_PT)*x);
% a_PST_65_35=aPTO*x+aSTO*(1-x);
a_PST_65_35=((1-x)*tau_PT*aSTO+x*aPTO)/((1-x)*tau_PT+x);
s_PST_65_35=[(a_DSO-a_PST_65_35)/a_PST_65_35,(a_GSO-a_PST_65_35)/a_PST_65_35,(a_SSO-a_PST_65_35)/a_PST_65_35,(a_NSO-a_PST_65_35)/a_PST_65_35]'*100;
% s_PST_65_35=[(a_DSO-a_PST_65_35)/a_DSO,(a_GSO-a_PST_65_35)/a_GSO,(a_SSO-a_PST_65_35)/a_SSO,(a_NSO-a_PST_65_35)/a_NSO]'*100;