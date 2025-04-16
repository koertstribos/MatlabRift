classdef Qtex
    properties
        tex
        texs
        size
        osc
        pos
        poss
        win
    end

    methods
        function obj = Qtex(win, osc, tex, pos)
            obj.win = win;
            obj.tex = tex;
            obj.pos = pos;
            texSize = size(tex);
            obj.size = texSize(1:2);

            %location stuff
            dx = 480*2;
            dy = 270*2;

            x = pos(1);
            y = pos(2);

            obj.poss = [
                [x , y + dy];
                [x + dx, y + dy];
                [x , y];
                [x + dx, y]
                ];


            %osc typing
            if isa(osc, 'Oscillation')
                %do nothing
            elseif isnumeric(osc) && ~ismatrix(osc)
                osc = Oscillation(osc,1);
            elseif ismatrix(osc)
                osc = Oscillation(osc(1), osc(2));
            end
            obj.osc = osc;

            %initialise texs
            obj.texs = ones(osc.frames,obj.size(1), obj.size(2), 3);
            for i = 1:osc.frames
                %interpolate between arg tex(1:3) and arg tex(4:6) using
                %osc
                lumVal = osc.lookup(i);
                obj.texs(i, :,:,:) = lumVal * obj.tex(:,:,1:3) + (1-lumVal) * obj.tex(:,:,4:6);
            end
        end

        function Draw(obj, frameNo)
            frames480 = frameNo * 4: frameNo * 4 + 3;
            frames480 = mod(frames480, obj.osc.frames) + 1;
            
            for i = 1:4
                tex_i = frames480(i);
                argTex = squeeze(obj.texs(tex_i,:,:,:));
                tex_ = Screen('MakeTexture', obj.win, argTex);
                Screen('DrawTexture', obj.win, tex_, [], obj.Qrect(i))
            end 
        end

        function rect = Qrect(obj, quadrant)
            qpos = obj.poss(quadrant, :);
            rect = [qpos(1) - obj.size(1);
                    qpos(2) - obj.size(2);
                    qpos(1) + obj.size(1);
                    qpos(2) + obj.size(2)];

            disp(rect);
        end
    end
end
