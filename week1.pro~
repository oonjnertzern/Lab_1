function time_3_2, N
  time = findgen(16000)/(6.25e6)
  return, time[0:N-1]
end

function tseries_3_2, D
  GETPICO, '1V', D, 1, tseries, vmult=vmult
  return, tseries[100:227]
end

pro change_frq, v_sig
 srs1_frq, v_sig
end

pro plot_3_2, a
  v_sample = 6.25e6
  v_sig = (a*0.1*(v_sample))
  ratio = a*0.1
  change_frq, v_sig
  tseries = tseries_3_2(10)
  time = time_3_2(128)*1e6
  plot, time, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal/v_sample = '+strcompress(string(ratio), /remove_all), ytitle = 'voltage (V)', xtitle = 'time (microseconds)'
  save, tseries, time, a, filename = 'week_1_3_2_'+strcompress(string(ratio), /remove_all)+'.sav'
end

pro restore_plot_3_2, a
  ratio = a*0.1
  restore, 'week_1_3_2_' + strcompress(string(ratio), /remove_all) +'.sav'
  plot, time, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'voltage (V)', xtitle = 'time (microseconds)'
end

pro plot_3_2_ft, a
  N=128.
  !p.multi = [0,1,2]
  v_sample = 6.25e6
  v_sig = (a*0.1*(v_sample))
  ratio = a*0.1
  change_frq, v_sig
  xinput = time_3_2(N) - ((N/2.)/(v_sample))
  yinput = tseries_3_2(10)
  xoutput = ((findgen(N)-(N/2.))*v_sample/N)
  dft,  xinput, yinput, xoutput, youtput
  youtput = (abs(youtput))^2
  plot, xoutput*1e-6, youtput, psym = -4, charsize = 1.5, title = 'Power Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'power', xtitle = 'frequency (MegaHz)'
  xoutput = xoutput * 1e-6
  save, xinput, yinput, xoutput, youtput, a, filename = 'week_1_3_2_ft_'+strcompress(string(ratio), /remove_all)+'.sav'
end

pro restore_plot_3_2_ft, a
  ratio = a *0.1
  restore, 'week_1_3_2_ft_'+strcompress(string(ratio), /remove_all)+'.sav'
  plot, xoutput, youtput, psym = -4, charsize = 1.5, title = 'Power Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'power', xtitle = 'frequency (MegaHz)'
end

pro plot_3_3_equal
  v_sig = 6.25e6
  v_sample = v_sig
  change_frq, v_sig
  tseries = tseries_3_2(10)
  time = time_3_2(128)*1e6
  plot, time, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal=v_sample', ytitle = 'voltage (V)', xtitle = 'time (microseconds)'
  save, tseries, time, filename = 'week_1_3_3_equal.sav'
end

pro restore_plot_3_3_equal
  restore, 'week_1_3_3_equal.sav'
  plot, time, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal=v_sample', ytitle = 'voltage (V)', xtitle = 'time (microseconds)'
end

pro plot_3_3_large
  change_frq, 30e6
  getpico, '1V', 400, 1, tseries
  time = time_3_2(128)*1e6
  plot, time, tseries[100:227], psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal/v_sample >> 1', ytitle = 'voltage (V)', xtitle = 'time (microseconds)'
  save, tseries, time, filename = 'week_1_3_3_large.sav'
end

pro restore_plot_3_3_large
  restore, 'week_1_3_3_large.sav'
  plot, time, tseries[100:227], psym = -4, charsize = 1.5, title = 'voltage vs. time for v_signal/v_sample >> 1', ytitle = 'voltage (V)', xtitle = 'time (microseconds)'
end

