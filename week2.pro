;____________________________________________________________
;
;                           Week 2
;____________________________________________________________

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
  v_sample = 62.5e6
  tseries = getpico()
  time  = (findgen(N)/v_sample)
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
  v_sample = 62.5e6
  tseries = getpico()
  time  = (findgen(N)/v_sample)
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
;put data for +delta v (positive) through Fourier transform, plot & save power spectrum
  !p.multi = [0,1,2]
  N = 2048.
  v_sample = 62.5e6
  restore, 'week_2_5_1_add.sav'
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N)
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of + delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum of + delta v', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [-5,5]
  save, xinput, xoutput, yinput, youtput, power, filename = 'week_2_5_1_ft_add.sav'
end

pro restore_5_1_ft_add
;restore and plot power spectrum for +delta v (positive)
  !p.multi = [0,1,2]
  restore, 'week_2_5_1_ft_add.sav'
  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of + delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum of + delta v', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [-5,5]
end

pro get_5_1_ft_subtract
;put data for -delta v (negative) through Fourier transform, plot & save power spectrum
  !p.multi = [0,1,2]
  N = 2048.
  v_sample = 62.5e6
  restore, 'week_2_5_1_subtract.sav'
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N)
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of - delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum of - delta v', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [-5,5]
  save, xinput, xoutput, yinput, youtput, power, filename = 'week_2_5_1_ft_subtract.sav'
end

pro restore_5_1_ft_subtract
;restore and plot power spectrum for -delta v (negative)
  !p.multi = [0,1,2]
  restore, 'week_2_5_1_ft_subtract.sav'
  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of - delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum of - delta v', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [-5,5]
end

pro get_5_1_ift_add
;filter out sum of frequencies and put through Inverse Fourier
;Transform
  N = 2048.
  !p.multi = [0,1,3]
  restore, 'week_2_5_1_add.sav'
  plot, time*1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
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
;restore filtered tseries and plot tseries, filtered power spectrum, difference in frequencies
  !p.multi = [0,1,3]
  N = 2048.

  restore, 'week_2_5_1_add.sav'
  plot, time*1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
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
;restore & plot power spectrum with y-axis gain turned up
  !p.multi = [0,1,1]
  restore, 'week_2_5_1_ft_add.sav'
;  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of + delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Forest of Lines', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [3,5], yrange = [0,10]
end

pro get_5_3_add_0deg
;sample & save data for 0 degree phase shifted output, +delta v (positive)
  N = 2048.
  tseries2D = getpico_dual()
  help, tseries2D
  sig = tseries2D[*,0]
  shift = tseries2D[*,1]
  tseries = complex(sig, shift)
  plot, sig[100:N+99]
  oplot, shift[100:N+99]
  save, sig, shift, tseries, filename = 'week_2_5_3_add_0deg.sav'
end

pro restore_5_3_add_0deg
  restore, 'week_2_5_3_add_0deg.sav'
end

pro get_5_3_subtract_0deg
;sample & save data for 0 degree phase shifted output, -delta v (negative)
  N = 2048.
  tseries2D = getpico_dual()
  help, tseries2D
  sig = tseries2D[*,0]
  shift = tseries2D[*,1]
  tseries = complex(sig, shift)
  plot, sig[100:N+99]
  oplot, shift[100:N+99]
  save, sig, shift, tseries, filename = 'week_2_5_3_subtract_0deg.sav'
end

pro restore_5_3_subtract_0deg
  restore, 'week_2_5_3_subtract_0deg.sav'
end

pro get_5_3_add_90deg
;sample & save data for 90 degree phase shifted output, +delta v (positive)
  !p.multi = [0,1,2]
  N = 1024.
  v_sample = 62.5e6
  tseries2D = getpico_dual()
  help, tseries2D
  sig = tseries2D[*,0]
  shift = tseries2D[*,1]
  tseries = complex(sig, shift)
  plot, sig[100:N+99], color = !yellow
  oplot, shift[100:N+99], color = !blue
  time  = (findgen(N)/v_sample)
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N)
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput, power
  save, sig, shift, tseries, xinput, yinput, xoutput, youtput, power, filename = 'week_2_5_3_add_90deg.sav'
end

pro restore_5_3_add_90deg
  restore, 'week_2_5_3_add_90deg.sav'
end

pro get_5_3_subtract_90deg
;sample & save data for 90 degree phase shifted output, -delta v (negative)
  N = 2048.
  tseries2D = getpico_dual()
  help, tseries2D
  sig = tseries2D[*,0]
  shift = tseries2D[*,1]
  tseries = complex(sig, shift)
  plot, sig[100:N+99]
  oplot, shift[100:N+99]
  save, sig, shift, tseries, filename = 'week_2_5_3_subtract_90deg.sav'
end

pro restore_5_3_subtract_90deg
  restore, 'week_2_5_3_subtract_90deg.sav'
end

