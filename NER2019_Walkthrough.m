%% ========================================================================= %%
%              NER Conference paper Walkthrough ( Liberti 2019 )
%%% ======================================================================= %%%


% WAL3
% d092918

% Dependencies:
% CaBMI: https://github.com/WALIII/CaBMI

%% Data structure:
% Time in session of 'hit'
% ------[   Direct Neurons  ]--------

% D_ROIhits:
% D_hittimes: timing of all hits

% ------[ Indirect Neurons  ]--------

% ROIhits
% ROIhits_z
% ROIhits_s: deconvolved, detrended Ca data.
% ROIhits_s: Spike inference data
% ROI_map: Spatial location of extracted ROIs
%




%% Figure 2
all_hits = 1:110; % all hits, save one at the end...
hit_range = 180:210; % Hit is centered at frame 200

% Direct Neurons
Gvar = mean(squeeze(var(squeeze(D_ROIhits(all_hits,180:210,1:2)),[],2)),2)...
- mean(squeeze(var(squeeze(D_ROIhits(all_hits,180:210,3:4)),[],2)),2);

Gmean = mean(squeeze(mean(squeeze(D_ROIhits(all_hits,190:210,1:2)),2)),2)...
-mean(squeeze(mean(squeeze(D_ROIhits(all_hits,190:210,3:4)),2)),2);

figure(); plot(Gvar,'*');
figure(); plot(Gmean,'*');

% Indirect Neurons
Pvar = var(squeeze(mean(squeeze(ROIhits_d(1:110,170:210,:)),2)),[],2);
Pmean = mean(squeeze(mean(squeeze(ROIhits_z(1:110,180:210,:)),2)),2);

figure(); plot(Pvar,'*');
figure(); plot(Pmean,'*');

% Build a linear fit:
mdl = fitlm(n2,mat2gray(Pvar));
figure(); plot(mdl);

% Hit rate is defined by this funciton ( found in the CaBMI repo ):
[out] = CaBMI_HitRate(roi_ave,direct);




%% Figure 3

% All is contained in this function ( found in the CaBMI repo ):
CaBMI_Spatiotemporal(ROIhits, ROI,ROIb)





% Plot Residuals:





figure();

% imagesc(ROIS.reference_image); colormap(gray);
ccd = ones(size(cc1,2),1);


cca = round(cc1*90)+1;
col = flipud(parula(max(cca)));

hold on;
for i = 1:90;
    col1 = cat(2,col(cca(:,i),:),ccd(i));
    plot(ROI.coordinates{ROI_WTSb(i)}(:,1),ROI.coordinates{ROI_WTSb(i)}(:,2),'Color',col1,'LineWidth',4);
end;
hold on;
for i = 1:4
    plot(ROIS.coordinates{i}(:,1),ROIS.coordinates{i}(:,2),'k','LineWidth',4);
end
