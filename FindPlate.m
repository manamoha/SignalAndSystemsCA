I = imread('car.jpg');

imresize(I,[4000,2000]);
imshow(I);

picture=rgb2gray(I);

figure()
imshow(picture)

threshold = graythresh(picture);
picture =im2bw(picture,threshold);
figure()
imshow(picture)

picture = bwareaopen(picture,15000); 
figure();
imshow(picture)

[L,Ne]=bwlabel(picture);
propied=regionprops(L,'BoundingBox');


hold on
PlateMat = zeros(Ne);
num=0;
for n=1:size(propied,1)
    if (propied(n).BoundingBox(3) >590) && (propied(n).BoundingBox(3) < 1360) && (propied(n).BoundingBox(4) >120) && (propied(n).BoundingBox(4) < 300)
        rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2);

        num=num+1;
        temp = [propied(n).BoundingBox(1), propied(n).BoundingBox(2), propied(n).BoundingBox(4)*5.5, propied(n).BoundingBox(4)];
        PlateMat(num,1)=propied(n).BoundingBox(1);
        PlateMat(num,2)=propied(n).BoundingBox(2);
        PlateMat(num,3)=propied(n).BoundingBox(4)*5;
        PlateMat(num,4)=propied(n).BoundingBox(4);

        figure();
        imshow(picture);
        rectangle('Position',temp,'EdgeColor','g','LineWidth',2);
   end
end
hold off