pro plot_3_4_vs, a
  N=128.
  !p.multi = [0,1,2]
  v_sample = 6.25e6
  v_sig = (a*0.1*(v_sample))
  ratio = a*0.1
  change_frq, v_sig
  xinput = time_3_2(N) - ((N/2.)/(6.25e6))
  yinput = tseries_3_2(10)
  xoutput = ((findgen(N)-(N/2.))*v_sample/N)
  dft,  xinput, yinput, xoutput, youtput
  plot, xoutput*1e-6, real_part(youtput), psym = -4, charsize = 1.5, title = 'Voltage Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'real values', xtitle = 'frequency (MegaHz)'
  plot, xoutput*1e-6, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Voltage Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'imaginary values', xtitle = 'frequency (MegaHz)'
  xoutput = xoutput*1e-6
  save, xinput, yinput, xoutput, youtput, filename = 'week_1_3_4_vs_'+strcompress(string(ratio), /remove_all)+'.sav'
end

pro restore_plot_3_4_vs, a
  !p.multi = [0,1,2]
  ratio = a*0.1
  restore, 'week_1_3_4_vs_'+strcompress(string(ratio), /remove_all)+'.sav'
  plot, xoutput, real_part(youtput), psym = -4, charsize = 1.5, title = 'Voltage Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'real values', xtitle = 'frequency (MegaHz)'
  plot, xoutput, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Voltage Spectrum for v_signal/v_sample = ' + strcompress(string(ratio), /remove_all), ytitle = 'imaginary values', xtitle = 'frequency (MegaHz)'
end

pro plot_3_5_triangle
  !p.multi = [0,1,2]
  N = 128.
  v_sample = (62.5e6)/6175
  change_frq, 1e5
  tseries = tseries_3_2(6175)
  time = findgen(16000)/v_sample
  xinput = time[0:127] - ((N/2.)/(v_sample))
  xoutput = ((findgen(N)-(N/2.))*v_sample/N)
  dft, xinput, tseries, xoutput, youtput
  plot, time[0:127], tseries, psym = -4, charsize = 1.5, xtitle = 'time (second)', ytitle = 'voltage (V)', title = 'voltage vs. time for triangle wave'
  plot, xoutput/1000, (abs(youtput))^2, psym = -4, charsize = 1.5, xtitle = 'frequency (kHz)', ytitle = 'power', title = 'Power Spectrum for Triangle Wave'
  save, xinput, tseries, xoutput, youtput, time, filename = 'week_1_3_5_triangle.sav'
end

pro restore_plot_3_5_triangle
  !p.multi = [0,1,2]
  restore, 'week_1_3_5_triangle.sav'
 plot, time[0:127], tseries, psym = -4, charsize = 1.5, xtitle = 'time (second)', ytitle = 'voltage (V)', title = 'voltage vs. time for triangle wave'
 plot, xoutput/1000, (abs(youtput))^2, psym = -4, charsize = 1.5, xtitle = 'frequency (kHz)', ytitle = 'power', title = 'Power Spectrum for Triangle Wave'
end

pro plot_3_5_square
  !p.multi = [0,1,2]
  N = 128.
  v_sample = (62.5e6)/6175
  change_frq, 1e5
  tseries = tseries_3_2(6175)
  time = findgen(16000)/v_sample
  xinput = time[0:127] - ((N/2.)/(v_sample))
  xoutput = ((findgen(N)-(N/2.))*v_sample/N)
  dft, xinput, tseries, xoutput, youtput
  plot, time[0:127], tseries, psym = -4, charsize = 1.5, xtitle = 'time (second)', ytitle = 'voltage (V)', title = 'voltage vs. time for square wave'
  plot, xoutput/1000, (abs(youtput))^2, psym = -4, charsize = 1.5, xtitle = 'frequency (kHz)', ytitle = 'power', title = 'Power Spectrum for Square Wave'
  save, xinput, tseries, xoutput, youtput, time, filename = 'week_1_3_5_square.sav'
end

pro restore_plot_3_5_square
 !p.multi = [0,1,2]
 restore, 'week_1_3_5_square.sav'
 plot, time[0:127], tseries, psym = -4, charsize = 1.5, xtitle = 'time (second)', ytitle = 'voltage (V)', title = 'voltage vs. time for square wave'
 plot, xoutput/1000, (abs(youtput))^2, psym = -4, charsize = 1.5, xtitle = 'frequency (kHz)', ytitle = 'power', title = 'Power Spectrum for Square Wave'
