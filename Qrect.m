classdef Qrect < Qobj_
    properties
        cols
        frames
    end

    methods
        function obj = Qrect(win, osc, pos, size, cols)
            
            obj@Qobj_(win, osc, pos, size)
            obj.cols = cols;
            obj.SetFrames();
        end

        function SetFrames(obj)
            %initialise texs
            obj.frames = ones(obj.osc.frames,3);
            for i = 1:obj.osc.frames
                %interpolate between arg tex(1:3) and arg tex(4:6) using
                %osc
                lumVal = obj.osc.lookup(i);
                obj.frames(i, :) = lumVal * obj.cols(1:3) + (1 - lumVal) * obj.cols(4:6);
            end
        end

        function res = GetFrames(obj, frameNo)
            is = frameNo * 4: frameNo * 4 + 3;
            is  = mod(is, obj.osc.frames) + 1;
            res = obj.frames(is);
        end

        function Draw(obj, frameNo)
            frameColours = obj.GetFrames(frameNo);
            for i = 1:4
                Screen('FillRect', obj.win, frameColours(i), obj.qrect(i));
            end
        end
    end
end
