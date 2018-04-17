clear all;
clc;
f = fopen('F:/train-images.idx3-ubyte', 'r')
assert(f >= 3, '�ļ���ʧ��');               % һ���ļ����ļ���ʶ��������ڵ���3
g = fopen('F:/train-labels.idx1-ubyte', 'r');
assert(g >= 3, '�ļ���ʧ��');
fread(f, 4, 'int32');
fread(g, 2, 'int32');
% ���ȴ�����Щ .ascii �ļ�
fids = zeros(1, 10);
for i = 0:9,
    fids(i+1) = fopen(['test' num2str(i) '.ascii'], 'w');
end
n = 2000;
times =30;         % 30*2000 = 60,000
for i = 1:times,
    trainimages = fread(f, [28*28, n], 'uchar');
    trainlabels = fread(g, n, 'uchar');
    for j = 1:n,
        fprintf(fids(trainlabels(j)+1), '%3d ', trainimages(:, j));
        fprintf(fids(trainlabels(j)+1), '\n');
    end
end
for c = 0:9,
    D = load(['test' num2str(c) '.ascii'], '-ascii');
    fprintf('%5d digits of class %1d', size(D, 1), c);
    save(['train' num2str(c) '.mat'], 'D', '-mat');
    fclose(fids(c+1));
end
dos('del *.ascii');         % Windows ƽ̨��dos ����
                            % Linux ƽ̨�£�dos('rm *.ascii'); 