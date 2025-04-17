classdef Qtex < Qobj_
    properties
        tex
        texs
        frames
    end

    methods
        function obj = Qtex(win, osc, tex, pos)
            texSize = size(tex);
            size_ = texSize(1:2);
            obj@Qobj_(win, osc, pos, size_);

            obj.tex = tex;
            obj.SetFrames();
        end

        function SetFrames(obj)
            obj.frames = cell(obj.osc.frames);
            obj.texs = zeros(obj.osc.frames, obj.size(1), obj.size(2), 3);
            for i = 1:obj.osc.frames
                %interpolate between arg tex(1:3) and arg tex(4:6) using
                %osc
                lumVal = obj.osc.lookup(i);
                tex_tex = lumVal * obj.tex(:,:,1:3) + (1-lumVal) * obj.tex(:,:,4:6);
                obj.frames{i} = Screen('MakeTexture', obj.win, tex_tex);
                obj.texs(i, :,:,:) = tex_tex;
            end
        end

        function Draw(obj, frameNo)
            frames480 = frameNo * 4: frameNo * 4 + 3;
            frames480 = mod(frames480, obj.osc.frames) + 1;

            for i = 1:4
                i480 = frames480(i);
                tex_ = obj.frames{i480};
                Screen('DrawTexture', obj.win, tex_, [], obj.qrect(i))
            end 
        end

    end
end
