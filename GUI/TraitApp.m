% ====================================================================
%                   Manipulations on Grayscale Images
%                           (GUI Application)
% ====================================================================
%                              Fedi Jamoussi
%                            Second Year GEC 1
%                               (2021-2022)
% ====================================================================
% Tested with MATLAB version 2018b.


function varargout = TraitApp(varargin)
% TRAITAPP MATLAB code for TraitApp.fig
%      TRAITAPP, by itself, creates a new TRAITAPP or raises the existing
%      singleton*.
%
%      H = TRAITAPP returns the handle to a new TRAITAPP or the handle to
%      the existing singleton*.
%
%      TRAITAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAITAPP.M with the given input arguments.
%
%      TRAITAPP('Property','Value',...) creates a new TRAITAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TraitApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TraitApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TraitApp

% Last Modified by GUIDE v2.5 13-Mar-2022 16:04:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TraitApp_OpeningFcn, ...
                   'gui_OutputFcn',  @TraitApp_OutputFcn, ...
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


% --- Executes just before TraitApp is made visible.
function TraitApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TraitApp (see VARARGIN)

% Choose default command line output for TraitApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TraitApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TraitApp_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in btnRotation.
function btnRotation_Callback(hObject, eventdata, handles)
rotation = str2num(get(handles.edtRotation, 'String'));

Image = imread('LENA.BMP');
axes(handles.image_modified);

if isempty(rotation)
    % Set a default value to guide the user
    set(handles.edtRotation, 'String', '30');
    % Display Warning if the input is not numerical
    warndlg('Input must be Numerical');
else
    RotImage = imrotate(Image,rotation);

    imshow(RotImage); title(sprintf('Rotation of %d°',rotation));
end


% --- Executes on button press in btnInversion.
function btnInversion_Callback(hObject, eventdata, handles)
Image = imread('LENA.BMP');
axes(handles.image_modified);

InvImage = imcomplement(Image);

imshow(InvImage);
title('Color Inversion');


% --- Executes on button press in btnHistogramme.
function btnHistogramme_Callback(hObject, eventdata, handles)
Image = imread('LENA.BMP');
axes(handles.image_modified);

imhist(Image);
xlabel('Grayscale Value'), ylabel('Repetition Number'), title('Histogram');


% --- Executes on button press in btnProfile.
function btnProfile_Callback(hObject, eventdata, handles)
choice = get(handles.popProfil, 'Value');
grayscale = str2num(get(handles.edtProfil, 'String'));

Image = imread('LENA.BMP');
[rows, columns] = size(Image);
axes(handles.image_modified);

if isempty(grayscale)
    % Set a default value to guide the user
    set(handles.edtProfil, 'String', '100');
    % Display Warning if the input is not numerical
    warndlg('Input must be Numerical');
else
    if choice==1
        % Profile of Line
        plot(Image(grayscale,:),'b');
        xlabel('Column Number'), ylabel('Grayscale Value');
        title(sprintf('Profile of Line %d',grayscale));
    elseif choice==2
        % Profile of Column
        plot(Image(:,grayscale),'r');
        xlabel('Line Number'), ylabel('Grayscale Value');
        title(sprintf('Profile of Column %d',grayscale));
    else
        % Profile of Line and Column
        x1 = (1:rows); x2 = (1:columns);
        plot(x1, Image(grayscale,:),'b',x2, Image(:,grayscale),'r');
        xlabel('Line/Column Number'), ylabel('Grayscale Value');
        title(sprintf('Profile of Line and Column %d',grayscale));
        legend('Line','Column','Fontsize',6); legend('boxoff');
    end
end


function edit1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popProfil.
function popProfil_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popProfil_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnNext.
function btnNext_Callback(hObject, eventdata, handles)
TraitAppFilter;
closereq;


function edtProfil_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edtProfil_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edtRotation_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edtRotation_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function image_original_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in btnQuit.
function btnQuit_Callback(hObject, eventdata, handles)
closereq;
