clc;clear;close all
%% 根据你的数据存储路径修改
filename1 = '';
m1 = csvread(filename1,21,0);
data1=m1(:,4);

%% 全局变量
G = 5;                   % 模糊粒元数
sigma_prp = 1.0;         % PRP 高斯核宽度
window_len = 256;      % 窗口长度
step       = 256;      % 滑动步长，如果想要更多重叠可以写更小的值，比如 64，32 等
N = size(data1, 1);    % data1 的总样本数

%% 图像生成步骤
idx = 1;% 计数指针
count = 0;
file_path0='';%根据你的存储路径修改
while idx + window_len - 1 <= N
   % 取出从 idx 到 idx+window_len-1 的这一窗的数据
   d = data1(idx : idx + window_len - 1, :);
   PRP= FGPRP(d, G, sigma_prp);
   count = count + 1;                % 计数器自增
   m_1 = figure(1);
   set(gcf,'Position',[0,0,163.84,163.84]);
   set(gca,'Position',[0,0,1,1]);		%去除白边\
   colormap(jet);  % 黑表示相似度高，白表示相似度低
   colorbar;
   axis off;  %关闭坐标
   imagesc(PRP);
   idx = idx + step;
   saveas(m_1, strcat( file_path0 ,'\','health_',num2str(count),'.bmp'));
end

