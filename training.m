clc;           
clear;        
close all;  


di=dir('Data Base');
st={di.name};
nam=st(3:end);
len=length(nam);


TRAIN=cell(2,len);
for i=1:len
   TRAIN(1,i)={imread(['Data Base','\',cell2mat(nam(i))])};
   
   %%
   threshold = graythresh(TRAIN{1,i});
   TRAIN{1,i} = im2bw(TRAIN{1,i},threshold);
   %%
   Image = TRAIN{1,i};
   [nonZeroRows,nonZeroColumns] = find(Image);
   topRow = min(nonZeroRows(:));
   bottomRow = max(nonZeroRows(:));
   leftColumn = min(nonZeroColumns(:));
   rightColumn = max(nonZeroColumns(:));
   
   
% Extract a cropped image from the original.
   TRAIN{1,i} = Image(topRow:bottomRow, leftColumn:rightColumn);
   %%
   TRAIN{1,i}=imresize(TRAIN{1,i},[42,24]);
   imshow(TRAIN{1,i})
   %%
   temp=cell2mat(nam(i));
   TRAIN(2,i)={temp(1)};
end

save('TRAININGSET.mat','TRAIN');
clear;
