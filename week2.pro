;___________________________________________________________________________________________________
;
;                                                Week 2
;    DSB Mixer, SSB Mixer, Intermodulation Products, Phase Delay Cables, Heterodyne Process, and
;                                              USB and LSB
;___________________________________________________________________________________________________

function getpico
;function to run getpico with divisor = 1, 1V range
  GETPICO, '1V', 1, 1, tseries, vmult=vmult
  return, tseries
end

function getpico_dual
;function to run getpico with divisor = 1, 1V range, with DUAL set
  GETPICO, '1V', 1, 1, tseries2D, vmult=vmult, dual=1
  return, tseries2D
end

pro get_5_1_add
;sample & save data for v_rf = 2.0 MHz, v_lo = 2.0+0.1 MHz
  N = 2048.
  v_sample = 62.5e6 ;Hz
  tseries = getpico()
  time  = (findgen(N)/v_sample) ;sec
  plot, time*1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
  save, tseries, time,  filename = 'week_2_5_1_add.sav'
end

pro restore_5_1_add
;restore and plot tseries for v_rf = 2.0 MHz, v_lo = 2.0+0.1 MHz 
  N = 2048.
  restore, 'week_2_5_1_add.sav'
  plot, time*1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
end

pro get_5_1_subtract
;sample & save data for v_rf = 2.0 MHz, v_lo = 2.0-0.1 MHz 
  N = 2048.
  v_sample = 62.5e6 ;Hz
  tseries = getpico()
  time  = (findgen(N)/v_sample) ;sec
  plot, time* 1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time - delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
  save, tseries, time,  filename = 'week_2_5_1_subtract.sav'
end

pro restore_5_1_subtract
;restore and plot tseries for v_rf = 2.0 MHz, v_lo = 2.0-0.1 MHz 
  N = 2048.
  restore, 'week_2_5_1_subtract.sav'
  plot, time* 1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time - delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
end

pro get_5_1_ft_add
;for v_rf = 2.0 MHz, v_lo = 2.0+0.1 MHz
;put data for +delta v (positive) through Fourier transform, compute & save power spectrum
  !p.multi = [0,1,2]
  N = 2048.
  v_sample = 62.5e6 ;Hz
  restore, 'week_2_5_1_add.sav'
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N) ;set and center output frequencies
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of + delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum of + delta v', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [-5,5]
  save, xinput, xoutput, yinput, youtput, power, filename = 'week_2_5_1_ft_add.sav'
end

pro restore_5_1_ft_add
;for v_rf = 2.0 MHz, v_lo = 2.0+0.1 MHz
;restore and plot power spectrum for +delta v (positive)
  !p.multi = [0,1,2]
  restore, 'week_2_5_1_ft_add.sav'
  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of + delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum of + delta v', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [-5,5]
end

pro get_5_1_ft_subtract
;for v_rf = 2.0 MHz, v_lo = 2.0-0.1 MHz
;put data for -delta v (negative) through Fourier transform, compute & save power spectrum
  !p.multi = [0,1,2]
  N = 2048.
  v_sample = 62.5e6 ;Hz
  restore, 'week_2_5_1_subtract.sav'
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N) ;set and center output frequencies
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of - delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum of - delta v', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [-5,5]
  save, xinput, xoutput, yinput, youtput, power, filename = 'week_2_5_1_ft_subtract.sav'
end

pro restore_5_1_ft_subtract
;for v_rf = 2.0 MHz, v_lo = 2.0-0.1 MHz
;restore and plot power spectrum for -delta v (negative)
  !p.multi = [0,1,2]
  restore, 'week_2_5_1_ft_subtract.sav'
  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of - delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum of - delta v', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [-5,5]
end

pro get_5_1_ift_add
;for v_rf = 2.0 MHz, v_lo = 2.0+0.1 MHz
;filter out sum of frequencies, leaving difference of frequencies, and Inverse Fourier Transform
  N = 2048.
  !p.multi = [0,1,3]
  restore, 'week_2_5_1_add.sav'
  plot, time*1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
  
;filter out sum of frequencies by zeroing anything smaller than -.2 Mhz
;or greater than .2 MHz
  restore, 'week_2_5_1_ft_add.sav'
  youtput1 = youtput
  for x = 0, n_elements(xoutput)-1 do begin
     if abs(xoutput[x]) GT (.2e6) then begin
        youtput1[x] = 0
     endif
  endfor

  plot, xoutput/1e6, (abs(youtput1))^2, psym = -4, xrange = [-1,1], charsize = 1.5, title = 'Power Spectrum Filtered + delta v', xtitle = 'frequency (MHz)', ytitle = 'power'
  dft, xoutput, youtput1, time, filtered_y, /inverse
  plot, time*1e6, filtered_y, psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
  save, time, filtered_y, filename = 'week_2_5_1_ift_add.sav'
