function hb_quickFigExport(fignum)
papersize = [0 0 28 20*(3/4)];
dpiLevel = 800;
saveformat = '.tiff';
saveFigName = ['Figure' num2str(fignum) saveformat];
set(gcf,'PaperUnits','inches','PaperPosition',papersize)
eval(sprintf('print -dtiff  %s -r%d'),[saveFigName,dpiLevel]);
return