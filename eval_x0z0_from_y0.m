function [z0, x0] = eval_x0z0_from_y0(handles)

xx0 = eval(get(handles.edit_x0, 'string'));
yy0 = eval(get(handles.edit_y0, 'string'));
zz0 = eval(get(handles.edit_z0, 'string'));

if (length(yy0) > length(xx0))
    n = length(yy0) - length(xx0);
    x0 = [xx0; zeros(n, 1)];

    if (length(yy0) > length(zz0))
        
        n = length(yy0) - length(zz0);
        z0 = [zz0; zeros(n, 1)];

    elseif (length(yy0) < length(zz0))
        
        n = length(zz0) - length(yy0);
        zz0((end - n+1):end)=[];
        z0 = zz0;
        
    else
        
        z0 = zz0;
    end
        


elseif (length(yy0) < length(xx0))
    n = length(xx0) - length(yy0);
    xx0((end - n+1):end)=[];
    x0 = xx0;
    
        if (length(yy0) > length(zz0))
        
            n = length(yy0) - length(zz0);
            z0 = [zz0; zeros(n, 1)];

        elseif (length(yy0) < length(zz0))
        
            n = length(zz0) - length(yy0);
            zz0((end - n+1):end)=[];
            z0 = zz0;
        
        else
            z0 = zz0;
        end
        
else
    x0 = xx0;
    
        if (length(yy0) > length(zz0))
        
            n = length(yy0) - length(zz0);
            z0 = [zz0; zeros(n, 1)];

        elseif (length(yy0) < length(zz0))
        
            n = length(zz0) - length(yy0);
            zz0((end - n+1):end)=[];
            z0 = zz0;
        
        else
            z0 = zz0;
        end
end

end