I = imread('car.jpg');

imresize(I,[4000,2000]);
imshow(I);


final_output = [];
final_accuracy = 0;

MyPlate = DetectPlate(I);

i=1;

while(MyPlate.width(i))
    MyIm = imcrop(I, [MyPlate.x(i), MyPlate.y(i), MyPlate.width(i), MyPlate.height(i)]);
    figure();
    imshow(MyIm);
    
    [num, acc] = ReadPlate(MyIm);
    if(acc > final_accuracy)
        final_output = num;
        final_accuracy = acc;
    end
    
    i= i+1;
end

final_output