end

pro restore_5_1_ift_add
;for v_rf = 2.0 MHz, v_lo = 2.0+0.1 MHz
;restore filtered tseries and plot tseries, filtered power spectrum, difference in frequencies
  !p.multi = [0,1,3]
  N = 2048.
  restore, 'week_2_5_1_add.sav'
  plot, time*1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
 
;filter out sum of frequencies by zeroing anything smaller than -.2 Mhz
;or greater than .2 MHz
  restore, 'week_2_5_1_ft_add.sav'
  youtput1 = youtput
  for x = 0, n_elements(xoutput)-1 do begin
     if abs(xoutput[x]) GT (.2e6) then begin
        youtput1[x] = 0
     endif
  endfor

  plot, xoutput/1e6, (abs(youtput1))^2, psym = -4, xrange = [-1,1], charsize = 1.5, title = 'Power Spectrum Filtered + delta v', xtitle = 'frequency (MHz)', ytitle = 'power'

  restore, 'week_2_5_1_ift_add.sav'
  plot, time*1e6, filtered_y, psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
end

pro restore_5_2_power_add
;for v_rf = 2.0 MHz, v_lo = 2.0+0.1 MHz
;restore & plot power spectrum with y-axis gain turned up
;we should only see peaks at 0.1 MHz and 4.1 Mhz, but we see many
;intermodulation products
  !p.multi = [0,1,1]
  restore, 'week_2_5_1_ft_add.sav'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Forest of Lines', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [0,10], yrange = [0,.1] ;y-axis gain turned up
end

pro get_5_3_add_0deg
;for v_rf = 10.5 MHz, v_lo = 10 MHz
;sample & save data for 0 degree phase shifted output, +delta v (positive)
  !p.multi = [0,1,2]
  N = 1024.
  v_sample = 62.5e6 ;Hz
  tseries2D = getpico_dual()
  sig = tseries2D[*,0] ;real values
  shift = tseries2D[*,1] ;imaginary values
  tseries = complex(sig, shift) ;combine real and imaginary values to create one complex array
  time  = (findgen(N)/v_sample) ;sec
  plot, time*1e6, sig[100:N+99], color = !yellow, title = "USB graph for 0 degree phase shift. Real: yellow. Imaginary: blue dotted.", xtitle = 'time (microsec)', ytitle = 'real (yellow) and imaginary (blue) values', charsize = 1.5
  oplot, time*1e6, shift[100:N+99], color = !blue, psym = -4
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N) ;set and center output frequencies
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum for delta w > 0', xtitle = 'frequency (MHz)', ytitle = 'power'
  save, time, sig, shift, tseries, xinput, yinput, xoutput, youtput, power, filename = 'week_2_5_3_add_0deg.sav'
end

pro restore_5_3_add_0deg
;for v_rf = 10.5 MHz, v_lo = 10 MHz
;restore & plot for 0 degree phase shifted signals, +delta v (positive)
  !p.multi = [0,1,2]
  N = 1024.
  v_sample = 62.5e6 ;Hz
  restore, 'week_2_5_3_add_0deg.sav'
  plot, time*1e6, sig[100:N+99], color = !yellow, title = "USB graph for 0 degree phase shift. Real: yellow. Imaginary: blue dotted.", xtitle = 'time (sec)', ytitle = 'real (yellow) and imaginary (blue) values', charsize = 1.5
  oplot, time*1e6, shift[100:N+99], color = !blue, psym = -4
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum for delta w > 0', xtitle = 'frequency (MHz)', ytitle = 'power'
end

pro get_5_3_subtract_0deg
;for v_rf = 9.5 MHz, v_lo = 10 MHz
;sample & save data for 0 degree phase shifted output, -delta v (negative)
  !p.multi = [0,1,2]
  N = 1024.
  v_sample = 62.5e6 ;Hz
  tseries2D = getpico_dual()
  sig = tseries2D[*,0] ;real values
  shift = tseries2D[*,1] ;imaginary values
  tseries = complex(sig, shift) ;combine real and imaginary values to create one complex array
  time  = (findgen(N)/v_sample) ;sec
  plot, time*1e6, sig[100:N+99], color = !yellow, title = "LSB graph for 0 degree phase shift. Real: yellow. Imaginary: blue dotted.", xtitle = 'time (microsec)', ytitle = 'real (yellow) and imaginary (blue) values', charsize = 1.5
  oplot, time*1e6, shift[100:N+99], color = !blue, psym = -4
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N) ;set and center output frequencies
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum for delta w < 0', xtitle = 'frequency (MHz)', ytitle = 'power'
  save, time, sig, shift, tseries, xinput, yinput, xoutput, youtput, power, filename = 'week_2_5_3_subtract_0deg.sav'
end

