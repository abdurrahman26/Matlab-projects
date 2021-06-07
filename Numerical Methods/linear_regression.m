%x=[1 2 3 4 5 6]
%y=[2.1 3.8 5.3 7.6 10.2 11.9]
clear;
clc;
prompt = {'Enter X points :','Enter Y points:'};
data = inputdlg(prompt,'specify points in matrix form',[1 90]);
x=str2num(data{1});
y=str2num(data{2});
n=length(x);    
%linear regression
M=[n     sum(x);sum(x) sum(x.^2)];
B=[sum(y) ; sum(x.*y) ];
co=M\B; 
a0=co(1);
a1=co(2);
ymean=sum(y)/n;
St=sum((y-ymean).^2);
Sr=sum((y-a0-a1.*x).^2);
r=sqrt((St-Sr)/St); 
scatter(x,y);
grid on;
hold on;
xdash=linspace(min(x),max(x));
ydash=a0+a1*xdash;
plot(xdash,ydash)
title('Linear Regression');
msgbox(sprintf('        Linear Regresstion results       \na0 is =%f\na1 is= %f\ncorrelation is %f',a0,a1,r));




