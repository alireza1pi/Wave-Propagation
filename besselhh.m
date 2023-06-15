function hh = besselhh(n, a, r)

hh =  sqrt(pi./(2*r)).*besselh(n+0.5, a,r );

end