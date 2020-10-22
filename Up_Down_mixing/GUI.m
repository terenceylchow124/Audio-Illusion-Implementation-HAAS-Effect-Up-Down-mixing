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
set(handles.Duration, 'String', strcat('Clip duration:   ', num2str(c_size)));
IMG=imread('image2.jpg');
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
global audio_clip;
global Fs;
global T;

sound(audio_clip(1:T,1:2),Fs);

% --- Executes on button press in Play_Stop.
function Play_Stop_Callback(hObject, eventdata, handles)
clear sound

%====================== END of BUTTON INTERFACE ===========================



%==========================================================================
%Radio buttons user interface to select sound effect
%==========================================================================
% --- Executes during object creation, after setting all properties.
function DM_CreateFcn(hObject, eventdata, handles)
global effect_mode
global up_down

up_down=0;
effect_mode=1;  %Default sound effect: playing original sound clip

% --- Executes on button press in DM.
function DM_Callback(hObject, eventdata, handles)
global effect_mode
global up_down

up_down=0;
effect_mode=1;

% --- Executes on button press in UM.
function UM_Callback(hObject, eventdata, handles)
global effect_mode
global up_down

up_down=1;
effect_mode=2;

% --- Reserve for future development, executes on button press in Effect_3.
function Effect_3_Callback(hObject, eventdata, handles)
global effect_mode
effect_mode=3;



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


% --- Reserved text for slider 2
function RS_Text1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Reserved text for slider 3
function RS_Text2_CreateFcn(hObject, eventdata, handles)
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
global Fs;
global T;

[Name, folder] = uigetfile('*.wav;*.mp3;*.ogg');
filename = fullfile(folder, Name);

clear sound;

[audio_clip,Fs] = audioread(filename);
Clip_info=audioinfo(filename);
ch=Clip_info.NumChannels;
dur=Clip_info.Duration;
T=Clip_info.TotalSamples;
info=strcat({['Audio Clip: ',filename],[], ['Sampling rate: ',num2str(Fs)], [],['Number of channels:' ,num2str(ch)]});
set(handles.Source, 'String', info);
set(handles.PB1,'Enable','on');


% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
global RES
global Clip_info

Fs=Clip_info.SampleRate;

[Name, folder] = uiputfile('*.wav;*.mp3;*.ogg');
filename = fullfile(folder, Name);
audiowrite(filename,RES,Fs);

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
clear test;
clear sound;
clearvars;
clear global;
close all


% --------------------------------------------------------------------
function Down_mix_Callback(hObject, eventdata, handles)
global audio_clip
global RES
global yp
global up_down
global Clip_info;

RES=Updown_mix(handles,Clip_info,audio_clip,up_down);



%====================== END of MENU ITEM ==================================



%==========================================================================
%Sliders users interface, reserve for future development 
%==========================================================================
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global SL1
SL1 = get(handles.slider1,'Value');
set(handles.slider1, 'String', strcat('Slider 1:   ', num2str(SL1)));

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
global SL2
SL2 = get(handles.slider2,'Value');
set(handles.slider2, 'String', strcat('Slider 2:   ', num2str(SL2)));


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
global SL3;
SL3=get(handles.slider3,'Value');
set(handles.slider3, 'String', strcat('Slider 3:   ', num2str(SL3)));


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
