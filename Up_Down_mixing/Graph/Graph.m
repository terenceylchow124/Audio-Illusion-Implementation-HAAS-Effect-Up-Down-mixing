
[Name, folder] = uigetfile('*.wav;*.mp3;*.ogg');
filename = fullfile(folder, Name);
%filename =   'C:\Users\eeuser\Documents\MATLAB\UP&Down\sita-sings-the-blues-clip';
[audio_clip,Fs]= audioread(filename);
Clip_info=audioinfo(filename);
ch=Clip_info.NumChannels;
dur=Clip_info.Duration;
T=Clip_info.TotalSamples;
plot(audio_clip(1:T,4))
