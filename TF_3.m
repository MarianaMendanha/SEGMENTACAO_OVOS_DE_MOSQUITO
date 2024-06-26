img = imread('C:\Users\rose_\Desktop\MARI\9_NONO\IPI\TRABALHOS\TF/ovitrampa12.jpg');
nhood = imread('C:\Users\rose_\Desktop\MARI\9_NONO\IPI\TRABALHOS\TF/EEs2.bmp');
med = imread('C:\Users\rose_\Desktop\MARI\9_NONO\IPI\TRABALHOS\TF/teste_media3_1.png');
med2 = imread('C:\Users\rose_\Desktop\MARI\9_NONO\IPI\TRABALHOS\TF/teste_media3_2.png');

% M�TODO 1 / M�TODO 2
YIQ12(:,:,1) = (0.299.*(img(:,:,1)) + 0.587.*(img(:,:,2)) + 0.114.*(img(:,:,3)));
YIQ12(:,:,2) = (0.596.*(img(:,:,1)) - 0.274.*(img(:,:,2)) - 0.322.*(img(:,:,3)));
YIQ12(:,:,3) = (0.211.*(img(:,:,1)) - 0.523.*(img(:,:,2)) + 0.312.*(img(:,:,3)));

% IMAGENS Y-I-Q
figure,
subplot(2,2,1);
imshow(YIQ12);
title('YIQ');

subplot(2,2,2);
imshow(YIQ12(:,:,1));
title('Y');

subplot(2,2,3);
imshow(YIQ12(:,:,2));
title('I');

subplot(2,2,4);
imshow(YIQ12(:,:,3));
title('Q');

% C�LCULOS DE LIMIAR
  % LIMIAR DE I
limiar = graythresh(YIQ12(:,:,2))
  % LIMIAR DO ELEMENTO ESTRUTURAL
limiar2 = graythresh(nhood);

% BINARIZA��O
IBin = im2bw(YIQ12(:,:,2),limiar);
nhood = im2bw(nhood,limiar2);
imwrite(~IBin,'bin_3.png');

% RETIRADA DE RU�DOS
  % M�TODO 1
imgBW = bwareaopen(~IBin,800);
##imwrite(imgBW,'rui_3_1.png');
  % M�TODO 2
imgBW2 = bwareaopen(~IBin,900);
##imwrite(imgBW2,'rui_3_2.png');

% TAMANHO DAS IMAGENS
[linha1, coluna1, formato1] = size(imgBW);
[linha2, coluna2, formato2] = size(imgBW2);
[linha3, coluna3, formato3] = size(med);
[linha4, coluna4, formato4] = size(med2);

% FECHAMENTO COM ELEMENTO ESTRUTURAL DEFINIDO M�T 1
SE = strel('arbitrary',nhood);
imgCl = imclose(~imgBW,SE);
imgCl = ~imgCl;
##imwrite(imgCl,'fech_3.png');

% IMAGENS M�TODO 1 E 2
figure,
subplot(1,2,1);
imshow(imgCl);
title('BW');

subplot(1,2,2);
imshow(imgBW2);
title('BW2');
##imwrite(imgCl,'teste_media3_1.png');
##imwrite(imgBW2,'teste_media3_2.png');

% C�LCULO DE �REA TOTAL DOS OVOS
  % �REA M�TODO 1
sum1=0;
for i=1:1:linha1
  for j=1:1:coluna1
    if imgCl(i,j)==1
      sum1++;
    endif  
  end
end
sum1

  % �REA M�TODO 2
sum2=0;
for i=1:1:linha2
  for j=1:1:coluna2
    if imgBW2(i,j)==1
      sum2++;
    endif  
  end
end
sum2

  % C�LCULO �REA M�DIA DE UM OVO M�T 1
sum3=0;
for i=1:1:linha3
  for j=1:1:coluna3
    if med(i,j)==1
      sum3++;
    endif  
  end
end
media1=sum3/9

  % C�LCULO �REA M�DIA DE UM OVO M�T 2
sum4=0;
for i=1:1:linha4
  for j=1:1:coluna4
    if med2(i,j)==1
      sum4++;
    endif  
  end
end
media2=sum4/9

num_ovos1=sum1/media1
num_ovos2=sum2/media2

% APLICA��O DO WATERSHED
##% Calcular bwdist(), Computar segmenta��o watershed() 
##  % Calculo Euclidiano bwdist
##Dimg = bwdist(~imgCl);
##  
##  % Aplica��o da segmentacao por watershed
##Dimg = -Dimg;
##L = watershed(Dimg);
##
##  % Segmentos aplicados � imagem binaria tratada
##L(~Dimg) = 0;
##  
##  % Aplicando cor para melhor visualiza��o
##rgb = label2rgb(L,'jet',[.5 .5 .5]);
##%%figure,
##%%imshow(rgb);
####imwrite(rgb,'WatSh_cells.png');
##%%title('Transformada Watershed');