pro restore_5_3_subtract_0deg
;for v_rf = 9.5 MHz, v_lo = 10 MHz
;restore & plot for 0 degree phase shifted signals, -delta v (negative)
  !p.multi = [0,1,2]
  N = 1024.
  v_sample = 62.5e6 ;Hz
  restore, 'week_2_5_3_subtract_0deg.sav'
  plot, time*1e6, sig[100:N+99], color = !yellow, title = "LSB graph for 0 degree phase shift. Real: white. Imaginary: blue dotted.", xtitle = 'time (microsec)', ytitle = 'real (yellow) and imaginary (blue) values', charsize = 1.5
  oplot, time*1e6, shift[100:N+99], color = !blue, psym = -4
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum for delta w < 0', xtitle = 'frequency (MHz)', ytitle = 'power'
end

pro get_5_3_add_90deg
;for v_rf = 10.5 MHz, v_lo = 10 MHz
;sample & save data for 90 degree phase shifted output, +delta v (positive)
  !p.multi = [0,1,2]
  N = 1024.
  v_sample = 62.5e6 ;Hz
  tseries2D = getpico_dual()
  sig = tseries2D[*,0] ;real values
  shift = tseries2D[*,1] ;imaginary values
  tseries = complex(sig, shift) ;combine real and imaginary values to create one complex array
  time  = (findgen(N)/v_sample)
  plot, time*1e6, sig[100:N+99], color = !yellow, title = "USB graph for 90 degree phase shift. Real: yellow. Imaginary: blue dotted.", xtitle = 'time (microsec)', ytitle= 'real (yellow) and imaginary (blue) values', charsize = 1.5
  oplot, time*1e6, shift[100:N+99], color = !blue, psym = -4
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N) ;set and center output frequencies
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum for delta w > 0', xtitle = 'frequency (MHz)', ytitle = 'power'
  save, time, sig, shift, tseries, xinput, yinput, xoutput, youtput, power, filename = 'week_2_5_3_add_90deg.sav'
end

pro restore_5_3_add_90deg
;for v_rf = 10.5 MHz, v_lo = 10 MHz
;restore & plot for 90 degree phase shifted signals, +delta v (positive)
  !p.multi = [0,1,2]
  N = 1024.
  v_sample = 62.5e6 ;Hz
  restore, 'week_2_5_3_add_90deg.sav'
  plot, time*1e6, sig[100:N+99], color = !yellow, title = "USB graph for 90 degree phase shift. Real: yellow. Imaginary: blue dotted.", xtitle = 'time (microsec)', ytitle = 'real (yellow) and imaginary (blue) values', charsize = 1.5
  oplot, time*1e6, shift[100:N+99], color = !blue, psym = -4
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum for delta w > 0', xtitle = 'frequency (MHz)', ytitle = 'power'
end

pro get_5_3_subtract_90deg
;for v_rf = 9.5 MHz, v_lo = 10 MHz
;sample & save data for 90 degree phase shifted output, -delta v (negative)
  !p.multi = [0,1,2]
  N = 1024.
  v_sample = 62.5e6 ;Hz
  tseries2D = getpico_dual()
  sig = tseries2D[*,0] ;real values
  shift = tseries2D[*,1] ;imaginary values
  tseries = complex(sig, shift) ;combine real and imaginary values to create one complex array
  time  = (findgen(N)/v_sample) ;sec
  plot, time*1e6, sig[100:N+99], color = !yellow, title = "LSB graph for 90 degree phase shift. Real: yellow. Imaginary: blue dotted.", xtitle = 'time (microsec)', ytitle = 'real (yellow) and imaginary (blue) values', charsize = 1.5
  oplot, time*1e6, shift[100:N+99], color = !blue, psym = -4
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N) ;set and center output frequencies
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum for delta w < 0', xtitle = 'frequency (MHz)', ytitle = 'power'
  save, time, sig, shift, tseries, xinput, yinput, xoutput, youtput, power, filename = 'week_2_5_3_subtract_90deg.sav'  
end

pro restore_5_3_subtract_90deg
;for v_rf = 9.5 MHz, v_lo = 10 MHz
;restore & plot for 90 degree phase shifted signals, -delta v (negative)
  !p.multi = [0,1,2]
  N = 1024.
  v_sample = 62.5e6 ;Hz
  restore, 'week_2_5_3_subtract_90deg.sav'
  plot, time*1e6, sig[100:N+99], color = !yellow, title = "LSB graph for 90 degree phase shift. Real: yellow. Imaginary: blue dotted.", xtitle = 'time (microsec)', ytitle = 'real (yellow) and imaginary (blue) values', charsize = 1.5
  oplot, time*1e6, shift[100:N+99], color = !blue, psym = -4
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum for delta w < 0', xtitle = 'frequency (MHz)', ytitle = 'power'
end
