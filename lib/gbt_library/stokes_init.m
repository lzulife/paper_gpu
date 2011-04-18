function stokes_init(n_samples)

% Validate input fields.
% Initialization script
if (floor(log2(n_samples)) ~= log2(n_samples)),
	disp([gcb,': Number of simultaneous samples must be a power of 2.']);
	return
end

for i=0:n_samples-1,

    %inports
    xlsub2_x_in = xInport(['x',num2str(i)]);
    xlsub2_y_in = xInport(['y',num2str(i)]);

    %outports
    xlsub2_xx_out = xOutport(['x',num2str(i),'x',num2str(i),'*']);
    xlsub2_yy_out = xOutport(['y',num2str(i),'y',num2str(i),'*']);
    xlsub2_xy_re_out = xOutport(['x',num2str(i),'y',num2str(i),'*_re']);
    xlsub2_xy_im_out = xOutport(['x',num2str(i),'y',num2str(i),'*_im']);
    
    %block c_to_ri_x
    xlsub2_c_to_ri_x_out_re = xSignal;
    xlsub2_c_to_ri_x_out_im = xSignal;
    xlsub2_c_to_ri_x = xBlock(struct('source','casper_library_misc/c_to_ri','name',['c_to_ri_x_',num2str(i)]), ...
			     struct('n_bits',18,'bin_pt',0), ...
			     {xlsub2_x_in}, ...
			     {xlsub2_c_to_ri_x_out_re, xlsub2_c_to_ri_x_out_im}); 

    %block c_to_ri_y
    xlsub2_c_to_ri_y_out_re = xSignal;
    xlsub2_c_to_ri_y_out_im = xSignal;
    xlsub2_c_to_ri_y = xBlock(struct('source','casper_library_misc/c_to_ri','name',['c_to_ri_y_',num2str(i)]), ...
			     struct('n_bits',18,'bin_pt',0), ...
			     {xlsub2_y_in}, ...
			     {xlsub2_c_to_ri_y_out_re, xlsub2_c_to_ri_y_out_im}); 


    %block: cmult_dsp48e_xx
 %   xlsub2_cmult_dsp48e_xx_out_re = xSignal;
 %   xlsub2_cmult_dsp48e_xx_out_im = xSignal;
 %   cmult_dsp48e_xx.source = str2func('cmult_dsp48e_init_xblock');
 %   cmult_dsp48e_xx.depend = {'cmult_dsp48e_init_xblock'};
 %   cmult_dsp48e_xx.name = ['cmult_dsp48e_xx_',num2str(i)];

  %  xlsub2_cmult_dsp48e_xx = xblock(cmult_dsp48e_xx,...
%			     struct( 18, ...
%				     0, ...
%				     18, ...
%				     0, ...
%				     'on', ...
%				     'on', ...
%				     37, ...
%				     34, ...
%				    'Truncate', ...
%				     'Wrap', ...
%				     0 ), ...
%				    {xlsub2_c_to_ri_x_out_re, xlsub2_c_to_ri_x_out_im, xlsub2_c_to_ri_x_out_re, xlsub2_c_to_ri_x_out_im}, ...
%				    {xlsub2_cmult_dsp48e_xx_out_re,xlsub2_cmult_dsp48e_xx_out_im});
			
   % block: cmult_dsp48e_xx
    xlsub2_cmult_dsp48e_xx_out_re = xSignal;
    xlsub2_cmult_dsp48e_xx_out_im = xSignal;
    xlsub2_cmult_dsp48e_xx = xBlock(struct('source','casper_library_multipliers/cmult_dsp48e','name',['cmult_dsp48e_xx_',num2str(i)]), ...
			     struct('n_bits_a', 18, ...
				    'bin_pt_a', 0, ...
				    'n_bits_b', 18, ...
				    'bin_pt_b', 0, ...
				    'conjugated', 'on', ...
				    'full_precision', 'on', ...
				    'n_bits_c', 37, ...
				    'bin_pt_c', 34, ...
				    'quantization','Truncate', ...
				    'overflow', 'Wrap', ...
				    'cast_latency', 0 ), ...
				    {xlsub2_c_to_ri_x_out_re, xlsub2_c_to_ri_x_out_im, xlsub2_c_to_ri_x_out_re, xlsub2_c_to_ri_x_out_im}, ...
				    {xlsub2_cmult_dsp48e_xx_out_re,xlsub2_cmult_dsp48e_xx_out_im});

    %block: cmult_dsp48e_yy
    xlsub2_cmult_dsp48e_yy_out_re = xSignal;
    xlsub2_cmult_dsp48e_yy_out_im = xSignal;
    xlsub2_cmult_dsp48e_yy = xBlock(struct('source','casper_library_multipliers/cmult_dsp48e','name',['cmult_dsp48e_yy_',num2str(i)]), ...
			     struct('n_bits_a', 18, ...
				    'bin_pt_a', 0, ...
				    'n_bits_b', 18, ...
				    'bin_pt_b', 0, ...
				    'conjugated', 'on', ...
				    'full_precision', 'on', ...
				    'n_bits_c', 37, ...
				    'bin_pt_c', 34, ...
				    'quantization','Truncate', ...
				    'overflow', 'Wrap', ...
				    'cast_latency', 0 ), ...
				    {xlsub2_c_to_ri_y_out_re, xlsub2_c_to_ri_y_out_im, xlsub2_c_to_ri_y_out_re, xlsub2_c_to_ri_y_out_im}, ...
				    {xlsub2_cmult_dsp48e_yy_out_re,xlsub2_cmult_dsp48e_yy_out_im});

    %block: cmult_dsp48e_xy_3
    xlsub2_cmult_dsp48e_xy = xBlock(struct('source','casper_library_multipliers/cmult_dsp48e','name',['cmult_dsp48e_xy_',num2str(i)]), ...
			     struct('n_bits_a', 18, ...
				    'bin_pt_a', 0, ...
				    'n_bits_b', 18, ...
				    'bin_pt_b', 0, ...
				    'conjugated', 'on', ...
				    'full_precision', 'on', ...
				    'n_bits_c', 37, ...
				    'bin_pt_c', 34, ...
				    'quantization','Truncate', ...
				    'overflow', 'Wrap', ...
				    'cast_latency', 0 ), ...
				    {xlsub2_c_to_ri_x_out_re, xlsub2_c_to_ri_x_out_im, xlsub2_c_to_ri_y_out_re, xlsub2_c_to_ri_y_out_im}, ...
				    {xlsub2_xy_re_out, xlsub2_xy_im_out});

    %block:AddSub xx
    xlsub2_addsub_xx = xBlock(struct('source','AddSub','name',['addsub_xx_',num2str(i)]), ...
			      struct('mode','Addition'), ...
			      {xlsub2_cmult_dsp48e_xx_out_re,xlsub2_cmult_dsp48e_xx_out_im}, ...
			      {xlsub2_xx_out});

    %block:AddSub yy
    xlsub2_addsub_yy = xBlock(struct('source','AddSub','name',['addsub_yy_',num2str(i)]), ...
			      struct('mode','Addition'), ...
			      {xlsub2_cmult_dsp48e_yy_out_re,xlsub2_cmult_dsp48e_yy_out_im}, ...
			      {xlsub2_yy_out});

end
end
