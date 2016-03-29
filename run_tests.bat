
call mzn-gecode clrp_v1.mzn custom\t1.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_t1.result"
call mzn-gecode clrp_v1.mzn custom\t2.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_t2.result"
call mzn-gecode clrp_v1.mzn custom\t3.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_t3.result"

call mzn-gecode clrp_v1.mzn prodhon\coord20-5-1.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_coord20-5-1.result"
call mzn-gecode clrp_v1.mzn prodhon\coord20-5-2.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_coord20-5-2.result"
call mzn-gecode clrp_v1.mzn prodhon\coord50-5-3.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_coord50-5-3.result"


call mzn-gecode clrp_v1_opt1.mzn custom\t1.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt1_t1.result"
call mzn-gecode clrp_v1_opt1.mzn custom\t2.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt1_t2.result"
call mzn-gecode clrp_v1_opt1.mzn custom\t3.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt1_t3.result"

call mzn-gecode clrp_v1_opt1.mzn prodhon\coord20-5-1.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt1_coord20-5-1.result"
call mzn-gecode clrp_v1_opt1.mzn prodhon\coord20-5-2.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt1_coord20-5-2.result"
call mzn-gecode clrp_v1_opt1.mzn prodhon\coord50-5-3.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt1_coord50-5-3.result"


call mzn-gecode clrp_v1_opt2.mzn custom\t1.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt2_t1.result"
call mzn-gecode clrp_v1_opt2.mzn custom\t2.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt2_t2.result"
call mzn-gecode clrp_v1_opt2.mzn custom\t3.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt2_t3.result"

call mzn-gecode clrp_v1_opt2.mzn prodhon\coord20-5-1.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt2_coord20-5-1.result"
call mzn-gecode clrp_v1_opt2.mzn prodhon\coord20-5-2.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt2_coord20-5-2.result"
call mzn-gecode clrp_v1_opt2.mzn prodhon\coord50-5-3.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_opt2_coord50-5-3.result"


call mzn-gecode clrp_v1_int.mzn custom\t1.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_int_t1.result"
call mzn-gecode clrp_v1_int.mzn custom\t2.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_int_t2.result"
call mzn-gecode clrp_v1_int.mzn custom\t3.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_int_t3.result"

call mzn-gecode clrp_v1_int.mzn prodhon\coord20-5-1.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_int_coord20-5-1.result"
call mzn-gecode clrp_v1_int.mzn prodhon\coord20-5-2.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_int_coord20-5-2.result"
call mzn-gecode clrp_v1_int.mzn prodhon\coord50-5-3.dzn --fzn-flags "-time 900000" -a -s -p 8 -o "clrp_v1_int_coord50-5-3.result"
