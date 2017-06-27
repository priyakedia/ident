function varargout = iv(varargin)
    plantData = varargin(1)
    yData = plantData(:,1)
    uData = plantData(:,2)
    n = varargin(2)
    na = n(1);nb = n(2)
    if size(n,'*') == 2 then
        nk = 1
    elseif size(n,'*') == 3 then
        nk = n(3)
    end
    noOfSample = size(plantData,'r')
    nb1 = nb + nk - 1
    n = max(na, nb1)
    phif = zeros(noOfSample,na+nb)
    // arranging samples of y matrix
    for ii = 1:na
        phif(ii+1:ii+noOfSample,ii) = yData
    end
    // arranging samples of u matrix
    for ii = 1:nb
        phif(ii+nk:ii+noOfSample+nk-1,ii+na) = uData
    end
    disp(phif)
    pause
    varargout(1) = 0
endfunction
