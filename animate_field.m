function animate_field(Ez, nFrame, duration, handles)

x = eval(get(handles.edit_x, 'string'));
y = eval(get(handles.edit_y, 'string'));

minX = x(1);
maxX = x(end);

minY = y(1);
maxY = y(end);


freq = str2double(get(handles.edit_frequency, 'string'))*1e9;
omega = 2*pi*freq;

minC = str2double(get(handles.edit_minC, 'string'));
maxC = str2double(get(handles.edit_maxC, 'string'));


iT = linspace(0, duration, nFrame);



for ii = 1:nFrame
    
    
 imagesc(x, y, real(Ez*exp(1i*omega*iT(ii))));

 set(handles.axes1, 'YDir', 'normal');

axis([minX maxX minY maxY]);

colorbar

caxis([minC maxC]);
colormap jet;

 drawnow;

end



end