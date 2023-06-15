function Ez_t = calculate_sph_wave(freq, eps_r, mu_r, N, x, y, x0, y0, z0, phi_cut)

% x0 = x0*1e-3;
% y0 = y0*1e-3;
% z0 = z0*1e-3;

omega = 2*pi*freq;

rho = x;
z = y;

c = 3e8;

k0 = omega/c;

k = sqrt(eps_r*mu_r) *k0;


Ns = length(x0);

[RHO, Z] = meshgrid(rho, z);


RHO = RHO*1e-3;
Z = Z*1e-3;

[ELEV, R]=cart2pol(RHO, Z);
THETA = pi/2 - ELEV;

Ez1 = zeros(size(R, 1), size(R, 2), Ns);
Ez2 = zeros(size(R, 1), size(R, 2), Ns);

Ez = zeros(size(R, 1), size(R, 2), Ns);

Ez_t = zeros(size(R));

handle_waitbar = waitbar(0, 'Calculating ...', 'Name', 'Calculate Matrices');

for ns = 1:Ns
    
    [PHI0, ELEV0, R0] = cart2sph(x0(ns)*1e-3, y0(ns)*1e-3, z0(ns)*1e-3);
    THETA0 = pi/2 - ELEV0;
    
%     phi0(phi0<0) = 2*pi + phi0(phi0<0);
                    
    logic_mat1 = zeros(size(R));
    logic_mat2 = zeros(size(R));
                    
    logic_mat1(R<R0) = 1;
    logic_mat2(R>=R0) =1;
    
    zeta = cos(THETA)*cos(THETA0) + sin(THETA)*sin(THETA0).*cos(phi_cut - PHI0);
    
    if (x0(ns) == 0 && y0(ns) == 0)
        
        Ez(:, :, ns) = besselhh(0, 2, k*R);
        
    else
    
        for n = 0:N
        
            if (eps_r < 0 && mu_r < 0)
                Ez1(:, :, ns) = Ez1(:, :, ns) ;
                Ez2(:, :, ns) = Ez2(:, :, ns) ;
            else
                Ez1(:, :, ns) = Ez1(:, :, ns) + (2*n+1)*besselhh(n, 2, k*R0)*besseljj(n, k*R).*asc_legendre(n, 0, zeta);
                Ez2(:, :, ns) = Ez2(:, :, ns) + (2*n+1)*besselhh(n, 2, k*R)*besseljj(n, k*R0).*asc_legendre(n, 0, zeta);
            end
        
            waitbar(n/(N), handle_waitbar);
        
        end
    
        Ez1(:, :, ns) = Ez1(:, :, ns).*logic_mat1;
        Ez2(:, :, ns) = Ez2(:, :, ns).*logic_mat2;
    
        Ez(:, :, ns) = Ez1(:, :, ns) + Ez2(:, :, ns);
    
    end
    
    Ez_t = Ez_t + Ez(:,:,ns);
    
end

close(handle_waitbar);

end