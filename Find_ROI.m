function OutData=Find_ROI(filename)

load(filename)

LiqLess=Remove_liq_oneData(filename);

size_of_data=size(LiqLess);

per=LiqLess(:,4);
cond=LiqLess(:,5);

training=[mean(per) mean(cond); max(per) max(cond)];
group = [1;2];

LiqLess(:,6) = knnclassify([per cond], training, group);

OutData=LiqLess;

end