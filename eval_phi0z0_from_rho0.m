function [z0, phi0] = eval_phi0z0_from_rho0(handles)

rho00 = eval(get(handles.edit_rho0, 'string'));
zz0 = eval(get(handles.edit_z0_pol, 'string'));
phi00 = eval(get(handles.edit_phi0, 'string'));

if (length(rho00) > length(zz0))
    n = length(rho00) - length(zz0);
    z0 = [zz0; zeros(n, 1)];
    
    if (length(rho00) > length(phi00))
        
        n = length(rho00) - length(phi00);
        phi0 = [phi00; zeros(n, 1)];

    elseif (length(rho00) < length(phi00))
        
        n = length(phi00) - length(rho00);
        phi00((end - n+1):end)=[];
        phi0 = phi00;
        
    else
        
        phi0 = phi00;
    end
    
elseif (length(rho00) < length(zz0))
    n = length(zz0) - length(rho00);
    zz0((end - n+1):end)=[];
    z0 = zz0;
    
    if (length(rho00) > length(phi00))
        
        n = length(rho00) - length(phi00);
        phi0 = [phi00; zeros(n, 1)];

    elseif (length(rho00) < length(phi00))
        
        n = length(phi00) - length(rho00);
        phi00((end - n+1):end)=[];
        phi0 = phi00;
        
    else
        
        phi0 = phi00;
    end
else
    z0 = zz0;
    
    if (length(rho00) > length(phi00))
        
        n = length(rho00) - length(phi00);
        phi0 = [phi00; zeros(n, 1)];

    elseif (length(rho00) < length(phi00))
        
        n = length(phi00) - length(rho00);
        phi00((end - n+1):end)=[];
        phi0 = phi00;
        
    else
        
        phi0 = phi00;
    end
end

end