function varargout = frd(varargin)
    [lhs,rhs] = argn(0)
    if rhs < 2 || rhs > 4 then
        errmsg = msprintf(gettext("%s: input arguments must have either two or three input arguments."), "frd");
        error(errmsg)
    end
    frequency = varargin(1)
    freqUnit = 'rad/TimeUnit'
    respData = varargin(2)
    if rhs == 2 then
        Ts = 0
    elseif rhs >2 then
        Ts = varargin(3)
    end
    
    TUnit = 'seconds'
    t = tlist(['frd','Frequency','FrequencyUnit','ResponseData','Ts','TimeUnit'],frequency,freqUnit,respData,Ts,TUnit)
    varargout(1) = t
endfunction

//overloading
function %frd_p(varargin)
    myTlist = varargin(1)
    f = fieldnames(myTlist)
    freqData = myTlist.Frequency
    respData= myTlist.ResponseData
    mprintf("\t -------------------------")
    mprintf("\n")
    mprintf("\t Frequency \t Response")
    mprintf("\n")
    mprintf("\t -------------------------")
    mprintf("\n")
    for ii = 1:length(myTlist.Frequency)
        temp = ''
        if real(respData(ii))>=0 then
            temp = temp + ' '
        end
        temp = temp + string(real(respData(ii)))
//        temp = string(real(respData(ii)))
        if imag(respData(ii)) > 0 then
            temp = temp +"+"
        end
        if ~imag(respData(ii)) then
        else
            temp = temp + string(imag(respData(ii))) +"i"
        end
//        temp = temp + string(imag(respData(ii))) + " i"
        mprintf("\n\t %f \t %s",freqData(ii),temp)//real(respData(ii)),imag(respData(ii)))
    end
    mprintf("\n\n")
    if ~myTlist.Ts then
        mprintf("\n  Continuous Domain frequency response.")
    else
        mprintf("\n  Sampling Time = "+string(myTlist.Ts)+" "+myTlist.TimeUnit)
        mprintf("\n  Discrete Domain frequency response.")
    end
endfunction
