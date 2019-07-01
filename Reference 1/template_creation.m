%CREATE TEMPLATES 
%Alphabets
A=imread('alpha/A.bmp');B=imread('alpha/B.bmp');C=imread('alpha/C.bmp');
D=imread('alpha/D.bmp');E=imread('alpha/E.bmp');F=imread('alpha/F.bmp');
G=imread('alpha/G.bmp');H=imread('alpha/H.bmp');I=imread('alpha/I.bmp');
J=imread('alpha/J.bmp');K=imread('alpha/K.bmp');L=imread('alpha/L.bmp');
M=imread('alpha/M.bmp');N=imread('alpha/N.bmp');O=imread('alpha/O.bmp');
P=imread('alpha/P.bmp');Q=imread('alpha/Q.bmp');R=imread('alpha/R.bmp');
S=imread('alpha/S.bmp');T=imread('alpha/T.bmp');U=imread('alpha/U.bmp');
V=imread('alpha/V.bmp');W=imread('alpha/W.bmp');X=imread('alpha/X.bmp');
Y=imread('alpha/Y.bmp');Z=imread('alpha/Z.bmp');

%Natural Numbers
one=imread('alpha/1.bmp');two=imread('alpha/2.bmp');
three=imread('alpha/3.bmp');four=imread('alpha/4.bmp');
five=imread('alpha/5.bmp'); six=imread('alpha/6.bmp');
seven=imread('alpha/7.bmp');eight=imread('alpha/8.bmp');
nine=imread('alpha/9.bmp'); zero=imread('alpha/0.bmp');

%Creating Array for Alphabets
letter=[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z];
%Creating Array for Numbers
number=[one two three four five six seven eight nine zero];

% for n=1:26
%     NewTemplates{1,n}=(letter(n));
% end
% 
% i = 1;
% 
% for n=27:36
%     NewTemplates{1,n}=(number(i));
%     i = i + 1;
% end

NewTemplates=cell(1, 50);
for i=1:50
    if i==1 || i==2
        NewTemplates{1,i}=(letter(A));
    elseif i==3 || i==4
        NewTemplates{1,i}=(letter(B));
    elseif i==5
        NewTemplates{1,i}=(letter(C));
    elseif i==6 || i==7
        NewTemplates{1,i}=(letter(D));
    elseif i==8
        NewTemplates{1,i}=(letter(E));
    elseif i==9
        NewTemplates{1,i}=(letter(F));
    elseif i==10
        NewTemplates{1,i}=(letter(G));
    elseif i==11
        NewTemplates{1,i}=(letter(H));
    elseif i==12
        NewTemplates{1,i}=(letter(I));
    elseif i==13
        NewTemplates{1,i}=(letter(J));
    elseif i==14
        NewTemplates{1,i}=(letter(K));
    elseif i==15
        NewTemplates{1,i}=(letter(L));
    elseif i==16
        NewTemplates{1,i}=(letter(M));
    elseif i==17
        NewTemplates{1,i}=(letter(N));
    elseif i==18 || i==19
        NewTemplates{1,i}=(letter(O));
    elseif i==20 || i==21
        NewTemplates{1,i}=(letter(P));
    elseif i==22 || i==23
        NewTemplates{1,i}=(letter(Q));
    elseif i==24 || i==25
        NewTemplates{1,i}=(letter(R));
    elseif i==26
        NewTemplates{1,i}=(letter(S));
    elseif i==27
        NewTemplates{1,i}=(letter(T));
    elseif i==28
        NewTemplates{1,i}=(letter(U));
    elseif i==29
        NewTemplates{1,i}=(letter(V));
    elseif i==30
        NewTemplates{1,i}=(letter(W));
    elseif i==31
        NewTemplates{1,i}=(letter(X));
    elseif i==32
        NewTemplates{1,i}=(letter(Y));
    elseif i==33
        NewTemplates{1,i}=(letter(Z));
    % Numerals listings.
    elseif i==34
        NewTemplates{1,i}=(number(1));
    elseif i==35
        NewTemplates{1,i}=(number(2));
    elseif i==36
        NewTemplates{1,i}=(number(3));
    elseif i==37 || i==38
        NewTemplates{1,i}=(number(4));
    elseif i==39
        NewTemplates{1,i}=(number(5));
    elseif i==40 || i==41 || i==42
        NewTemplates{1,i}=(number(6));
    elseif i==43
        NewTemplates{1,i}=(number(7));
    elseif i==44 || i==45
        NewTemplates{1,i}=(number(8));
    elseif i==46 || i==47 || i==48
        NewTemplates{1,i}=(number(9));
    else
        NewTemplates{1,i}=(number(10));
    end
end
save ('NewTemplates','NewTemplates')
%clear all