function [y0, x0] = eval_x0y0_from_z0(handles)

xx0 = eval(get(handles.edit_x0, 'string'));
yy0 = eval(get(handles.edit_y0, 'string'));
zz0 = eval(get(handles.edit_z0, 'string'));

if (length(zz0) > length(yy0))
    n = length(zz0) - length(yy0);
    y0 = [yy0; zeros(n, 1)];
    
    if (length(zz0) > length(xx0))
        
        n = length(zz0) - length(xx0);
        x0 = [xx0; zeros(n, 1)];

    elseif (length(zz0) < length(xx0))
        
        n = length(xx0) - length(zz0);
        xx0((end - n+1):end)=[];
        x0 = xx0;
        
    else
        
        x0 = xx0;
    end
    
elseif (length(zz0) < length(yy0))
    n = length(yy0) - length(zz0);
    yy0((end - n+1):end)=[];
    y0 = yy0;
    
    if (length(zz0) > length(xx0))
        
        n = length(zz0) - length(xx0);
        x0 = [xx0; zeros(n, 1)];

    elseif (length(zz0) < length(xx0))
        
        n = length(xx0) - length(zz0);
        xx0((end - n+1):end)=[];
        x0 = xx0;
        
    else
        
        x0 = xx0;
    end
else
    y0 = yy0;
    
    if (length(zz0) > length(xx0))
        
        n = length(zz0) - length(xx0);
        x0 = [xx0; zeros(n, 1)];

    elseif (length(zz0) < length(xx0))
        
        n = length(xx0) - length(zz0);
        xx0((end - n+1):end)=[];
        x0 = xx0;
        
    else
        
        x0 = xx0;
    end
end

end