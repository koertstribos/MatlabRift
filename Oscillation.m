classdef Oscillation
    properties
        frames
        cycles
        lsp
        lookup
    end

    methods
        function obj = Oscillation(frames, cycles)
            obj.cycles = cycles;
            obj.frames = frames;

            %construct linspace
            obj.lsp = linspace(0, 2 * pi * cycles, frames+1);
            obj.lsp = obj.lsp(1:frames);
            obj.lookup = cos(obj.lsp) * 0.5 + 0.5;
        end
    end
end