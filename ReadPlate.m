function [PlateNum, Acc] = ReadPlate(picture)
    load TRAININGSET;
    totalLetters=size(TRAIN,2);

    picture=imresize(picture,[300 500]);

    %RGB2GRAY
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    picture=rgb2gray(picture);
    figure
    subplot(1,2,1)
    imshow(picture)

    % THRESHOLDIG and CONVERSION TO A BINARY IMAGE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    threshold = graythresh(picture);
    picture =~im2bw(picture,threshold);
    subplot(1,2,2)
    imshow(picture)
    
    picture = bwareaopen(picture,1300); 
    %%%%%%%%%

    background=bwareaopen(picture,6000);
    
    picture2=picture-background;

    %%


    % Labeling connected components
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(3)
    imshow(picture2)
    [L,Ne]=bwlabel(picture2);
    propied=regionprops(L,'BoundingBox');


    hold on
    for n=1:size(propied,1)
        rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end
    hold off



    % Decision Making
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %figure
    PlateNum=[];
    t=[];
    Acc=0;
    for n=1:Ne
        [r,c] = find(L==n);
        Y=picture2(min(r):max(r),min(c):max(c));
        imshow(Y)
        Y=imresize(Y,[42,24]);
        %imshow(Y)
        pause(0.2)


        ro=zeros(1,totalLetters);
        for k=1:totalLetters   
            ro(k)=corr2(TRAIN{1,k},Y);
        end

        [MAXRO,pos]=max(ro);
        if MAXRO>.45
            out=cell2mat(TRAIN(2,pos));       
            PlateNum=[PlateNum out];
            Acc = Acc + MAXRO;
        end
    end
end