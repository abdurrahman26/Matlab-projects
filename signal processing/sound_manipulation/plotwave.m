function [] = plotwave(t, audio, fs, maintitle)
   
    fvec = linspace(-fs/2, fs/2, length(audio)); 
    audio_f = fftshift(fft(audio));
    %special case 
        if strcmp(maintitle,'Output Audio before/after filter')
            figure;
            subplot(2, 1, 1);
             plot(fvec, fftshift(fft(t)));
             subplot(2, 1, 2);
             plot(fvec, audio);
             xlabel('Frequency (Hz)');
             axes('Visible', 'off');
             title(maintitle, 'Visible', 'on', 'fontsize', 16);
             return
     
        end
     
     sound(audio,fs);
     pause(11);  %depend on input length
     figure;
     subplot(2, 1, 1);
     plot(t, audio);
     xlabel('Time (seconds)');

     subplot(2, 1, 2);
     plot(fvec, abs(audio_f));
     xlabel('Frequency (Hz)');

     % add a main title to the whole subplot
     axes('Visible', 'off');
     title(maintitle, 'Visible', 'on', 'fontsize', 16);
end
