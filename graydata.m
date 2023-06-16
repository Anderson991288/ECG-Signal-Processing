


clear;
clc;
close all;

type = ['N';'V';'F';'S';'Q'];
L = 400;
l  = sqrt(L);
%training = 700;
for i = 4
    for j = 1:5000
        load(['D:\111專題\stft\raw data-',int2str(L),'_w over_data increase','\',type(i,1),'\',type(i,1),'_',num2str(j),'.mat']);
%         if j <= training  
            standard_x = 255*(x-min(x))/(max(x)-min(x));
            s_x1 = reshape(standard_x(1,1:L),l,l);
            imagesc(s_x1);
            colormap(gray);
            
            set(gca,'xtick',[],'xticklabel',[]);
            set(gca,'ytick',[],'yticklabel',[]);

            saveas(gcf,['D:\111專題\gray scale\gray scale_3-',int2str(L),'\5TYPE\',type(i,1),'\',type(i,1),'_',num2str(j),'.jpg']);
%         else
%             standard_x = 255*(x-min(x))/(max(x)-min(x));
%             s_x1 = reshape(standard_x(1,1:L),l,l);
%             imagesc(s_x1);
%             colormap(gray);
%             saveas(gcf,['D:\111專題\gray scale\gray scale-',int2str(L),'\testing\',type(i,1),'\',type(i,1),'_',num2str(j),'.jpg']);
%         end  
    end
end