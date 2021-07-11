clear all;
prompt = {'Enter X points :','Enter Y points:'};
data = inputdlg(prompt,'specify points in matrix form',[1 90]);
x=str2num(data{1});
y_original=str2num(data{2});

%linearizing data
y_linearized=log(y_original);

n=length(x);    
%linear regression
M=[n     sum(x);sum(x) sum(x.^2)];
B=[sum(y_linearized) ; sum(x.*y_linearized) ];
co=M\B; 
a0=co(1);
a1=co(2);


%reverting to original model
a=exp(a0);
b = a1;

ymean=sum(y_linearized)/n;
St=sum((y_linearized-ymean).^2);
Sr=sum((y_linearized-a0-a1.*x).^2);
r=sqrt((St-Sr)/St); 
scatter(x,y_original);
grid on;
hold on;

xdash=linspace(min(x),max(x));
ydash=a*exp(b*xdash);
plot(xdash,ydash)
title('Exponential Model');
msgbox(sprintf('        Exponential Model results\n        -----------------------------------------\na =%f\nb = %f\ncorrelation = %f',a,b,r));





