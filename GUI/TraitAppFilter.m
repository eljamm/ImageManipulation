% ====================================================================
%                   Manipulations on Grayscale Images
%                           (GUI Application)
% ====================================================================
%                              Fedi Jamoussi
%                            Second Year GEC 1
%                               (2021-2022)
% ====================================================================
% Tested with MATLAB version 2018b.


function varargout = TraitAppFilter(varargin)
% TraitAppFilter MATLAB code for TraitAppFilterFilter.fig
%      TraitAppFilter, by itself, creates a new TraitAppFilter or raises the existing
%      singleton*.
%
%      H = TraitAppFilter returns the handle to a new TraitAppFilter or the handle to
%      the existing singleton*.
%
%      TraitAppFilter('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TraitAppFilter.M with the given input arguments.
%
%      TraitAppFilter('Property','Value',...) creates a new TraitAppFilter or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TraitAppFilter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TraitAppFilter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TraitAppFilter

% Last Modified by GUIDE v2.5 13-Mar-2022 16:06:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TraitAppFilter_OpeningFcn, ...
                   'gui_OutputFcn',  @TraitAppFilter_OutputFcn, ...
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


% --- Executes just before TraitAppFilter is made visible.
function TraitAppFilter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TraitAppFilter (see VARARGIN)

% Choose default command line output for TraitAppFilter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TraitAppFilter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TraitAppFilter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnOriginal.
function btnOriginal_Callback(hObject, eventdata, handles)
Image = imread('LENA.BMP');
axes(handles.image_original);
imshow(Image); title('Original Image');


% --- Executes on button press in btnNoise.
function btnNoise_Callback(hObject, eventdata, handles)
% Check the box if you want to compare the noisy image and the filtered
% image. This is done by plotting the noisy image in the axis of the
% original one.

choice = get(handles.popNoise, 'Value');
checkChoice = get(handles.checkNoise, 'Value');

Image = imread('LENA.BMP');

if checkChoice==1
    axes(handles.image_original);
else
    axes(handles.image_modified);
end

if choice==1
    Gaussian = imnoise(Image,'gaussian');
    imshow(Gaussian); title('Gaussian');
elseif choice==2
    SaltPepper = imnoise(Image,'salt & pepper',0.2);
    imshow(SaltPepper); title('Salt and Pepper');
else
    Speckle = imnoise(Image,'speckle',0.03);
    imshow(Speckle); title('Speckle');
end


% --- Executes on button press in btnFilter.
function btnFilter_Callback(hObject, eventdata, handles)
choice = get(handles.popFilter, 'Value');
noiseChoice = get(handles.popNoise, 'String');

Image = imread('LENA.BMP');

% Load the selected noise profile
if strcmp(noiseChoice,'Gaussian')
    Noise = imnoise(Image,'gaussian');
elseif strcmp(noiseChoice,'Salt & Pepper')
    Noise = imnoise(Image,'salt & pepper',0.2);
else
    Noise = imnoise(Image,'speckle',0.03);
end

Filter = fspecial('average', 9);

axes(handles.image_modified);

% Apply the filter to the noisy image
if choice==1
    % Average Filter
    Average = imfilter(Noise,Filter);
    peaksnr = psnr(Average, Image);
    imshow(Average); title(sprintf('Average\n(PSNR: %.3f)',peaksnr));
else
    % Median Filter
    Media = medfilt2(Noise);
    peaksnr = psnr(Media, Image);
    imshow(Media); title(sprintf('Median\n(PSNR: %.3f)',peaksnr));
end

% --- Executes on selection change in popFilter.
function popFilter_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popFilter_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnBack.
function btnBack_Callback(hObject, eventdata, handles)
TraitApp;
closereq;


% --- Executes during object creation, after setting all properties.
function image_original_CreateFcn(hObject, eventdata, handles)


% --- Executes on selection change in popNoise.
function popNoise_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popNoise_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function panel_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in checkNoise.
function checkNoise_Callback(hObject, eventdata, handles)


% --- Executes on button press in btnQuit.
function btnQuit_Callback(hObject, eventdata, handles)
closereq;