end

pro plot_3_6_square
  !p.multi = [0,3,2]
  N = 128.
  v_sample = (62.5e6)/6220
  change_frq, 1e5
  tseries = tseries_3_2(6220)
  time = findgen(16000)/v_sample
  xinput = time[0:127] - ((N/2.)/(v_sample))
  xoutput = ((findgen(N)-(N/2.))*v_sample/N)
  dft, xinput, tseries, xoutput, youtput
  plot, xinput, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for square wave', xtitle = 'time (second)', ytitle = 'voltage (V)'
  plot, xoutput/1000, real_part(youtput), psym = -4, charsize = 1.5, title = 'Real Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'real values'
  plot, xoutput/1000, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'imaginary values'

youtput1 = youtput


  for x = 0, n_elements(xoutput)-1 do begin
     if xoutput[x] GT 1000 OR xoutput[x] LT -1000 then begin
        youtput1[x] = 0
     endif
  endfor

  plot, xoutput/1000, real_part(youtput1), psym = -4, charsize = 1.5, title = 'Real Part of DFT Filtered', xtitle = 'frequency (kHz)', ytitle = 'real values'
  plot, xoutput/1000, imaginary(youtput1), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT Filtered', xtitle = 'frequency (kHz)', ytitle = 'imaginary values'

  dft, xoutput, youtput1, xinput, filtered_y, /inverse
  plot, xinput, filtered_y, psym = -4, charsize = 1.5, title = 'Fourier Filtered Square Wave', xtitle = 'time (second)', ytitle = 'voltage (V)'
  save, time, tseries, xinput, xoutput, youtput, filtered_y, youtput1, filename = 'week_1_3_6_square_wave.sav'
end

pro restore_plot_3_6_square
  !p.multi = [0,3,2]
  restore, 'week_1_3_6_square_wave.sav'
  plot, xinput*1e3, tseries, psym = -4, charsize = 2, title = 'voltage vs. time for square wave', xtitle = 'time (millisecond)', ytitle = 'voltage (V)'
  plot, xoutput/1000, real_part(youtput), psym = -4, charsize = 2, title = 'Real Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'real values'
  plot, xoutput/1000, imaginary(youtput), psym = -4, charsize = 2, title = 'Imaginary Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'imaginary values'
  plot, xoutput/1000, real_part(youtput1), psym = -4, charsize = 2, title = 'Real Part of DFT Filtered', xtitle = 'frequency (kHz)', ytitle = 'real values'
  plot, xoutput/1000, imaginary(youtput1), psym = -4, charsize = 2, title = 'Imaginary Part of DFT Filtered', xtitle = 'frequency (kHz)', ytitle = 'imaginary values'
  plot, xinput*1e3, filtered_y, psym = -4, charsize = 2, title = 'Fourier Filtered Square Wave', xtitle = 'time (millisecond)', ytitle = 'voltage'
end

