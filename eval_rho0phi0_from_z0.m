function [phi0, rho0] = eval_rho0phi0_from_z0(handles)

rho00 = eval(get(handles.edit_rho0, 'string'));
phi00 = eval(get(handles.edit_phi0, 'string'));
zz0 = eval(get(handles.edit_z0_pol, 'string'));

if (length(zz0) > length(phi00))
    n = length(zz0) - length(phi00);
    phi0 = [phi00; zeros(n, 1)];
    
    if (length(zz0) > length(rho00))
        
        n = length(zz0) - length(rho00);
        rho0 = [rho00; zeros(n, 1)];

    elseif (length(zz0) < length(rho00))
        
        n = length(rho00) - length(zz0);
        rho00((end - n+1):end)=[];
        rho0 = rho00;
        
    else
        
        rho0 = rho00;
    end
    
elseif (length(zz0) < length(phi00))
    n = length(phi00) - length(zz0);
    phi00((end - n+1):end)=[];
    phi0 = phi00;
    
    if (length(zz0) > length(rho00))
        
        n = length(zz0) - length(rho00);
        rho0 = [rho00; zeros(n, 1)];

    elseif (length(zz0) < length(rho00))
        
        n = length(rho00) - length(zz0);
        rho00((end - n+1):end)=[];
        rho0 = rho00;
        
    else
        
        rho0 = rho00;
    end
else
    phi0 = phi00;
    
    if (length(zz0) > length(rho00))
        
        n = length(zz0) - length(rho00);
        rho0 = [rho00; zeros(n, 1)];

    elseif (length(zz0) < length(rho00))
        
        n = length(rho00) - length(zz0);
        rho00((end - n+1):end)=[];
        rho0 = rho00;
        
    else
        
        rho0 = rho00;
    end
end

end