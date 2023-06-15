function varargout = Wave_Propagation_Ver2(varargin)
% WAVE_PROPAGATION_VER2 MATLAB code for Wave_Propagation_Ver2.fig
%      WAVE_PROPAGATION_VER2, by itself, creates a new WAVE_PROPAGATION_VER2 or raises the existing
%      singleton*.
%
%      H = WAVE_PROPAGATION_VER2 returns the handle to a new WAVE_PROPAGATION_VER2 or the handle to
%      the existing singleton*.
%
%      WAVE_PROPAGATION_VER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVE_PROPAGATION_VER2.M with the given input arguments.
%
%      WAVE_PROPAGATION_VER2('Property','Value',...) creates a new WAVE_PROPAGATION_VER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Wave_Propagation_Ver2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Wave_Propagation_Ver2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Wave_Propagation_Ver2

% Last Modified by GUIDE v2.5 16-Dec-2019 20:20:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Wave_Propagation_Ver2_OpeningFcn, ...
                   'gui_OutputFcn',  @Wave_Propagation_Ver2_OutputFcn, ...
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


% --- Executes just before Wave_Propagation_Ver2 is made visible.
function Wave_Propagation_Ver2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Wave_Propagation_Ver2 (see VARARGIN)

% Choose default command line output for Wave_Propagation_Ver2
handles.output = hObject;

x = eval(get(handles.edit_x, 'string'));
y = eval(get(handles.edit_y, 'string'));

minX = x(1);
maxX = x(end);

minY = y(1);
maxY = y(end);

xlim([minX maxX]);
ylim([minY maxY]);

set(handles.pushbutton_animate, 'enable', 'off');

set(handles.edit_N, 'enable', 'off');

set(handles.edit_alphaX, 'enable', 'off');
set(handles.edit_alphaY, 'enable', 'off');

set(handles.edit_betaX, 'enable', 'off');
set(handles.edit_betaY, 'enable', 'off');

set(handles.edit_eps_r, 'enable', 'on');
set(handles.edit_mu_r, 'enable', 'on');

set(handles.pushbutton_locate_source, 'enable', 'off');
set(handles.edit_x0, 'enable', 'off');
set(handles.edit_y0, 'enable', 'off');
set(handles.edit_z0, 'enable', 'off');
set(handles.edit_rho0, 'enable', 'off');
set(handles.edit_phi0, 'enable', 'off');
set(handles.edit_z0_pol, 'enable', 'off');
set(handles.edit_r0, 'enable', 'off');
set(handles.edit_theta0, 'enable', 'off');
set(handles.edit_phi0_sph, 'enable', 'off');

set(handles.edit_ns, 'enable', 'off'); 
        
