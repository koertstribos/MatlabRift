classdef Qobj_  < handle
    properties
        size
        osc
        pos
        poss
        win
    end

    methods
        function obj = Qobj_(win, osc, pos, size)
            obj.win = win;
            obj.pos = pos;
            obj.size = size;

            %location stuff
            dx = 480*2;
            dy = 270*2;

            x = pos(1);
            y = pos(2);

            obj.poss = [
                [x , y];
                [x + dx, y];
                [x , y + dy];
                [x + dx, y + dy]
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
        end

        function rects = qrect(obj, quadrant)
            qpos = obj.poss(quadrant, :);
            rects = [qpos(1) - obj.size(1), ... % left
                     qpos(2) - obj.size(2), ... % top
                     qpos(1) + obj.size(1), ... % right
                     qpos(2) + obj.size(2)];    % bottom
        end
    end
end
