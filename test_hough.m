function [circleCenters, circleRadii] = test_hough(edgeImage, radiusRange)
    [rows, cols] = size(edgeImage);
    Rmin = radiusRange(1);
    Rmax = radiusRange(2);
    accumulator = zeros(rows, cols, Rmax - Rmin + 1);

    % Iterate through edge points
    [yEdges, xEdges] = find(edgeImage);
    for i = 1:length(xEdges)
        x = xEdges(i);
        y = yEdges(i);
        for r = Rmin:Rmax
            for theta = 0:360
                a = round(x - r * cosd(theta));
                b = round(y - r * sind(theta));
                if a > 0 && a <= cols && b > 0 && b <= rows
                    accumulator(b, a, r - Rmin + 1) = accumulator(b, a, r - Rmin + 1) + 1;
                end
            end
        end
    end

    % Find peaks in the accumulator
    threshold = 0.5 * max(accumulator(:));  % Adjust threshold
    [b, a, r] = ind2sub(size(accumulator), find(accumulator > threshold));
    circleCenters = [a, b];
    circleRadii = r + Rmin - 1;
end
