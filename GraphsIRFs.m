clear all; clc; close all;
%--------------------------------------------------------------------------------------------------------
% Model with a Fiscal Deficit Rule
%--------------------------------------------------------------------------------------------------------
dynare BaseMod.dyn
WW1=0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(1),1)+oo_.dr.ys(1,1);
Vlambda=oo_.dr.ys(1,1);
Vsigma=0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(1),1);

WW1NR=0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(2),1)+oo_.dr.ys(2,1);
VlambdaNR=oo_.dr.ys(2,1);
VsigmaNR=0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(2),1);

IRF_pCo1=[gdp_epspCo, yX_epspCo, yN_epspCo, sC_epspCo, sinv_epspCo, ce_epspCo, sIG_epspCo, ...
    invG_epspCo, sPB_epspCo, sDG_epspCo, rer_epspCo, RP_epspCo];

IRF_rW1=[gdp_epsrW, yX_epsrW, yN_epsrW, sC_epsrW, sinv_epsrW, ce_epsrW, sIG_epsrW, invG_epsrW, ...
sPB_epsrW, sDG_epsrW, rer_epsrW, RP_epsrW];
%--------------------------------------------------------------------------------------------------------
% Model with a Structural Fiscal Rule
%--------------------------------------------------------------------------------------------------------
dynare SFDRMod.dyn
WW2=0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(1),1)+oo_.dr.ys(1,1);
lambdasigma2=(0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(1),1)-Vsigma)/Vlambda;

WW2NR=0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(2),1)+oo_.dr.ys(2,1);
lambdasigma2NR=(0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(2),1)-VsigmaNR)/VlambdaNR;

IRF_pCo2=[gdp_epspCo, yX_epspCo, yN_epspCo, sC_epspCo, sinv_epspCo, ce_epspCo, sIG_epspCo, ...
    invG_epspCo, sPB_epspCo, sDG_epspCo, rer_epspCo, RP_epspCo];

IRF_rW2=[gdp_epsrW, yX_epsrW, yN_epsrW, sC_epsrW, sinv_epsrW, ce_epsrW, sIG_epsrW, invG_epsrW, ...
sPB_epsrW, sDG_epsrW, rer_epsrW, RP_epsrW];
%--------------------------------------------------------------------------------------------------------
% Model with a Current Deficit Rule
%--------------------------------------------------------------------------------------------------------
dynare CDRmod.dyn
WW3=0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(1),1)+oo_.dr.ys(1,1);
lambdasigma3=(0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(1),1)-Vsigma)/Vlambda;

WW3NR=0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(2),1)+oo_.dr.ys(2,1);
lambdasigma3NR=(0.5*oo_.dr.ghs2(oo_.dr.inv_order_var(2),1)-VsigmaNR)/VlambdaNR;

IRF_pCo3=[gdp_epspCo, yX_epspCo, yN_epspCo, sC_epspCo, sinv_epspCo, ce_epspCo, sIG_epspCo, ...
    invG_epspCo, sPB_epspCo, sDG_epspCo, rer_epspCo, RP_epspCo];

IRF_rW3=[gdp_epsrW, yX_epsrW, yN_epsrW, sC_epsrW, sinv_epsrW, ce_epsrW, sIG_epsrW, invG_epsrW, ...
    sPB_epsrW, sDG_epsrW, rer_epsrW, RP_epsrW];

save WWU WW1 WW2 WW3 lambdasigma2 lambdasigma3
save WWUNR WW1NR WW2NR WW3NR lambdasigma2NR lambdasigma3NR
%--------------------------------------------------------------------------------------------------------
% Figures
%--------------------------------------------------------------------------------------------------------
Horz=10;
[F,C]=size(IRF_rW1);
Names={'GDP','Exportables','Non-Tradables','Consumption (% of GDP)','Private Investment (% of GDP)',...
    'Current Expenditures (% of GDP)','Public Investment (% of GDP)','Public Investment', ...
    'Primary Balance (% of GDP)','Public Debt (% of GDP)','Real Exchange Rate','Lending Spread'};
%--------------------------------------------------------------------------------------------------------
% Commodity price shock
%--------------------------------------------------------------------------------------------------------
figure(1)
for ii=1:C
subplot(4,3,ii)
plot(IRF_pCo1([1:Horz],ii),'-o','color',[0, 0.4470, 0.7410],'LineWidth',2)
hold on;
grid on;
xlim([1 Horz]);
xlabel('Periods');
plot(IRF_pCo2([1:Horz],ii),'-+','color',[0.8500, 0.3250, 0.0980],'LineWidth',2)
plot(IRF_pCo3([1:Horz],ii),'-d','color',[0, 0.5, 0],'LineWidth',2)
plot(zeros(Horz,1),'color','k','LineWidth',1.5)
title(Names(ii),'FontName', 'Times', 'FontSize', 16);
if ii==C
    legend('Fiscal deficit rule','Structural deficit rule','Current deficit rule','Location','Best', 'FontSize', 16)
end
end
%--------------------------------------------------------------------------------------------------------
% Foreign interest rate shock
%--------------------------------------------------------------------------------------------------------
figure(2)
for ii=1:C
subplot(4,3,ii)
plot(IRF_rW1([1:Horz],ii),'-o','color',[0, 0.4470, 0.7410],'LineWidth',2)
hold on;
grid on;
xlim([1 Horz]);
xlabel('Periods');
plot(IRF_rW2([1:Horz],ii),'-+','color',[0.8500, 0.3250, 0.0980],'LineWidth',2)
plot(IRF_rW3([1:Horz],ii),'-d','color',[0, 0.5, 0],'LineWidth',2)
plot(zeros(Horz,1),'color','k','LineWidth',1.5)
title(Names(ii),'FontName', 'Times', 'FontSize', 16);
if ii==C
    legend('Fiscal deficit rule','Structural deficit rule','Current deficit rule','Location','Best', 'FontSize', 16)
end
end
%--------------------------------------------------------------------------------------------------------
