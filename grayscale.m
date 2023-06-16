subject = [100,101,102,103,104,105,106,107,108,109,111,112,113,114,115,116,117,118,119,121,122,123,124,200,201,202,203,205,207,208,209,210,212,213,214,215,217,219,220,221,222,223,228,230,231,232,233,231];

N = 0;F = 0;V = 0;S = 0;Q = 0;O = 0;
% L為對應的資料夾
L = 3600;
for k = 1:48
    sub =subject(k);
    [sig, Fs , tm] = rdsamp(int2str(sub),1);
    [ann,anntype,subtype,chan,num,comments] = rdann(int2str(sub),'atr');
    len = length(anntype);
    for i =11:len-10
        for j = 1:3601
            x(j) = sig(ann(i,1)-1800+j-1);
        end
% % NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN   
        if anntype(i,1) == 'N' 
            N = N+1;
            filename = strcat([ 'D:\111專題\gray scale\',int2str(L),'\N\','N_',int2str(N),'.mat']);
            save(filename,'x');

        elseif anntype(i,1) == 'L' 
            N = N+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\N\','N_',int2str(N),'.mat']);
            save(filename,'x');

        elseif anntype(i,1) == 'R' 
            N = N+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\N\','N_',int2str(N),'.mat']);
            save(filename,'x');

        elseif anntype(i,1) == 'j' 
            N = N+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\N\','N_',int2str(N),'.mat']);
            save(filename,'x');

        elseif anntype(i,1) == 'e' 
            N = N+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\N\','N_',int2str(N),'.mat']);
            save(filename,'x');
% FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF                                
            elseif anntype(i,1) == 'F'
            F = F+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\F\','F_',int2str(F),'.mat']);
            save(filename,'x');
% VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV    
        elseif anntype(i,1) == 'V'
            V = V+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\V\','V_',int2str(V),'.mat']);
            save(filename,'x');
  
        elseif anntype(i,1) == 'E'
            V = V+1;
        
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\V\','V_',int2str(V),'.mat']);
            save(filename,'x');           
% SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS    
        elseif anntype(i,1) == 'S' 
            S = S+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\S\','S_',int2str(S),'.mat']);
            save(filename,'x');
   
        elseif anntype(i,1) == 'A' 
            S = S+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\S\','S_',int2str(S),'.mat']);
            save(filename,'x');  
   
        elseif anntype(i,1) == 'a' 
            S = S+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\S\','S_',int2str(S),'.mat']);
            save(filename,'x'); 
   
        elseif anntype(i,1) == 'J' 
            S = S+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\S\','S_',int2str(S),'.mat']);
            save(filename,'x');             
% QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ    
        elseif anntype(i,1) == 'Q' 
            Q = Q+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\Q\','Q_',int2str(Q),'.mat']);
            save(filename,'x');

        elseif anntype(i,1) == 'f'
            Q = Q+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\Q\','Q_',int2str(Q),'.mat']);
            save(filename,'x');           

        elseif anntype(i,1) == '/'
            Q = Q+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\Q\','Q_',int2str(Q),'.mat']);
            save(filename,'x');               
% OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO    
        else
            O = O+1;
            filename = strcat([ 'D:\111專題\gray scale\raw data-',int2str(L),'\Others\','O_',int2str(O),'.mat']);
            save(filename,'x');
    
        end
    
    
    end
end


plot(x);
