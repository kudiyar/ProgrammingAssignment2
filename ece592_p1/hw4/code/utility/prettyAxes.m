function prettyAxes()
    set(findobj(gcf, 'type','axes'), 'Visible','off');
    set(gca,'visible', 'off', 'position',[0 0 1 1],...
        'units','normalized','Color',[0 0 0]);
end