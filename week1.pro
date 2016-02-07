;___________________________________________________________________________________________________
;
;                                                 Week 1
; Nyquist Criterion, Running GETPICO, Fourier Voltage and Power Spectra, Triangle and Square Waves,
;                       Fourier Filtering, Leakage Power, and Frequency Resolution
;___________________________________________________________________________________________________

function time_3_2, N
;function to create time array with given N value
  time = findgen(16000)/(6.25e6)
  return, time[0:N-1]
end

function tseries_3_2, D
;function to run getpico with 1V range and given divisor D
  GETPICO, '1V', D, 1, tseries, vmult=vmult
  return, tseries[100:227]
;skip plotting first 100 points because of inconsistency in equipment
end

pro change_frq, v_sig
;function to change frequency remotely with given signal frequency
 srs1_frq, v_sig
end

pro plot_3_2, a
;sample and save data for v_sig/v_sample = ratio given by 'a'
  v_sample = 6.25e6 ;Hz
  v_sig = (a*0.1*(v_sample)) ;set v_sig/v_sample = ratio
  ratio = a*0.1
  change_frq, v_sig
  tseries = tseries_3_2(10) ;getpico with divisor = 10 (v_sample = 6.25 MHz)
  time = time_3_2(128)*1e6 ;microsec
  plot, time, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal/v_sample = '+strcompress(string(ratio), /remove_all), ytitle = 'voltage (V)', xtitle = 'time (microseconds)'
  save, tseries, time, a, filename = 'week_1_3_2_'+strcompress(string(ratio), /remove_all)+'.sav'
end

pro restore_plot_3_2, a
;restore and plot tseries for v_sig/v_sample = ratio given by 'a'
  ratio = a*0.1
  restore, 'week_1_3_2_' + strcompress(string(ratio), /remove_all) +'.sav'
  plot, time, tseries, psym = -4, charsize = 1.5, title = textoidl("Voltage vs. Time for \nu_{signal}/\nu_{sample} = ") + strcompress(string(ratio), /remove_all), ytitle = 'Voltage (V)', xtitle = 'Time (microseconds)'
end

pro plot_3_2_ft, a
;sample and save data for DFT function for v_sig/v_sample = ratio
;given by 'a'
  N=128.
  !p.multi = [0,1,2]
  v_sample = 6.25e6 ;Hz
  v_sig = (a*0.1*(v_sample)) ;set v_sig/v_sample = ratio
  ratio = a*0.1
  change_frq, v_sig
  xinput = time_3_2(N) - ((N/2.)/(v_sample)) ;center time input for DFT
  yinput = tseries_3_2(10) ;getpico with divisor = 10 (v_sample = 6.25 MHz)
  xoutput = ((findgen(N)-(N/2.))*v_sample/N) ;set and center output frequencies
  dft,  xinput, yinput, xoutput, youtput
  youtput = (abs(youtput))^2 ;power
  plot, xoutput*1e-6, youtput, psym = -4, charsize = 1.5, title = 'Power Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'power', xtitle = 'frequency (MegaHz)'
  xoutput = xoutput * 1e-6 ;MHz
  save, xinput, yinput, xoutput, youtput, a, filename = 'week_1_3_2_ft_'+strcompress(string(ratio), /remove_all)+'.sav'
end

pro restore_plot_3_2_ft, a
;restore and plot DFT for v_sig/v_sample = ratio given by 'a'
  ratio = a *0.1
  restore, 'week_1_3_2_ft_'+strcompress(string(ratio), /remove_all)+'.sav'
ps_ch, 'week_1_3_2_ft_'+strcompress(string(ratio), /remove_all)+'.ps', xsize=10, ysize=8, /color
  plot, xoutput, youtput, psym = -4, charsize = 1.5, title = 'Power Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'Power', xtitle = 'Frequency (MegaHz)'
ps_ch, /close
end

pro plot_3_3_equal
;sample and save data for v_sig = v_sample
  v_sig = 6.25e6 ;Hz
  v_sample = v_sig
  change_frq, v_sig
  tseries = tseries_3_2(10) ;getpico with divisor = 10 (v_sample = 6.25 MHz)
  time = time_3_2(128)*1e6 ;microsec
  plot, time, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal=v_sample', ytitle = 'voltage (V)', xtitle = 'time (microseconds)'
  save, tseries, time, filename = 'week_1_3_3_equal.sav'
