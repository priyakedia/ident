function sys = idpoly(varargin)
    [lhs,rhs] = argn(0)
    tempCell = cell(6,1)
    tempTs = 0
    for ii = 1:rhs
        if typeof(varargin(ii)) == 'string' & varargin(ii) == 'Ts' then
            tempCell{6,1} = varargin(ii+1)
            break
        elseif ~size(varargin(ii),'*') then
            tempCell{ii,1} = 1
        elseif size(varargin(ii),'*') then
            tempCell{ii,1} = varargin(ii)
        end
    end
    //disp(tempCell)
    for ii = 1:6 
        if ~size(cell2mat(tempCell(ii,1)),'*') & ii ~= 6 then
            tempCell{ii,1} = 1
        elseif ~size(cell2mat(tempCell(ii,1)),'*') & ii == 6 then
            tempCell{ii,1} = -1
        end
    end
    //storing the data in A,B,C,D,F matrix
    //          B(z)             D(z)
    // y(n)=---------- u(n)+ ----------- e(n)
    //       A(z)F(z)          A(z)D(z)
    A = cell2mat(tempCell(1,1));  B = cell2mat(tempCell(2,1));
    C = cell2mat(tempCell(3,1));  D = cell2mat(tempCell(4,1));
    F = cell2mat(tempCell(5,1)); Ts = cell2mat(tempCell(6,1));
    if A(1,1) ~= 1 then
        error(msprintf(gettext("%s: The first coefficient of ""A(z)"" polynomial must be 1.\n"),"idpoly"))
    elseif C(1,1) ~= 1 then
        error(msprintf(gettext("%s: The first coefficient of ""C(z)"" polynomial must be 1.\n"),"idpoly"))
    elseif D(1,1) ~= 1 then
        error(msprintf(gettext("%s: The first coefficient of ""D(z)"" polynomial must be 1.\n"),"idpoly"))
    elseif F(1,1) ~= 1 then
        error(msprintf(gettext("%s: The first coefficient of ""F(z)"" polynomial must be 1.\n"),"idpoly"))
    end
    t = tlist(['idpoly','a','b','c','d','f','Variable','TimeUnit','Ts'],A,B,C,D,F,'z^-1','seconds',Ts)
    
    sys = t
endfunction


function %idpoly_p(mytlist)
    f = fieldnames(mytlist)
    //A polynomial
    if mytlist(f(1)) == 1 && size(mytlist(f(1)),'*') == 1 then
    else
        mprintf('\n  A(z) =')
        temp = poly2str(mytlist(f(1)))
        mprintf('%s\n',temp)
    end
    
    //B polynomial
    if mytlist(f(2)) == 1 then
    else
        mprintf('\n  B(z) =')
        temp = poly2str(mytlist(f(2)))
        mprintf('%s\n',temp)
    end
    
    //C polynomial
    if mytlist(f(3)) == 1 && size(mytlist(f(3)),'*') == 1 then
    else
        mprintf('\n  C(z) =')
        temp = poly2str(mytlist(f(3)))
        mprintf('%s\n',temp)
    end
    //D polynomial
    if mytlist(f(4)) == 1 && size(mytlist(f(4)),'*') == 1 then
    elseif size(mytlist(f(4)),'*') > 1 then
        mprintf('\n  D(z) =')
        temp = poly2str(mytlist(f(4)))
        mprintf('%s\n',temp)
    end
    
    //F polynomial
    if mytlist(f(5)) == 1 && size(mytlist(f(5)),'*') == 1 then
    else
        mprintf('\n  F(z) =')
        temp = poly2str(mytlist(f(5)))
        mprintf('%s\n',temp)
    end
    
    mprintf('\n  Sampling Time = ')
    
    if mytlist.Ts == -1 then
        mprintf('undefined')
    else
        if ~(ceil(mytlist.Ts)-mytlist.Ts) then
            mprintf('%d %s',mytlist.Ts,mytlist.TimeUnit)
        else
            mprintf('%.0000f %s',mytlist.Ts,mytlist.TimeUnit)
        end
    end
    mprintf('\n')
        
endfunction


function strout = poly2str(h)
    temp = poly(h,'x','coeff')
    temp = pol2str(temp)
    temp = strsubst(temp,'-',' - ')
    temp = strsubst(temp,'x^',' z^-')
    temp = strsubst(temp,'x',' z^-1')
    temp = strsubst(temp,'*','')
    temp = strsubst(temp,'+',' + ')
    [ind which]=strindex(temp,'-')
    //disp(ind)
//    disp(which)
    if ind(1,1) ~= 2 then
        temp = ' ' + temp
    elseif ind(1,1) == 2 then
        temp = part(temp,4:length(temp))
        temp = ' -' + temp
    end
    strout = temp
endfunction
