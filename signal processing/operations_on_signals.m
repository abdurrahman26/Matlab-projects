freq=input('Enter sampling frequency: ');
Start=input('Enter Start of Time scale: ');
End=  input('Enter end of Time scale: ');
t=linspace(Start,End,(End-Start)*freq);
numberBreaks = input('Enter number of break points: ');
arrOftimes=zeros(1,numberBreaks+1);
arrOftimes(1)=Start; % goal to have array contain all time range
for i=1:numberBreaks 
   fprintf('Enter time of the break point number %d :',i)
   arrOftimes(i+1)=input('\');
end 
arrOftimes(length(arrOftimes)+1)=End;
signals = {'DC signal' 'Ramp signal' 'General order polynomial' 'Exponential signal' 'Sinusoidal signal'};
chosen =zeros(1:numberBreaks+1) ;

Total_Signal =[]; %to be plotted later
for j = 1:numberBreaks+1  %number of signals = numberBreaks+1
    fprintf('From %d to %d the signal is :',arrOftimes(j),arrOftimes(j+1)) 
    N=(arrOftimes(j+1)-arrOftimes(j))*freq;
    tnew=linspace(arrOftimes(j),arrOftimes(j+1),N);
     sprintf('%s\n%s\n%s\n%s\n%s\n%s' ,'Please choose a letter from the following :' ,'a. DC signal' ,...
    'b. Ramp signal','c. General order polynomial',...
    'd. Exponential signal','e. Sinusoidal signal')
     chosen(j)=input('\','S');
     % options for each signal 
     if chosen(j)   == 'a'
         sprintf('%s %s' ,'you have choosed',signals{1})
         amp_dc=input('Enter amplitude: ');
         y=ones(1,N)*amp_dc;
      

     elseif chosen(j) == 'b'
         sprintf('%s %s' ,'you have choosed',signals{2})
         slope=input('Enter slope: ');
         intercept_ramp=input('Enter intercept: ');
        y=slope*tnew+ intercept_ramp;
        
     elseif chosen(j)  == 'c'
         sprintf('%s %s' ,'you have choosed',signals{3})
         coefficents=input('Enter Coefficients in form [, , , ,] : ');
            y=polyval(coefficents,tnew);
          
         
         
     elseif chosen(j)== 'd'
         sprintf('%s %s' ,'you have choosed',signals{4})
         amp_exp=input('Enter amplitude: ');
         a=input('Enter exponent: ');
         y=amp_exp*exp(a*tnew);
        
     elseif chosen(j)== 'e'
         sprintf('%s %s' ,'you have choosed',signals{5})
         amp_sin = input('Enter amplitude: ');
         freq_sin= input('Enter frequency: ');
         phase   = input('Enter phase: ');   
        y=amp_sin*sin(2*pi *freq_sin* tnew + phase*pi/180);
      
     end
     
% concatination      

Total_Signal= [Total_Signal y];

end
figure
plot(t,Total_Signal,'r')
grid on
title('Total Signal ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while 1 
sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n','perform any of these operations ? ',...
    'a. Amplitude Scaling','b. Time reversal','c. Time shift',...
       'd. Expanding the signal','e. Compressing the signal','f. None','choose a letter please.')
operation=input('\','S');
switch operation 
    
    case 'a' 
    scaled_amp =input('Enter amplitude: ');
    Total_Signal =scaled_amp * Total_Signal;
    
    case 'b'
    t=-t;
    
    case 'c'
    shift=input('Enter shift value +ve for left -ve for right: ');
    t=t-shift;
   
    case 'd'
    expand=input('Enter expanding Value: ');
    Total_Signal=upsample(Total_Signal,expand);
    t=linspace(Start*expand,End*expand,(End-Start)*freq*expand);

    case 'e'
    compress=input('Enter compressing Value: ');
    Total_Signal=downsample(Total_Signal,compress);
    t=linspace(Start/compress,End/compress,(End-Start)*freq/compress);

    case 'f'
     disp('goodbye :)')
     break
     
    otherwise 
        disp('invalid character Try again :)')
end %switch
        

figure
plot(t,Total_Signal,'b')
grid on
title('Total Signal after operations')

end 