end

pro restore_plot_3_3_equal
;restore and plot tseries for v_sig = v_sample
  restore, 'week_1_3_3_equal.sav'
  plot, time, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal=v_sample', ytitle = 'Voltage (V)', xtitle = 'Time (microseconds)'
end

pro plot_3_3_large
;sample and save data for v_sig/v_sample really large
  change_frq, 30e6 ;Hz
  getpico, '1V', 400, 1, tseries ;divisor = 400 (.15625 MHz)
  time = time_3_2(128)*1e6 ;microsec
  plot, time, tseries[100:227], psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal/v_sample >> 1', ytitle = 'voltage (V)', xtitle = 'time (microseconds)'
  save, tseries, time, filename = 'week_1_3_3_large.sav'
end

pro restore_plot_3_3_large
;restore and plot tseries for v_sig/v_sample really large
  restore, 'week_1_3_3_large.sav'
  plot, time, tseries[100:227], psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal/v_sample >> 1', ytitle = 'Voltage (V)', xtitle = 'Time (microseconds)'
end

pro plot_3_4_vs, a
;sample and save data for plotting voltage spectrum for v_sig/v_sample
;= ratio given by 'a'
  N=128.
  !p.multi = [0,1,2]
  v_sample = 6.25e6 ;Hz
  v_sig = (a*0.1*(v_sample))
  ratio = a*0.1
  change_frq, v_sig
  xinput = time_3_2(N) - ((N/2.)/(6.25e6)) ;center time input for DFT
  yinput = tseries_3_2(10) ;getpico with divisor = 10 (v_sample = 6.25 MHz)
  xoutput = ((findgen(N)-(N/2.))*v_sample/N) ;set and center output frequencies
  dft,  xinput, yinput, xoutput, youtput
  plot, xoutput*1e-6, real_part(youtput), psym = -4, charsize = 1.5, title = 'Voltage Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'Real Values', xtitle = 'Frequency (MegaHz)'
  plot, xoutput*1e-6, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Voltage Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'Imaginary Values', xtitle = 'Frequency (MegaHz)'
  xoutput = xoutput*1e-6
  save, xinput, yinput, xoutput, youtput, filename = 'week_1_3_4_vs_'+strcompress(string(ratio), /remove_all)+'.sav'
end

pro restore_plot_3_4_vs, a
;restore and plot voltage spectrum for v_sig/v_sample = ratio given by 'a'
  !p.multi = [0,1,2]
  ratio = a*0.1
  restore, 'week_1_3_4_vs_'+strcompress(string(ratio), /remove_all)+'.sav'
  plot, xoutput, real_part(youtput), psym = -4, charsize = 1.5, title = 'Voltage Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'Real Values', xtitle = 'Frequency (MegaHz)'
  plot, xoutput, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Voltage Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'Imaginary Values', xtitle = 'Frequency (MegaHz)'
end

pro plot_3_5_triangle
;sample and save data for triangle wave
  !p.multi = [0,1,2]
  N = 128.
  v_sample = (62.5e6)/6175 ;Hz
  change_frq, 1e5 ;Hz
  tseries = tseries_3_2(6175) ;getpico with divisor = 6175
  time = findgen(16000)/v_sample ;sec
  xinput = time[0:127] - ((N/2.)/(v_sample)) ;center time input for DFT
  xoutput = ((findgen(N)-(N/2.))*v_sample/N) ;set and center output frequencies
  dft, xinput, tseries, xoutput, youtput
  plot, time[0:127], tseries, psym = -4, charsize = 1.5, xtitle = 'time (second)', ytitle = 'voltage (V)', title = 'voltage vs. time for triangle wave'
  plot, xoutput/1000, (abs(youtput))^2, psym = -4, charsize = 1.5, xtitle = 'frequency (kHz)', ytitle = 'power', title = 'Power Spectrum for Triangle Wave'
  save, xinput, tseries, xoutput, youtput, time, filename = 'week_1_3_5_triangle.sav'
end

