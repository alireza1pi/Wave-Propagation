function [z0, rho0] = eval_rho0z0_from_phi0(handles)

rho00 = eval(get(handles.edit_rho0, 'string'));
zz0 = eval(get(handles.edit_z0_pol, 'string'));
phi00 = eval(get(handles.edit_phi0, 'string'));

if (length(phi00) > length(zz0))
    n = length(phi00) - length(zz0);
    z0 = [zz0; zeros(n, 1)];
    
    if (length(phi00) > length(rho00))
        
        n = length(phi00) - length(rho00);
        rho0 = [rho00; zeros(n, 1)];

    elseif (length(phi00) < length(rho00))
        
        n = length(rho00) - length(phi00);
        rho00((end - n+1):end)=[];
        rho0 = rho00;
        
    else
        
        rho0 = rho00;
    end
    
elseif (length(phi00) < length(zz0))
    n = length(zz0) - length(phi00);
    zz0((end - n+1):end)=[];
    z0 = zz0;
    
    if (length(phi00) > length(rho00))
        
        n = length(phi00) - length(rho00);
        rho0 = [rho00; zeros(n, 1)];

    elseif (length(phi00) < length(rho00))
        
        n = length(rho00) - length(phi00);
        rho00((end - n+1):end)=[];
        rho0 = rho00;
        
    else
        
        rho0 = rho00;
    end
else
    z0 = zz0;
    
    if (length(phi00) > length(rho00))
        
        n = length(phi00) - length(rho00);
        rho0 = [rho00; zeros(n, 1)];

    elseif (length(phi00) < length(rho00))
        
        n = length(rho00) - length(phi00);
        rho00((end - n+1):end)=[];
        rho0 = rho00;
        
    else
        
        rho0 = rho00;
    end
end

end