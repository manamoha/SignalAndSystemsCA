function [final_output , final_accuracy] = DetectRead(I)
    imresize(I,[4000,2000]);

    final_output = [];
    final_accuracy = 0;

    MyPlate = DetectPlate(I);

    if(size(MyPlate.x)~=0)
        for i=1 : size(MyPlate)

            if(MyPlate.width(i) == 0)
                break;
            end
            MyIm = imcrop(I, [MyPlate.x(i), MyPlate.y(i), MyPlate.width(i), MyPlate.height(i)]);
            imshow(MyIm);

            [num, acc] = ReadPlate(MyIm);
            if(acc > final_accuracy)
                final_output = num;
                final_accuracy = acc;
            end
        end
    end
end