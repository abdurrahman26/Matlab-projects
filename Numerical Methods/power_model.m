clear all;
prompt = {'Enter X points :','Enter Y points:'};
data = inputdlg(prompt,'specify points in matrix form',[1 90]);
x_original=str2num(data{1});
y_original=str2num(data{2});

% 
% x_original=[2.5 3.5  5  6 7.5 10 12.5 15 17.5 20];
% y_original=[5 3.4 2 1.6 1.2 0.8 0.6 0.4 0.3 0.3];

%linearizing data
y_linearized=log10(y_original);
x_linearized=log10(x_original);

n=length(x_linearized);
%linear regression
M=[n     sum(x_linearized);sum(x_linearized) sum(x_linearized.^2)];
B=[sum(y_linearized) ; sum(x_linearized.*y_linearized) ];
co=M\B; 
a0=co(1);
a1=co(2);

%reverting to original model
a=10^(a0);
b = a1;

ymean=sum(y_linearized)/n;
St=sum((y_linearized-ymean).^2);
Sr=sum((y_linearized-a0-a1.*x_linearized).^2);
r=sqrt((St-Sr)/St); 
scatter(x_original,y_original);
grid on;
hold on;

xdash=linspace(min(x_original),max(x_original));
ydash=a*xdash.^(b);
plot(xdash,ydash)
title('Power Model');
msgbox(sprintf('        Power Model\n        --------------------\na =%f\nb = %f\ncorrelation = %f',a,b,r));
