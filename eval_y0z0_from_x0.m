function [z0, y0] = eval_y0z0_from_x0(handles)

xx0 = eval(get(handles.edit_x0, 'string'));
yy0 = eval(get(handles.edit_y0, 'string'));
zz0 = eval(get(handles.edit_z0, 'string'));

if (length(xx0) > length(yy0))
    n = length(xx0) - length(yy0);
    y0 = [yy0; zeros(n, 1)];
    
    if (length(xx0) > length(zz0))
        
        n = length(xx0) - length(zz0);
        z0 = [zz0; zeros(n, 1)];

    elseif (length(xx0) < length(zz0))
        
        n = length(zz0) - length(xx0);
        zz0((end - n+1):end)=[];
        z0 = zz0;
        
    else
        
        z0 = zz0;
    end
    
elseif (length(xx0) < length(yy0))
    n = length(yy0) - length(xx0);
    yy0((end - n+1):end)=[];
    y0 = yy0;
    
    if (length(xx0) > length(zz0))
        
        n = length(xx0) - length(zz0);
        z0 = [zz0; zeros(n, 1)];

    elseif (length(xx0) < length(zz0))
        
        n = length(zz0) - length(xx0);
        zz0((end - n+1):end)=[];
        z0 = zz0;
        
    else
        
        z0 = zz0;
    end
else
    y0 = yy0;
    
    if (length(xx0) > length(zz0))
        
        n = length(xx0) - length(zz0);
        z0 = [zz0; zeros(n, 1)];

    elseif (length(xx0) < length(zz0))
        
        n = length(zz0) - length(xx0);
        zz0((end - n+1):end)=[];
        z0 = zz0;
        
    else
        
        z0 = zz0;
    end
end

end