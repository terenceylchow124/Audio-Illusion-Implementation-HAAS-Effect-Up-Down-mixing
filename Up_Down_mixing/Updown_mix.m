%Updown mixing (2:2:4)/(4:2:4)

function RES = Updown_mix( handles,Clip_info, audio_clip,up_down )
%Get number of channels of audio clip
ch=Clip_info.NumChannels;

%Check whether the audio clip can be upmix (only for 2 channels) or downmix
%(only for 4 or more channels)
if (up_down==0) && (ch<4)
    msgbox('Downmix only applies to 4 or more channels');
    RES=audio_clip;
    return;
end
%if (up_down==1) %&& (ch~=2)
    %msgbox('Upmix only applies to 2 channels');
    %RES=audio_clip;
    %return;
%end

%Get sampling rate and length of audio clip
Fs=Clip_info.SampleRate;
T=Clip_info.TotalSamples;

if up_down==0   %Downmix
    %RES=zeros(T,2); %Declare a stereo audio buffer
    
    L_F=audio_clip(1:T,1);  %Read front-left channel of audio clip
    R_F=audio_clip(1:T,2);  %Read front-right channel of audio clip
    L_B=audio_clip(1:T,3);  %Read front-left channel of audio clip
    R_B=audio_clip(1:T,4);  %Read front-right channel of audio clip

    
    %Copy the rear-left and rear-right channels to audio buffer
    RES(1:T,3)=L_F+0.25*R_F+L_B-0.5*R_B;
    RES(1:T,4)=0.25*L_F+R_F-0.5*L_B+R_B;
    RES(1:T,1)=0;
    RES(1:T,2)=0;
    msgbox('Finished downmixing');

else
    %RES=zeros(T,4); %Declare a 4-channel audio buffer
    
    L_T=audio_clip(1:T,3);  %Read rear-left channel of audio clip
    R_T=audio_clip(1:T,4);  %Read rear-right channel of audio clip

    %Copy the front-left and front-right channels to audio buffer
    RES(1:T,1)=L_T;
    RES(1:T,2)=R_T;
    RES(1:T,3)=0.64*L_T-0.36*R_T;
    RES(1:T,4)=0.64*R_T-0.36*L_T;
    msgbox('Finished upmixing');
    
end


end

