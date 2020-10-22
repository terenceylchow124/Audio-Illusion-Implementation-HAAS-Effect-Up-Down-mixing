%Only extract the left channel, and add delay to generate the right channel

function RES = HAAS( Clip_info, audio_clip,delay_time )

%Get sampling rate and length of audio clip
Fs=Clip_info.SampleRate;
T=Clip_info.TotalSamples;

delay_samples=floor(Fs*delay_time/1000);
%msgbox(strcat('delay samples = ',num2str(delay_samples)));

f = waitbar(0,'Please wait...');
 
%This part needs to be modified for the HAAS effect
%RES=audio_clip;  %Copy audio clip to result 

%Zero matrix for delay the sound, i.e N-by-1 matrix
buffer_mono=zeros(delay_samples,1);

% For the left channel, adding the zero matrix after the sound, which is
% the faster channel 
% For the right channel, adding the zero matrix before the sound, which is
% the laster channel 

new_mono_L=[audio_clip(1:T,1);buffer_mono];
new_mono_R=[buffer_mono;audio_clip(1:T,1)];

%After that, combine left and right channel and save it into the resulting
%matrix called RES
RES = [new_mono_L(:,1),new_mono_R(:,1)];

waitbar(1,f,'Finished');
%pause(1)
close(f)

end

