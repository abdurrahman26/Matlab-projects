%simulating a communcation system  sound as input --> channel ---> noise added --> reciever --> filtering
[audio, fs] = audioread('test.wav');
audio = audio'; % transpose to make it a row vector for easier analysis

% if the input file is stereo, convert it to mono by taking the average of both channels
audiosize = size(audio);
if audiosize(1) == 2
    audio = (audio(1, :) + audio(2, :)) / 2;
end
Ns=length(audio);
t_end = Ns / fs;
t = linspace(0, t_end, t_end * fs);

channel = input('Choose the channel (1->4): ');
sigma = input('Enter the noise sigma: ');
h = []; 

%=============channel=============%
switch channel
    case 1
        h = 1;
        
    case 2
        h = exp(-2*pi*5000*t);

    case 3
        h = exp(-2*pi*1000*t);

    case 4
        h = zeros(1, 1*fs);
        h(1) = 2;
        h(end) = 0.5;

    otherwise
        error('Invalid input.')
end

output = conv(audio, h);
output = output(1:t_end*fs); % cut the output to be the length of the input bec it's all zeros beyond that

output_noise = output + sigma * randn(1, length(output));

%==========Filttering==========%
sample_per_hertz=length(output_noise)/fs;
zeroed=sample_per_hertz * (fs/2 - 3400);
Filter=fftshift(fft(output_noise));
length(Filter)
Filter([1:zeroed   ceil(length(Filter)-zeroed+1):length(Filter)])=0;

audiowrite('out.wav', output, fs);
audiowrite('out_noise.wav', output_noise, fs);

% ========== plot & play ========== %

plotwave(t, audio, fs, 'Input Audio');
plotwave(t, output, fs, 'Output Audio');
plotwave(t, output_noise, fs, 'Output Audio With Noise');
plotwave(output_noise, Filter  , fs,  'Output Audio before/after filter');
sound(real(ifft(ifftshift(Filter))),fs);
figure;
plot(t,real(ifft(ifftshift(Filter)))); %plotted here because we do not send t as a paramter in filterd noise
title('filtered in time domain');

waitfor(gcf);
