function Plate = DetectPlate(picture)

    picture =im2bw(picture,0.6);

    picture = bwareaopen(picture,15000);

    [L,Ne]=bwlabel(picture);
    propied=regionprops(L,'BoundingBox');


    hold on
    Plate = struct('x',zeros(Ne,1), 'y', zeros(Ne,1), 'width', zeros(Ne,1), 'height', zeros(Ne,1));
    num=0;
    figure();
    for n=1:size(propied,1)
        if (propied(n).BoundingBox(3) >590) && (propied(n).BoundingBox(3) < 1360) && (propied(n).BoundingBox(4) >120) && (propied(n).BoundingBox(4) < 300)

            num=num+1;
            temp = [propied(n).BoundingBox(1), propied(n).BoundingBox(2), propied(n).BoundingBox(4)*5.5, propied(n).BoundingBox(4)];
            
            Plate.x(num) = propied(n).BoundingBox(1);
            Plate.y(num) = propied(n).BoundingBox(2);
            Plate.width(num) = propied(n).BoundingBox(4)*5.5;
            Plate.height(num) = propied(n).BoundingBox(4);
            rectangle('Position',temp,'EdgeColor','g','LineWidth',2);
            
            imshow(temp);
       end
    end
    hold off
end