pro restore_plot_3_5_triangle
;restore and plot tseries and power spectrum for triangle wave
  !p.multi = [0,1,2]
  restore, 'week_1_3_5_triangle.sav'
 plot, time[0:127], tseries, psym = -4, charsize = 1.5, xtitle = 'Time (second)', ytitle = 'Voltage (V)', title = 'Voltage vs. Time for Triangle Wave'
 plot, xoutput/1000, (abs(youtput))^2, psym = -4, charsize = 1.5, xtitle = 'Frequency (kHz)', ytitle = 'Power', title = 'Power Spectrum for Triangle Wave'
end

pro plot_3_5_square
;sample and save data for square wave
  !p.multi = [0,1,2]
  N = 128.
  v_sample = (62.5e6)/6175 ;Hz
  change_frq, 1e5 ;Hz
  tseries = tseries_3_2(6175) ;getpico with divisor = 6175
  time = findgen(16000)/v_sample ;sec
  xinput = time[0:127] - ((N/2.)/(v_sample)) ;center time input for DFT
  xoutput = ((findgen(N)-(N/2.))*v_sample/N) ;set and center output frequencies
  dft, xinput, tseries, xoutput, youtput
  plot, time[0:127], tseries, psym = -4, charsize = 1.5, xtitle = 'time (second)', ytitle = 'voltage (V)', title = 'voltage vs. time for square wave'
  plot, xoutput/1000, (abs(youtput))^2, psym = -4, charsize = 1.5, xtitle = 'frequency (kHz)', ytitle = 'power', title = 'Power Spectrum for Square Wave'
  save, xinput, tseries, xoutput, youtput, time, filename = 'week_1_3_5_square.sav'
end

pro restore_plot_3_5_square
;restore and plot tseries and power spectrum for square wave
 !p.multi = [0,1,2]
 restore, 'week_1_3_5_square.sav'
 plot, time[0:127], tseries, psym = -4, charsize = 1.5, xtitle = 'Time (second)', ytitle = 'Voltage (V)', title = 'Voltage vs. Time for Square Wave'
 plot, xoutput/1000, (abs(youtput))^2, psym = -4, charsize = 1.5, xtitle = 'Frequency (kHz)', ytitle = 'Power', title = 'Power Spectrum for Square Wave'
end

pro plot_3_6_square
;sample and save data for Fourier filtering of square wave
  !p.multi = [0,3,2]
  N = 128.
  v_sample = (62.5e6)/6220 ;Hz
  change_frq, 1e5 ;Hz
  tseries = tseries_3_2(6220) ;getpico with divisor = 6220
  time = findgen(16000)/v_sample ;sec
  xinput = time[0:127] - ((N/2.)/(v_sample)) ;center time input for DFT
  xoutput = ((findgen(N)-(N/2.))*v_sample/N) ;set and center output frequencies
  dft, xinput, tseries, xoutput, youtput
  plot, xinput, tseries, psym = -4, charsize = 1.5, title = 'Voltage vs. Time for Square Wave', xtitle = 'Time (second)', ytitle = 'Voltage (V)'
  plot, xoutput/1000, real_part(youtput), psym = -4, charsize = 1.5, title = 'Real Part of DFT', xtitle = 'Frequency (kHz)', ytitle = 'Real Values'
  plot, xoutput/1000, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT', xtitle = 'Frequency (kHz)', ytitle = 'Imaginary Values'
  
;filter out any frequencies smaller than -1000 Hz or greater than 1000
;Hz by setting them to zero
youtput1 = youtput
  for x = 0, n_elements(xoutput)-1 do begin
     if xoutput[x] GT 1000 OR xoutput[x] LT -1000 then begin
        youtput1[x] = 0
     endif
  endfor

  plot, xoutput/1000, real_part(youtput1), psym = -4, charsize = 1.5, title = 'Real Part of DFT Filtered', xtitle = 'Frequency (kHz)', ytitle = 'Real Values'
  plot, xoutput/1000, imaginary(youtput1), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT Filtered', xtitle = 'Frequency (kHz)', ytitle = 'Imaginary Values'

  dft, xoutput, youtput1, xinput, filtered_y, /inverse
  plot, xinput, filtered_y, psym = -4, charsize = 1.5, title = 'Fourier Filtered Square Wave', xtitle = 'Time (second)', ytitle = 'Voltage (V)'
  save, time, tseries, xinput, xoutput, youtput, filtered_y, youtput1, filename = 'week_1_3_6_square_wave.sav'
