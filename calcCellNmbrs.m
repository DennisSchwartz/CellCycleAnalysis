%% Function to calculate cell numbers per position
function cellNmbrs = calcCellNmbrs(trees, positions)

    cellNmbrs = {};
    
    %Get trees for each position
    for pos = positions
        temp = {};
        counter = 1;
        for tree = trees
            if unique(tree{1,1}.nonFluor.positionIndex) == pos
                temp = [temp {unique(tree{1,1}.nonFluor.cellNr)}]; % Trying sth. {1, counter} = unique(tree{1.1}.nonFluor.cellNr);
                counter = counter + 1;
            end
        end
        cellNmbrs = [cellNmbrs {extractNmbrs(temp, pos)}];
    end
end

function counts = extractNmbrs(numbers, pos)
    
    counts = {}; 
    counts.perGeneration = {};
    counts.position = pos;
    counts.overall = 0;
    allNums = [];
    for i = numbers
        counts.overall = counts.overall + numel(i{1,1});
        % Extract all numbers
        allNums = [allNums i{1,1}];
    end
    
    
    numGens = ceil(log2(max(allNums)));
    
    for i = 1:numGens
        %get cellNumbers of current gen
        lowerBound = power(2, i);
        upperBound = power(2, i+1) - 1;
        %mask = tree.nonFluor.generation == i;
        temp = allNums(allNums >= lowerBound & allNums <= upperBound);
        counts.perGeneration = [counts.perGeneration; {numel(temp)}];
        %counts.cellNmbrs{1, i} = length(unique(tree.nonFluor.cellNr(tree.nonFluor.cellNr >= lowerBound & tree.nonFluor.cellNr <= upperBound)));
    end
    

end