set(handles.edit_phi_cut, 'enable', 'off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Wave_Propagation_Ver2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Wave_Propagation_Ver2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_phi0_sph_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phi0_sph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phi0_sph as text
%        str2double(get(hObject,'String')) returns contents of edit_phi0_sph as a double
phi0 = eval(get(handles.edit_phi0_sph, 'string'));
[theta0, r0] = eval_r0theta0_from_phi0(handles);

elev0 = pi/2 - theta0*pi/180;

[x0, y0, z0] = sph2cart(phi0*pi/180, elev0, r0);
[phi0, rho0] = cart2pol(x0, y0);

set(handles.edit_x0, 'string', mat2str(x0));
set(handles.edit_y0, 'string', mat2str(y0));
set(handles.edit_z0, 'string', mat2str(z0));

set(handles.edit_rho0, 'string', mat2str(rho0));
set(handles.edit_phi0, 'string', mat2str(phi0*180/pi));
set(handles.edit_z0_pol, 'string', mat2str(z0));

set(handles.edit_r0, 'string', mat2str(r0));
set(handles.edit_theta0, 'string', mat2str(theta0));

set(handles.edit_ns, 'string', num2str(length(x0)));

% --- Executes during object creation, after setting all properties.
function edit_phi0_sph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phi0_sph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_r0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_r0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_r0 as text
%        str2double(get(hObject,'String')) returns contents of edit_r0 as a double
r0 = eval(get(handles.edit_r0, 'string'));
[phi0, theta0] = eval_theta0phi0_from_r0(handles);

elev0 = pi/2 - theta0*pi/180;

[x0, y0, z0] = sph2cart(phi0*pi/180, elev0, r0);
[phi0, rho0] = cart2pol(x0, y0);

set(handles.edit_x0, 'string', mat2str(x0));
set(handles.edit_y0, 'string', mat2str(y0));
set(handles.edit_z0, 'string', mat2str(z0));

set(handles.edit_rho0, 'string', mat2str(rho0));
set(handles.edit_phi0, 'string', mat2str(phi0*180/pi));
set(handles.edit_z0_pol, 'string', mat2str(z0));

set(handles.edit_theta0, 'string', mat2str(theta0));
set(handles.edit_phi0_sph, 'string', mat2str(phi0*180/pi));

set(handles.edit_ns, 'string', num2str(length(x0)));

% --- Executes during object creation, after setting all properties.
function edit_r0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_r0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta0 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta0 as a double
theta0 = eval(get(handles.edit_theta0, 'string'));
[phi0, r0] = eval_r0phi0_from_theta0(handles);

elev0 = pi/2 - theta0*pi/180;

[x0, y0, z0] = sph2cart(phi0*pi/180, elev0, r0);
[phi0, rho0] = cart2pol(x0, y0);

set(handles.edit_x0, 'string', mat2str(x0));
set(handles.edit_y0, 'string', mat2str(y0));
set(handles.edit_z0, 'string', mat2str(z0));

set(handles.edit_rho0, 'string', mat2str(rho0));
set(handles.edit_phi0, 'string', mat2str(phi0*180/pi));
set(handles.edit_z0_pol, 'string', mat2str(z0));

set(handles.edit_r0, 'string', mat2str(r0));
set(handles.edit_phi0_sph, 'string', mat2str(phi0*180/pi));

set(handles.edit_ns, 'string', num2str(length(x0)));

% --- Executes during object creation, after setting all properties.
function edit_theta0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho0 as text
%        str2double(get(hObject,'String')) returns contents of edit_rho0 as a double
rho0 = eval(get(handles.edit_rho0, 'string'));
[z0, phi0] = eval_phi0z0_from_rho0(handles);

[x0, y0] = pol2cart(phi0*pi/180, rho0);
[phi0_sph, elev0, r0]=cart2sph(x0, y0, z0);
theta0 = pi/2 - elev0;

set(handles.edit_x0, 'string', mat2str(x0));
set(handles.edit_y0, 'string', mat2str(y0));
set(handles.edit_z0, 'string', mat2str(z0));

set(handles.edit_phi0, 'string', mat2str(phi0));
set(handles.edit_z0_pol, 'string', mat2str(z0));

set(handles.edit_r0, 'string', mat2str(r0));
set(handles.edit_theta0, 'string', mat2str(theta0*180/pi));
set(handles.edit_phi0_sph, 'string', mat2str(phi0_sph*180/pi));

set(handles.edit_ns, 'string', num2str(length(x0)));

% --- Executes during object creation, after setting all properties.
function edit_rho0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_z0_pol_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z0_pol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z0_pol as text
%        str2double(get(hObject,'String')) returns contents of edit_z0_pol as a double
z0 = eval(get(handles.edit_z0_pol, 'string'));
[phi0, rho0] = eval_rho0phi0_from_z0(handles);

[x0, y0] = pol2cart(phi0*pi/180, rho0);
[phi0_sph, elev0, r0]=cart2sph(x0, y0, z0);
theta0 = pi/2 - elev0;

set(handles.edit_x0, 'string', mat2str(x0));
set(handles.edit_y0, 'string', mat2str(y0));
set(handles.edit_z0, 'string', mat2str(z0));

set(handles.edit_rho0, 'string', mat2str(rho0));
set(handles.edit_phi0, 'string', mat2str(phi0));

set(handles.edit_r0, 'string', mat2str(r0));
set(handles.edit_theta0, 'string', mat2str(theta0*180/pi));
set(handles.edit_phi0_sph, 'string', mat2str(phi0_sph*180/pi));

set(handles.edit_ns, 'string', num2str(length(x0)));

% --- Executes during object creation, after setting all properties.
function edit_z0_pol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z0_pol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x0 as text
%        str2double(get(hObject,'String')) returns contents of edit_x0 as a double
x0 = eval(get(handles.edit_x0, 'string'));
[z0,y0] = eval_y0z0_from_x0(handles);


[phi_0, rho_0] = cart2pol(x0, y0);
[phi_0_sph, elev_0, r_0] = cart2sph(x0, y0, z0);
theta_0 = pi/2 - elev_0;


set(handles.edit_rho0, 'string', mat2str(rho_0));
set(handles.edit_phi0, 'string', mat2str(phi_0*180/pi));
set(handles.edit_z0_pol, 'string', mat2str(z0));

set(handles.edit_y0, 'string', mat2str(y0));
set(handles.edit_z0, 'string', mat2str(z0));

set(handles.edit_r0, 'string', mat2str(r_0));
set(handles.edit_theta0, 'string', mat2str(theta_0*180/pi));
set(handles.edit_phi0_sph, 'string', mat2str(phi_0_sph*180/pi));


set(handles.edit_ns, 'string', num2str(length(x0)));


% --- Executes during object creation, after setting all properties.
function edit_x0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y0 as text
%        str2double(get(hObject,'String')) returns contents of edit_y0 as a double
y0 = eval(get(handles.edit_y0, 'string'));
[z0, x0] = eval_x0z0_from_y0(handles);

[phi_0, rho_0] = cart2pol(x0, y0);
[phi_0_sph, elev_0, r_0] = cart2sph(x0, y0, z0);
theta_0 = pi/2 - elev_0;

set(handles.edit_rho0, 'string', mat2str(rho_0));
set(handles.edit_phi0, 'string', mat2str(phi_0*180/pi));
set(handles.edit_z0_pol, 'string', mat2str(z0));

set(handles.edit_x0, 'string', mat2str(x0));
set(handles.edit_z0, 'string', mat2str(z0));

set(handles.edit_r0, 'string', mat2str(r_0));
set(handles.edit_theta0, 'string', mat2str(theta_0*180/pi));
set(handles.edit_phi0_sph, 'string', mat2str(phi_0_sph*180/pi));

set(handles.edit_ns, 'string', num2str(length(x0)));

% --- Executes during object creation, after setting all properties.
function edit_y0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_z0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z0 as text
%        str2double(get(hObject,'String')) returns contents of edit_z0 as a double
z0 = eval(get(handles.edit_z0, 'string'));

[y0, x0] = eval_x0y0_from_z0(handles);

[phi_0, rho_0] = cart2pol(x0, y0);
[phi_0_sph, elev_0, r_0] = cart2sph(x0, y0, z0);
theta_0 = pi/2 - elev_0;

set(handles.edit_rho0, 'string', mat2str(rho_0));
set(handles.edit_phi0, 'string', mat2str(phi_0*180/pi));
set(handles.edit_z0_pol, 'string', mat2str(z0));

set(handles.edit_x0, 'string', mat2str(x0));
set(handles.edit_y0, 'string', mat2str(y0));

set(handles.edit_r0, 'string', mat2str(r_0));
set(handles.edit_theta0, 'string', mat2str(theta_0*180/pi));
set(handles.edit_phi0_sph, 'string', mat2str(phi_0_sph*180/pi));

set(handles.edit_ns, 'string', num2str(length(x0)));


% --- Executes during object creation, after setting all properties.
function edit_z0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ns_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ns as text
%        str2double(get(hObject,'String')) returns contents of edit_ns as a double


% --- Executes during object creation, after setting all properties.
function edit_ns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_locate_source.
function pushbutton_locate_source_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_locate_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = eval(get(handles.edit_x, 'string'));
y = eval(get(handles.edit_y, 'string'));

minX = x(1);
maxX = x(end);

minY = y(1);
maxY = y(end);

xlim([minX maxX]);
ylim([minY maxY]);

x0 = eval(get(handles.edit_x0, 'string'));
y0 = eval(get(handles.edit_y0, 'string'));

Ns = length(x0);

axes(handles.axes1);
set(handles.axes1, 'visible', 'on');
cla;

colorbar off;

Ns = str2double(get(handles.edit_ns, 'string'));

for ii = 1:Ns
    
    [X0(ii, 1), Y0(ii, 1)] = ginput(1);
    
    plot(X0(ii), Y0(ii), 'LineStyle', 'none', 'Marker', 'o', 'LineWidth', 2, 'MarkerEdgeColor',[0 .5 .5], 'MarkerFaceColor',[0 .7 .7]);
    hold on;
    set(handles.axes1, 'YDir', 'normal');
    
    xlim([minX maxX]);
    ylim([minY maxY]);
    
    [Phi0, Rho0] = cart2pol(X0, Y0);

    set(handles.edit_x0, 'string', mat2str(round(X0,2), 5));
    set(handles.edit_y0, 'string', mat2str(round(Y0,2), 5));

    set(handles.edit_rho0, 'string', mat2str(round(Rho0,2), 5));
    set(handles.edit_phi0, 'string', mat2str(round(Phi0*180/pi,2), 5));
    
end



% --- Executes on button press in pushbutton_clear.
function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;
colorbar off;

set(handles.pushbutton_animate, 'enable', 'off');


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Ez_t

x = eval(get(handles.edit_x, 'string'));
y = eval(get(handles.edit_y, 'string'));

minX = x(1);
maxX = x(end);

minY = y(1);
maxY = y(end);

alphaX = str2double(get(handles.edit_alphaX, 'string'));
alphaY = str2double(get(handles.edit_alphaY, 'string'));

betaX = str2double(get(handles.edit_betaX, 'string'));
betaY = str2double(get(handles.edit_betaY, 'string'));

freq = str2double(get(handles.edit_frequency, 'string'))*1e9;

inc_angle = str2double(get(handles.edit_inc_angle, 'string')) * pi/180;

minC = str2double(get(handles.edit_minC, 'string'));
maxC = str2double(get(handles.edit_maxC, 'string'));

eps_r = eval(get(handles.edit_eps_r, 'string'));
mu_r = eval(get(handles.edit_mu_r, 'string'));

 x0 = eval(get(handles.edit_x0, 'string'));
 y0 = eval(get(handles.edit_y0, 'string'));
 z0 = eval(get(handles.edit_z0, 'string'));
 
 N = str2double(get(handles.edit_N, 'string'));

src_type = get(handles.popupmenu_source_type, 'value');

prop_vec_value = get(handles.popupmenu_prop_vec, 'value');

phi_cut = str2double(get(handles.edit_phi_cut, 'string'));

omega = 2*pi*freq;
c = 3e8;
k0 = omega/c;

switch src_type
    case 1 
        %% PLANE WAVE
        switch prop_vec_value
            case 1
                
                
                if (eps_r < 0 && mu_r < 0)
            
                    k = -k0 * sqrt(eps_r*mu_r);
                else
                    k = k0 * sqrt(eps_r*mu_r);
                end
        
                kx = k*cos(inc_angle);
                ky = k*sin(inc_angle);

        
            case 2
                
                kx = (betaX - 1i * alphaX) * k0;
                ky = (betaY - 1i * alphaY) * k0;
        
        end

        k_vec = [kx ky];
        
        Ez_t = calculate_plane_wave_field(k_vec, x, y);
        
        
    case 2 
        
        %% CYLINDRICAL WAVE
        Ez_t = calculate_cyl_field(freq, eps_r, mu_r, N,  x, y, x0, y0);
    case 3
        %% SPHERICAL WAVE
        Ez_t = calculate_sph_wave(freq, eps_r, mu_r, N, x, y, x0, y0, z0, phi_cut);
        
end

axes(handles.axes1);

imagesc(x, y, real(Ez_t));
xlim([minX maxX]);
ylim([minY maxY]);
caxis([minC, maxC]);
set(handles.axes1, 'YDir', 'normal');
colorbar

colormap jet;

set(handles.pushbutton_animate, 'enable', 'on');


% --- Executes on button press in pushbutton_animate.
function pushbutton_animate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_animate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Ez_t

nFrame = 100;
duration = 100/str2double(get(handles.edit_frequency, 'string'));

animate_field(Ez_t, nFrame, duration, handles);


function edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_x as a double


% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y as text
%        str2double(get(hObject,'String')) returns contents of edit_y as a double


% --- Executes during object creation, after setting all properties.
function edit_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_maxC_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maxC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_maxC as text
%        str2double(get(hObject,'String')) returns contents of edit_maxC as a double


% --- Executes during object creation, after setting all properties.
function edit_maxC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maxC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_minC_Callback(hObject, eventdata, handles)
% hObject    handle to edit_minC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_minC as text
%        str2double(get(hObject,'String')) returns contents of edit_minC as a double


% --- Executes during object creation, after setting all properties.
function edit_minC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_minC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_phi_cut_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phi_cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phi_cut as text
%        str2double(get(hObject,'String')) returns contents of edit_phi_cut as a double


% --- Executes during object creation, after setting all properties.
function edit_phi_cut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phi_cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_prop_vec.
function popupmenu_prop_vec_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_prop_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prop_vec = get(handles.popupmenu_prop_vec, 'value');

switch prop_vec
    case 1
        set(handles.edit_alphaX, 'enable', 'off');
        set(handles.edit_alphaY, 'enable', 'off');
        
        set(handles.edit_betaX, 'enable', 'off');
        set(handles.edit_betaY, 'enable', 'off');
        
        set(handles.edit_inc_angle, 'enable', 'on');
        
        set(handles.edit_eps_r, 'enable', 'on');
        set(handles.edit_mu_r, 'enable', 'on');
    case 2
        set(handles.edit_alphaX, 'enable', 'on');
        set(handles.edit_alphaY, 'enable', 'on');
        
        set(handles.edit_betaX, 'enable', 'on');
        set(handles.edit_betaY, 'enable', 'on');
        
         set(handles.edit_inc_angle, 'enable', 'off');
        
        set(handles.edit_eps_r, 'enable', 'off');
        set(handles.edit_mu_r, 'enable', 'off');
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_prop_vec contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_prop_vec


% --- Executes during object creation, after setting all properties.
function popupmenu_prop_vec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_prop_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_alphaX_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alphaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alphaX as text
%        str2double(get(hObject,'String')) returns contents of edit_alphaX as a double


% --- Executes during object creation, after setting all properties.
function edit_alphaX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alphaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_alphaY_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alphaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alphaY as text
%        str2double(get(hObject,'String')) returns contents of edit_alphaY as a double


% --- Executes during object creation, after setting all properties.
function edit_alphaY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alphaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_betaX_Callback(hObject, eventdata, handles)
% hObject    handle to edit_betaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_betaX as text
%        str2double(get(hObject,'String')) returns contents of edit_betaX as a double


% --- Executes during object creation, after setting all properties.
function edit_betaX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_betaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_betaY_Callback(hObject, eventdata, handles)
% hObject    handle to edit_betaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_betaY as text
%        str2double(get(hObject,'String')) returns contents of edit_betaY as a double


% --- Executes during object creation, after setting all properties.
function edit_betaY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_betaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eps_r_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eps_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eps_r as text
%        str2double(get(hObject,'String')) returns contents of edit_eps_r as a double


% --- Executes during object creation, after setting all properties.
function edit_eps_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eps_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mu_r_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mu_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mu_r as text
%        str2double(get(hObject,'String')) returns contents of edit_mu_r as a double


% --- Executes during object creation, after setting all properties.
function edit_mu_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_source_type.
function popupmenu_source_type_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_source_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_source_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_source_type
source_type = get(handles.popupmenu_source_type, 'value');

switch source_type
    case 1
        set(handles.pushbutton_locate_source, 'enable', 'off');
        set(handles.edit_x0, 'enable', 'off');
        set(handles.edit_y0, 'enable', 'off');
        set(handles.edit_z0, 'enable', 'off');
        set(handles.edit_rho0, 'enable', 'off');
        set(handles.edit_phi0, 'enable', 'off');
        set(handles.edit_z0_pol, 'enable', 'off');
        set(handles.edit_r0, 'enable', 'off');
        set(handles.edit_theta0, 'enable', 'off');
        set(handles.edit_phi0_sph, 'enable', 'off');
        
        set(handles.edit_ns, 'enable', 'off'); 
        
        set(handles.edit_phi_cut, 'enable', 'off');
        
        set(handles.edit_N, 'enable', 'off');
        set(handles.edit_inc_angle,'enable', 'on');
    case 2
        set(handles.pushbutton_locate_source, 'enable', 'on');
        set(handles.edit_x0, 'enable', 'on');
        set(handles.edit_y0, 'enable', 'on');
        set(handles.edit_z0, 'enable', 'off');
        set(handles.edit_rho0, 'enable', 'on');
        set(handles.edit_phi0, 'enable', 'on');
        set(handles.edit_z0_pol, 'enable', 'off');
        set(handles.edit_r0, 'enable', 'off');
        set(handles.edit_theta0, 'enable', 'off');
        set(handles.edit_phi0_sph, 'enable', 'off');
        
        set(handles.edit_ns, 'enable', 'on'); 
        
        set(handles.edit_phi_cut, 'enable', 'off');
        
        set(handles.edit_N, 'enable', 'on');
        set(handles.edit_inc_angle,'enable', 'off');
    case 3
        set(handles.pushbutton_locate_source, 'enable', 'on');
        set(handles.edit_x0, 'enable', 'on');
        set(handles.edit_y0, 'enable', 'on');
        set(handles.edit_z0, 'enable', 'on');
        set(handles.edit_rho0, 'enable', 'on');
        set(handles.edit_phi0, 'enable', 'on');
        set(handles.edit_z0_pol, 'enable', 'on');
        set(handles.edit_r0, 'enable', 'on');
        set(handles.edit_theta0, 'enable', 'on');
        set(handles.edit_phi0_sph, 'enable', 'on');
        
        set(handles.edit_ns, 'enable', 'on'); 
        
        set(handles.edit_phi_cut, 'enable', 'on');
end

src_type = get(handles.popupmenu_source_type, 'value');

switch src_type
    case 1
        set(handles.popupmenu_prop_vec, 'enable', 'on');
        set(handles.popupmenu_prop_vec, 'value', 1);
        
        set(handles.edit_alphaX, 'enable', 'off');
        set(handles.edit_alphaY, 'enable', 'off');
        
        set(handles.edit_betaX, 'enable', 'off');
        set(handles.edit_betaY, 'enable', 'off');
        
        set(handles.edit_eps_r, 'enable', 'on');
        set(handles.edit_mu_r, 'enable', 'on');
    case 2
        set(handles.popupmenu_prop_vec, 'enable', 'off');
        
        set(handles.edit_alphaX, 'enable', 'off');
        set(handles.edit_alphaY, 'enable', 'off');
        
        set(handles.edit_betaX, 'enable', 'off');
        set(handles.edit_betaY, 'enable', 'off');
        
        set(handles.edit_eps_r, 'enable', 'on');
        set(handles.edit_mu_r, 'enable', 'on');
    case 3
        set(handles.popupmenu_prop_vec, 'enable', 'off');
        
        set(handles.edit_alphaX, 'enable', 'off');
        set(handles.edit_alphaY, 'enable', 'off');
        
        set(handles.edit_betaX, 'enable', 'off');
        set(handles.edit_betaY, 'enable', 'off');
        
        set(handles.edit_eps_r, 'enable', 'on');
        set(handles.edit_mu_r, 'enable', 'on');
end

% --- Executes during object creation, after setting all properties.
function popupmenu_source_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_source_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inc_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inc_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inc_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_inc_angle as a double


% --- Executes during object creation, after setting all properties.
function edit_inc_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inc_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_N_Callback(hObject, eventdata, handles)
% hObject    handle to edit_N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_N as text
%        str2double(get(hObject,'String')) returns contents of edit_N as a double


% --- Executes during object creation, after setting all properties.
function edit_N_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_phi0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phi0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phi0 as text
%        str2double(get(hObject,'String')) returns contents of edit_phi0 as a double
phi0 = eval(get(handles.edit_phi0, 'string'));
[z0, rho0] = eval_rho0z0_from_phi0(handles);

[x0, y0] = pol2cart(phi0*pi/180, rho0);
[phi0_sph, elev0, r0]=cart2sph(x0, y0, z0);
theta0 = pi/2 - elev0;

set(handles.edit_x0, 'string', mat2str(x0));
set(handles.edit_y0, 'string', mat2str(y0));
set(handles.edit_z0, 'string', mat2str(z0));

set(handles.edit_rho0, 'string', mat2str(rho0));
set(handles.edit_z0_pol, 'string', mat2str(z0));

set(handles.edit_r0, 'string', mat2str(r0));
set(handles.edit_theta0, 'string', mat2str(theta0*180/pi));
set(handles.edit_phi0_sph, 'string', mat2str(phi0_sph*180/pi));

set(handles.edit_ns, 'string', num2str(length(x0)));

% --- Executes during object creation, after setting all properties.
function edit_phi0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phi0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