end

pro restore_plot_3_6_square
;restore and plot tseries, real and imaginary part, filtered real and
;imaginary part, and filtered square wave
  !p.multi = [0,3,2]
  restore, 'week_1_3_6_square_wave.sav'
  plot, xinput*1e3, tseries, psym = -4, charsize = 2, title = 'Voltage vs. Time for Square Wave', xtitle = 'Time (millisecond)', ytitle = 'Voltage (V)'
  plot, xoutput/1000, real_part(youtput), psym = -4, charsize = 2, title = 'Real Part of DFT', xtitle = 'Frequency (kHz)', ytitle = 'Real Values'
  plot, xoutput/1000, imaginary(youtput), psym = -4, charsize = 2, title = 'Imaginary Part of DFT', xtitle = 'Frequency (kHz)', ytitle = 'Imaginary Values'
  plot, xoutput/1000, real_part(youtput1), psym = -4, charsize = 2, title = 'Real Part of DFT Filtered', xtitle = 'Frequency (kHz)', ytitle = 'Real Values'
  plot, xoutput/1000, imaginary(youtput1), psym = -4, charsize = 2, title = 'Imaginary Part of DFT Filtered', xtitle = 'Frequency (kHz)', ytitle = 'Imaginary Values'
  plot, xinput*1e3, filtered_y, psym = -4, charsize = 2, title = 'Fourier Filtered Square Wave', xtitle = 'Time (millisecond)', ytitle = 'Voltage'
end

pro plot_3_6_triangle
;sample and save data for Fourier filtering of triangle wave
  !p.multi = [0,3,2]
  N = 128.
  v_sample = (62.5e6)/6220 ;Hz
  change_frq, 1e5 ;Hz
  tseries = tseries_3_2(6220) ;getpico with divisor = 6220
  time = findgen(16000)/v_sample ;sec
  xinput = time[0:127] - ((N/2.)/(v_sample)) ;center time input for DFT
  xoutput = ((findgen(N)-(N/2.))*v_sample/N) ;set and center input frequencies
  dft, xinput, tseries, xoutput, youtput
  plot, xinput, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for triangle wave', xtitle = 'time (second)', ytitle = 'voltage (V)'
  plot, xoutput/1000, real_part(youtput), psym = -4, charsize = 1.5, title = 'Real Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'real values'
  plot, xoutput/1000, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'imaginary values'

;filter out any frequencies smaller than -1000 Hz or greater than 1000
;Hz by setting them to zero
youtput1 = youtput
  for x = 0, n_elements(xoutput)-1 do begin
     if xoutput[x] GT 1000 OR xoutput[x] LT -1000 then begin
        youtput1[x] = 0
     endif
endfor

plot, xoutput/1000, real_part(youtput1), psym = -4, charsize = 1.5, title = 'Real Part of DFT Filtered', xtitle = 'frequency (kHz)', ytitle = 'real values'
plot, xoutput/1000, imaginary(youtput1), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT Filtered', xtitle = 'frequency (kHz)', ytitle = 'imaginary values'

  dft, xoutput, youtput1, xinput, filtered_y, /inverse
  plot, xinput, filtered_y, psym = -4, charsize = 1.5, title = 'Fourier Filtered Triangle Wave', xtitle = 'time (second)', ytitle = 'voltage'
  save, time, tseries, xinput, xoutput, youtput, filtered_y, youtput1, filename = 'week_1_3_6_triangle_wave.sav'
end

