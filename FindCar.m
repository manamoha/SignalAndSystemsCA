function s = FindCar(obj)
    s = struct('cdata',zeros(obj.Height, obj.Width, 3),'colormap', []);

    k=1;

    while hasFrame(obj)
        s(k).cdata = readFrame(obj);
        k= k+1;
    end

    dif = struct('cdata',zeros(obj.Height, obj.Width, 3),'colormap', []);
    figure();
    
    
    for i=1 : size(s,2)-1
         dif(i).cdata = s(i+1).cdata - s(i).cdata;
    end
     for i=1 : size(dif,2)-1
         difdif(i).cdata = dif(i+1).cdata - dif(i).cdata;
         
         threshold = graythresh(difdif(i).cdata);
         difdif(i).cdata = im2bw(difdif(i).cdata,threshold);

         SE_Filter = strel('disk',1);

         temp = imopen(difdif(i).cdata , SE_Filter);

         [nonZeroRows,nonZeroColumns] = find(temp);
         topRow = min(nonZeroRows(:));
         bottomRow = max(nonZeroRows(:));
         leftColumn = min(nonZeroColumns(:));
         rightColumn = max(nonZeroColumns(:));

         s(i).cdata = s(i).cdata(topRow:bottomRow, leftColumn:rightColumn);

     end
end