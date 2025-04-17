
projectorOn = true;

Screen('Preference', 'SkipSyncTests', 0);
screens = Screen('Screens');
screenNumber = max(screens);
[windowPointer, windowRect] = Screen('OpenWindow', screenNumber, [100, 100, 100]);

size = 128;
texMax = ones([size,size,3]) * 40;
texMin = zeros([size,size,3]);
texComb = cat(3, texMax, texMin);

qtex = Qtex(windowPointer, [7 1], texComb, [540 135]);
qrect = Qrect(windowPointer, [7 1], [140 135], [size size], texComb(1,1,:));

t = 10;
frames = t * 120;

flipTimes = zeros(1,frames);

if projectorOn
    Datapixx('Open');
    Datapixx('SetPropixxDlpSequenceProgram', 2); % 2 for 480, 5 for 1440 Hz, 0 for normal
    Datapixx('RegWrRd');
end

for i = 1:frames
    qrect.Draw(i);
    qtex.Draw(i)
    flipTimes(i) = Screen('Flip', windowPointer);
    if ~projectorOn
        KbPressWait
    end
end

%Restore PROPixx State
if projectorOn
    Datapixx('SetPropixxDlpSequenceProgram', 0);
    Datapixx('RegWrRd');
    Datapixx('close'); 
end
Screen('Close', windowPointer);

plot(diff(flipTimes()));
ylim([0.006 0.010]);
