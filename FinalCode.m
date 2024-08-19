clc;
clear ALL;
obj = VideoReader('CarVid.mp4');

Cars = FindCar(obj);

Best_Output = 0;
Best_Accuracy = 0;

for i=1 : size(Cars, 2)
    figure(1)
    imshow(Cars(i));
    [output, acc] = DetectRead(Cars(i).cdata);
    if acc > Best_Accuracy
        Best_Output = output;
    end
end

Best_Output