%Source codes for Miniproject 1 and 2
%Written by Dr. Peter Tsang
%Term of usage: For students of EE4209 only


%==========================================================================
%=========================== GUI Initialization ===========================
%==========================================================================
function varargout = GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


c_size=get(handles.slider1,'Value');
set(handles.Duration, 'String', strcat(num2str(c_size),'ms'));
IMG=imread('image.jpg');
axes(handles.axes1);
imshow(mat2gray(abs(IMG)),'InitialMagnification','fit');

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%=================== End of GUI initialization code =======================



% --------------------------------------------------------------------
%==========================================================================
%Buttons to play and stop audio clip
%==========================================================================
% --- Executes on button press in PB1.
function PB1_Callback(hObject, eventdata, handles)
global RES;
global Fs;
global T;
%global audio_clip;

%delay=30e-3;
%T_add=delay*Fs;

%buffer_mono=zeros(T_add,2);
%temp=zeros(T,1);

%OO_L=[audio_clip(1:T,1), temp];
%OO_R=[temp, audio_clip(1:T,2)];
%sound(OO_L, Fs);
%sound(OO_R, Fs);
%ori_L=audio_clip(1:T,1);
%ori_R=audio_clip(1:T,2);
%sound(ori_L, Fs);

%new_mono_L=[OO_L;buffer_mono];
%new_mono_R=[buffer_mono;OO_R];
%new_2sound=[new_mono_L(:,1),new_mono_R(:,2)];
%sound(new_mono_L, Fs);
%sound(new_mono_R, Fs);
%sound(new_2sound, Fs);


%sound(audio_clip(:,1),Fs);
sound(RES(1:T,1:2),Fs);

% --- Executes on button press in Play_Stop.
function Play_Stop_Callback(hObject, eventdata, handles)
clear sound

%====================== END of BUTTON INTERFACE ===========================





%==========================================================================
%======================= TEXT BOXES CONFIGURATION =========================
%==========================================================================

% --- Audio source textbox
function Source_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Clip Length textbox
function Duration_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%==================== END of TEXTBOX CONFIGURATION ========================







%==========================================================================
%%============================ MENU ITEM ==================================
%==========================================================================
function File_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function F_Open_Callback(hObject, eventdata, handles)
global audio_clip
global yp
global Clip_info;
global audio_clip;
global RES;
global Fs;
global T;

[Name, folder] = uigetfile('*.wav;*.mp3;*.ogg');
filename = fullfile(folder, Name);

clear sound;

[audio_clip,Fs] = audioread(filename);
Clip_info=audioinfo(filename);
ch=Clip_info.NumChannels;

T=Clip_info.TotalSamples;
RES=audio_clip; %RES is the audio signal after adding the HAAS effect. Intially it is the same
                %as the source audio clip as the delay is zero

info=strcat({['Audio Clip: ',filename],[], ['Sampling rate: ',num2str(Fs)], [],['Number of channels:' ,num2str(ch)]});
set(handles.Source, 'String', info);
set(handles.PB1,'Enable','on');
set(handles.slider1,'Enable','on');

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
global RES
global Clip_info

Fs=Clip_info.SampleRate;

[Name, folder] = uiputfile('*.wav');
filename = fullfile(folder, Name);
audiowrite(filename,RES,Fs);

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
clear test;
clear sound;
clearvars;
clear global;
close all


%==========================================================================
%Sliders users interface, reserve for future development 
%==========================================================================
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global SL1
global audio_clip
global RES
global Clip_info
SL1 = get(handles.slider1,'Value')*2000;    %scale delay time to range [0,2000]ms
set(handles.Duration, 'String', strcat(num2str(SL1),'ms'));
RES=HAAS(Clip_info,audio_clip,SL1);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
