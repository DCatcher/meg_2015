% Danilo Benozzo: 1571
% Bernadette van Wijk: 1492
% Cristian Grozea: 1347
% Daniele Marinazzo: 1419
% Eelke Spak: 1304
% Haiteng Jiang: 1010
% Holger Finger: 1608
% Pieter van Mierlo: 1307
% Sajjad Karimi: 1411
% Seppo Ahlfors: 1346

fid=fopen('challengeData.bin','r','ieee-le.l64');

data=reshape(fread(fid,'float64'),6000,3,1000);

fclose(fid);