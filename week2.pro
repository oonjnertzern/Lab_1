;____________________________________________________________
;
;                           Week 2
;____________________________________________________________

function getpico
  GETPICO, '1V', 1, 1, tseries, vmult=vmult
  return, tseries
end

pro get_5_1_add
  N = 2048.
  v_sample = 62.5e6
  tseries = getpico()
  time  = (findgen(N)/v_sample)
  plot, time*1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
  save, tseries, time,  filename = 'week_2_5_1_add.sav'
end

pro restore_5_1_add
  N = 2048.
  restore, 'week_2_5_1_add.sav'
  plot, time*1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
end

pro get_5_1_subtract
  N = 2048.
  v_sample = 62.5e6
  tseries = getpico()
  time  = (findgen(N)/v_sample)
  plot, time* 1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time - delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
  save, tseries, time,  filename = 'week_2_5_1_subtract.sav'
end

pro restore_5_1_subtract
  N = 2048.
  restore, 'week_2_5_1_subtract.sav'
  plot, time* 1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time - delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
end

pro get_5_1_ft_add
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

pro get_5_1_ft_subtract
  !p.multi = [0,1,2]
  N = 2048.
  v_sample = 62.5e6
  restore, 'week_2_5_1_subtract.sav'
  xinput = time
  yinput = tseries
  xoutput = ((findgen(N) - (N/2.))*v_sample/N)
  dft, xinput, yinput, xoutput, youtput
  power = (abs(youtput))^2
  plot, xoutput/1e6, youtput, psym = -4, charsize = 1.5, title = 'DFT of + delta v', xtitle = 'frequency (MHz)', ytitle = 'real values'
  plot, xoutput/1e6, power, psym = -4, charsize = 1.5, title = 'Power Spectrum of + delta v', xtitle = 'frequency (MHz)', ytitle = 'power', xrange = [-5,5]
  save, xinput, xoutput, yinput, youtput, power, filename = 'week_2_5_1_ft_subtract.sav'
end

pro get_5_1_ift_add
  N = 2048.
  !p.multi = [0,1,2]
  restore, 'week_2_5_1_add.sav'
  plot, time*1e6, tseries[100:N+100-1], psym = -4, charsize = 1.5, title = 'voltage vs. time + delta v', xtitle = 'time (microsec)', ytitle = 'voltage (V)'
  restore, 'week_2_5_1_ft_add.sav'

  youtput1 = youtput
  for x = 0, n_elements(xoutput)-1 do begin
     if abs(xoutput[x]) GT (2e6) then begin
        youtput1[x] = 0
     endif
  endfor

;  plot, xoutput/1e6, (abs(youtput1))^2, psym = -4, xrange = [-1,1]
  dft, xoutput, youtput1, time, filtered_y, /inverse
  plot, time*1e6, filtered_y, psym = -4


  save, time, filtered_y, filename = 'week_2_5_1_ift_add.sav'
end

pro restore_5_1_ift_add
  restore, 'week_2_5_1_ift_add.sav'
  plot, time*1e6, filtered_y, psym = -4
end