pro plot_3_6_triangle
  !p.multi = [0,3,2]
  N = 128.
  v_sample = (62.5e6)/6220
  change_frq, 1e5
  tseries = tseries_3_2(6220)
  time = findgen(16000)/v_sample
  xinput = time[0:127] - ((N/2.)/(v_sample))
  xoutput = ((findgen(N)-(N/2.))*v_sample/N)
  dft, xinput, tseries, xoutput, youtput
  plot, xinput, tseries, psym = -4, charsize = 1.5, title = 'voltage vs. time for triangle wave', xtitle = 'time (second)', ytitle = 'voltage (V)'
  plot, xoutput/1000, real_part(youtput), psym = -4, charsize = 1.5, title = 'Real Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'real values'
  plot, xoutput/1000, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'imaginary values'

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
  !p.multi = [0,3,2]
  restore, 'week_1_3_6_triangle_wave.sav'
  plot, xinput*1e3, tseries, psym = -4, charsize = 2, title = 'voltage vs. time for triangle wave', xtitle = 'time (millisecond)', ytitle = 'voltage (V)'
  plot, xoutput/1000, real_part(youtput), psym = -4, charsize = 2, title = 'Real Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'real values'
  plot, xoutput/1000, imaginary(youtput), psym = -4, charsize = 2, title = 'Imaginary Part of DFT', xtitle = 'frequency (kHz)', ytitle = 'imaginary values'
  plot, xoutput/1000, real_part(youtput1), psym = -4, charsize = 2, title = 'Real Part of DFT Filtered', xtitle = 'frequency (kHz)', ytitle = 'real values'
  plot, xoutput/1000, imaginary(youtput1), psym = -4, charsize = 2, title = 'Imaginary Part of DFT Filtered', xtitle = 'frequency (kHz)', ytitle = 'imaginary values'
  plot, xinput*1e3, filtered_y, psym = -4, charsize = 2, title = 'Fourier Filtered Triangle Wave', xtitle = 'time (millisecond)', ytitle = 'voltage (V)'
end

pro plot_3_7
N = 1024.
D = 1
!p.multi = [0,2,2]
v_sample = (62.5) / float(D)
change_frq, 0.1*(62.5e6)
GETPICO, '1V', D, 1, tseries
tseries = tseries[100:1123]
time = findgen(1024)/(62.5) - ((N/2.)/v_sample)
plot, time, tseries, psym = -4, xrange = [-2,2], charsize = 1.5, title = 'voltage vs. time', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
xoutput = (findgen(N)-(N/2.))*(v_sample/N)
dft, time, tseries, xoutput, youtput
plot, xoutput, (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [2,10], yrange = [0,100]
plot, xoutput, real_part(youtput), psym = -4, charsize = 1.5, title = 'Real Part of DFT', xtitle = 'frequency (MHz)', ytitle = 'real values'
plot, xoutput, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT', xtitle = 'frequency (MHz)', ytitle = 'imaginary values'
save, tseries, time, xoutput, youtput, filename = 'week_1_3_7.sav'
end

pro restore_plot_3_7
 !p.multi = [0,2,2]
 restore, 'week_1_3_7.sav'
 plot, time, tseries, psym = -4, xrange = [-2,2], charsize = 1.5, title = 'voltage vs. time', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
 plot, xoutput, (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [2,10], yrange = [0,100]
 plot, xoutput, real_part(youtput), psym = -4, charsize = 1.5, title = 'Real Part of DFT', xtitle = 'frequency (MHz)', ytitle = 'real values'
 plot, xoutput, imaginary(youtput), psym = -4, charsize = 1.5, title = 'Imaginary Part of DFT', xtitle = 'frequency (MHz)', ytitle = 'imaginary values'
end

pro plot_3_8
!p.multi = [0,1,1]
D = 1
v_sample = 62.5e6 / D
N = 128.
getpico, '1V', D, 1,  tseries
time = (findgen(N) - (N/2.)) / v_sample
xoutput = (findgen(N) - (N/2.))*(v_sample/N)
dft, time, tseries, xoutput, youtput
plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'frequency (MHz)', ytitle = 'power'
save, tseries, time, xoutput, youtput, filename = 'week_1_3_8_ratio4.sav'
end

pro restore_plot_3_8
 !p.multi = [0,2,2]
 restore, 'week_1_3_8_ratio1.sav'
 plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'frequency (MHz)', ytitle = 'power'
 restore, 'week_1_3_8_ratio2.sav'
 plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'frequency (MHz)', ytitle = 'power'
 restore, 'week_1_3_8_ratio3.sav'
 plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'frequency (MHz)', ytitle = 'power'
 restore, 'week_1_3_8_ratio4.sav'
 plot, xoutput/(1e6), (abs(youtput))^2, psym = -4, charsize = 1.5, title = 'Power Spectrum', xtitle = 'frequency (MHz)', ytitle = 'power'
end
