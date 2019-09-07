function log04error(messageString)

    % post to output spew
    stackStructure = dbstack; 
    if size(stackStructure,1)==1 % if there is no calling function, then give it a dummy name
        callingFunctionName = 'no calling function';
    else
        callingFunctionName = stackStructure(2).name; % the top of the stack is log02 itself, item 2 is the function that called it
    end
    screenDisplayString = [ 'WHOOPS! ', callingFunctionName, ', ', messageString ];
    disp(screenDisplayString);
    systemsound02('Windows battery low'); % I just like this sound

end

