
Screen('Preference', 'SkipSyncTests', 1);
screens = Screen('Screens');
screenNumber = max(screens);
[windowPointer, windowRect] = Screen('OpenWindow', screenNumber, [100, 100, 100]);


size = 128;
texMax = ones([size,size,3]) * 255;
texMin = zeros([size,size,3]);
texComb = cat(3, texMax, texMin);

qobj = Qtex(windowPointer, [8,1], texComb, [240,135]);

t = 4;
frames = t * 120;

flipTimes = zeros(frames);

for i = 1:frames
    qobj.Draw(i);
    flipTimes(i) = Screen('Flip', windowPointer);
    KbPressWait;
    
    
end
