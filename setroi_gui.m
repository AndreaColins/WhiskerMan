function varargout = setroi_gui(varargin)
% SETROI_GUI MATLAB code for setroi_gui.fig
%      SETROI_GUI, by itself, creates a new SETROI_GUI or raises the existing
%      singleton*.
%
%      H = SETROI_GUI returns the handle to a new SETROI_GUI or the handle to
%      the existing singleton*.
%
%      SETROI_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETROI_GUI.M with the given input arguments.
%
%      SETROI_GUI('Property','Value',...) creates a new SETROI_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setroi_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setroi_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setroi_gui

% Last Modified by GUIDE v2.5 07-Jul-2016 10:36:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setroi_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @setroi_gui_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before setroi_gui is made visible.
function setroi_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setroi_gui (see VARARGIN)

% Choose default command line output for setroi_gui
handles.output = hObject;

% Extract input pmtrs (video frame and current ROIs)
if nargin == 5
    handles.frame = varargin{1};
    handles.roi = varargin{2};
else
    error(sprintf('Incorrect number of inputs (%d)', nargin))
end

handles.linelen = 20;

axis(handles.videoframe)
image(handles.frame)
hold on

x = handles.roi(1:2);
y = handles.roi(3:4);
plot([x(1) x(1) x(2) x(2) x(1)],[y(1) y(2) y(2) y(1) y(1)],'b--')
clear x y

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setroi_gui wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = setroi_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;

varargout{1} = handles.roi;
delete(handles.figure1);


% --- Executes on button press in pushbutton_setroi.
function pushbutton_setroi_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_setroi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla
image(handles.frame)
hold on

topleft = round(ginput(1));
handles.roi(1) = topleft(1);
handles.roi(3) = topleft(2);
plot(handles.roi(1),handles.roi(3),'b+')

bottomright = round(ginput(1));
handles.roi(2) = bottomright(1);
handles.roi(4) = bottomright(2);
plot(handles.roi(2),handles.roi(4),'g+')

x = handles.roi(1:2);
y = handles.roi(3:4);
plot([x(1) x(1) x(2) x(2) x(1)],[y(1) y(2) y(2) y(1) y(1)],'b--')
clear x y

guidata(hObject, handles);


% --- Executes on button press in pushbutton_close.
function pushbutton_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume(handles.figure1)
