function [y0, x0] = check_eval_x0(handles)

xx0 = eval(get(handles.edit_x0, 'string'));
yy0 = eval(get(handles.edit_y0, 'string'));

if (length(xx0) > length(yy0))
    n = length(xx0) - length(yy0);
    x0 = xx0;
    y0 = [yy0; zeros(n, 1)];
elseif (length(xx0) < length(yy0))
    n = length(yy0) - length(xx0);
    y0 = yy0;
    x0 = [xx0; zeros(n, 1)];
else
    x0 = xx0;
    y0 = yy0;
end

end