pro restore_plot_3_6_triangle
;restore and plot tseries, real and imaginary part, filtered real and
;imaginary part, and filtered triangle wave
  !p.multi = [0,3,2]
  restore, 'week_1_3_6_triangle_wave.sav'
  plot, xinput*1e3, tseries, psym = -4, charsize = 2, title = 'Voltage vs. Time for Triangle Wave', xtitle = 'Time (millisecond)', ytitle = 'Voltage (V)'
  plot, xoutput/1000, real_part(youtput), psym = -4, charsize = 2, title = 'Real Part of DFT', xtitle = 'Frequency (kHz)', ytitle = 'Real Values'
  plot, xoutput/1000, imaginary(youtput), psym = -4, charsize = 2, title = 'Imaginary Part of DFT', xtitle = 'Frequency (kHz)', ytitle = 'Imaginary Values'
  plot, xoutput/1000, real_part(youtput1), psym = -4, charsize = 2, title = 'Real Part of DFT Filtered', xtitle = 'Frequency (kHz)', ytitle = 'Real Values'
  plot, xoutput/1000, imaginary(youtput1), psym = -4, charsize = 2, title = 'Imaginary Part of DFT Filtered', xtitle = 'Frequency (kHz)', ytitle = 'Imaginary Values'
  plot, xinput*1e3, filtered_y, psym = -4, charsize = 2, title = 'Fourier Filtered Triangle Wave', xtitle = 'Time (millisecond)', ytitle = 'Voltage (V)'
end

pro plot_3_7
;sample and save data for leakage power
N = 1024. ;higher N than recommended
D = 1 ;divisor
!p.multi = [0,2,2]
v_sample = (62.5) / float(D) ;Hz
change_frq, 0.1*(62.5e6) ;Hz
GETPICO, '1V', D, 1, tseries
tseries = tseries[100:1123]
time = findgen(1024)/(62.5) - ((N/2.)/v_sample) ;center time input for DFT
plot, time, tseries, psym = -4, xrange = [-2,2], charsize = 1.5, title = 'voltage vs. time', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
xoutput = (findgen(N)-(N/2.))*(v_sample/N) ;set and center input frequencies
dft, time, tseries, xoutput, youtput
plot, xoutput, (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [2,10], yrange = [0,100]
plot, xoutput, real_part(youtput), psym = -4, charsize = 1.5, title = 'Real Part of DFT', xtitle = 'frequency (MHz)', ytitle = 'real values'
plot, xoutput, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT', xtitle = 'frequency (MHz)', ytitle = 'imaginary values'
save, tseries, time, xoutput, youtput, filename = 'week_1_3_7.sav'
end

pro restore_plot_3_7
;restore and plot leakage power
 !p.multi = [0,2,2]
 restore, 'week_1_3_7.sav'
 plot, time, tseries, psym = -4, xrange = [-2,2], charsize = 1.5, title = 'Voltage vs. Time', xtitle = 'Time (microsec)', ytitle = 'Voltage (V)'
 plot, xoutput, (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'Frequency (MHz)', ytitle = 'Power', xrange = [2,10], yrange = [0,100]
 plot, xoutput, real_part(youtput), psym = -4, charsize = 1.5, title = 'Real Part of DFT', xtitle = 'Frequency (MHz)', ytitle = 'Real Values'
 plot, xoutput, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT', xtitle = 'Frequency (MHz)', ytitle = 'Imaginary Values'
end

pro plot_3_8
;sample and save data for frequency resolution
!p.multi = [0,1,1]
D = 1 ;divisor
v_sample = 62.5e6 / D ;Hz
N = 128.
getpico, '1V', D, 1,  tseries
time = (findgen(N) - (N/2.)) / v_sample ;center time input for DFT
xoutput = (findgen(N) - (N/2.))*(v_sample/N) ;set and center frequency inputs
dft, time, tseries, xoutput, youtput
plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'Frequency (MHz)', ytitle = 'Power'
save, tseries, time, xoutput, youtput, filename = 'week_1_3_8_ratio4.sav'
end

pro restore_plot_3_8
;restore and plot frequency resolution
 !p.multi = [0,2,2]
 restore, 'week_1_3_8_ratio1.sav'
 plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'Frequency (MHz)', ytitle = 'Power'
 restore, 'week_1_3_8_ratio2.sav'
 plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'Frequency (MHz)', ytitle = 'Power'
 restore, 'week_1_3_8_ratio3.sav'
 plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'Frequency (MHz)', ytitle = 'Power'
 restore, 'week_1_3_8_ratio4.sav'
 plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'Frequency (MHz)', ytitle = 'Power'
end
