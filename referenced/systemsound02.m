function systemsound02(soundName)

% copied from systemsound v 1.0.0 by Drew Weymouth
%
% Plays a Microsoft Windows system sound specified by an input string.
%   string is an exact filename of a .wav file in the C:\Windows\Media
%   directory.  Do not include the '.wav' extension.
% Examples: 
%   systemsound02('critical stop')

dir = 'C:\Windows\Media\';
fullPath = [ dir, soundName, '.wav'];
[y,fs]= audioread(fullPath);

% this is to keep it from crashing HoS
global suppressSound
if suppressSound
else
    sound(y,fs,16)
end

end

