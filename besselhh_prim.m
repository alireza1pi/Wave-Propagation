function hh = besselhh_prim(n, a, x)

hh = besselhh(n-1, a, x) - (n+1)./x .* besselhh(n, a, x);

end