function result = non_uniform_grid(img)
	[rw col] = size(img);

	centRow = rw - 2 * ceil(rw * 0.07) - 2 * ceil(rw * 0.02) - 2 * ceil(rw * 0.03) - 2 * ceil(rw * 0.04) - 2 * ceil(rw * 0.09) - 2 * ceil(rw * 0.1);

	wgtRow = [floor(centRow / 2) ceil(rw * 0.1) ceil(rw * 0.09) ceil(rw * 0.04) ceil(rw * 0.03) ...
        ceil(rw * 0.02) ones(1,ceil(rw * 0.07)) 1 ones(1,ceil(rw * 0.07)) ceil(rw * 0.02) ...
        ceil(rw * 0.03) ceil(rw * 0.04) ceil(rw * 0.09) ceil(rw * 0.1) floor(centRow / 2)];
    
	grRow = [ones(1,ceil(rw * 0.07)) 1 ceil(rw * 0.02) ceil(rw * 0.03) ceil(rw * 0.04) ...
        ceil(rw * 0.09) ceil(rw * 0.1) centRow ceil(rw * 0.1) ceil(rw * 0.09) ceil(rw * 0.04) ...
        ceil(rw * 0.03) ceil(rw * 0.02) 1 ones(1,ceil(rw * 0.07)) ];

	centCol = col - 2 * ceil(col * 0.07) - 2 * ceil(col * 0.02) - 2 * ceil(col * 0.03) - 2 * ceil(col * 0.04) - 2 * ceil(col * 0.09) - 2 * ceil(col * 0.1);

	wgtCol =[floor(centCol / 2) ceil(col * 0.1) ceil(col * 0.09) ceil(col * 0.04) ceil(col * 0.03) ...
        ceil(col * 0.02) ones(1,ceil(col * 0.07)) 1 ones(1,ceil(col * 0.07)) ceil(col * 0.02) ...
		ceil(col * 0.03) ceil(col * 0.04) ceil(col * 0.09) ceil(col * 0.1) floor(centCol / 2)];

	grCol = [ones(1,ceil(col * 0.07)) 1 ceil(col * 0.02) ceil(col * 0.03) ceil(col * 0.04) ...
        ceil(col * 0.09) ceil(col * 0.1) centCol ceil(col * 0.1) ceil(col * 0.09) ceil(col * 0.04)...
		ceil(col * 0.03) ceil(col * 0.02) 1 ones(1,ceil(col * 0.07)) ];
    
	grd=grRow' * grCol;
	C=mat2cell(img,wgtRow,wgtCol);

	grH = length(wgtRow);
	grW = length(wgtCol);
	result = zeros(grH, grW);
	for m = 1:grH
		for n = 1:grW
		    result(m,n) = (1/(grH * grW)) * mean(mean(C{m,n})) * (max(max(grd)) + 5 - grd(m,n));
		end
	end
end
