function [phi0, theta0] = eval_theta0phi0_from_r0(handles)

r000 = eval(get(handles.edit_r0, 'string'));
theta00 = eval(get(handles.edit_theta0, 'string'));
phi00 = eval(get(handles.edit_phi0_sph, 'string'));

if (length(r000) > length(theta00))
    n = length(r000) - length(theta00);
    theta0 = [theta00; zeros(n, 1)];
    
    if (length(r000) > length(phi00))
        
        n = length(r000) - length(phi00);
        phi0 = [phi00; zeros(n, 1)];

    elseif (length(r000) < length(phi00))
        
        n = length(phi00) - length(r000);
        phi00((end - n+1):end)=[];
        phi0 = phi00;
        
    else
        
        phi0 = phi00;
    end
    
elseif (length(r000) < length(theta00))
    n = length(theta00) - length(r000);
    theta00((end - n+1):end)=[];
    theta0 = theta00;
    
    if (length(r000) > length(phi00))
        
        n = length(r000) - length(phi00);
        phi0 = [phi00; zeros(n, 1)];

    elseif (length(r000) < length(phi00))
        
        n = length(phi00) - length(r000);
        phi00((end - n+1):end)=[];
        phi0 = phi00;
        
    else
        
        phi0 = phi00;
    end
else
    theta0 = theta00;
    
    if (length(r000) > length(phi00))
        
        n = length(r000) - length(phi00);
        phi0 = [phi00; zeros(n, 1)];

    elseif (length(r000) < length(phi00))
        
        n = length(phi00) - length(r000);
        phi00((end - n+1):end)=[];
        phi0 = phi00;
        
    else
        
        phi0 = phi00;
    end
end

end