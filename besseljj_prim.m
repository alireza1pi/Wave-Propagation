function jj = besseljj_prim(n, x)

jj = besseljj(n-1, x) - (n+1)./x .* besseljj(n, x);

end