module Words
  module Frequencies
    module Bigrams

  def bigram_frequencies
    {
      'th' => 1.52,              
      'he' => 1.28,              
      'in' => 0.94,              
      'er' => 0.94,              
      'an' => 0.82,              
      're' => 0.68,              
      'nd' => 0.63,              
      'at' => 0.59,              
      'on' => 0.57,              
      'nt' => 0.56,              
      'ha' => 0.56,              
      'es' => 0.56,              
      'st' => 0.55,              
      'en' => 0.55,
      'ed' => 0.53,
      'to' => 0.52,
      'it' => 0.50,
      'ou' => 0.50,
      'ea' => 0.47,
      'hi' => 0.46,
      'is' => 0.46,
      'or' => 0.43,
      'ti' => 0.34,
      'as' => 0.33,
      'te' => 0.27,
      'et' => 0.19,
      'ng' => 0.18,
      'of' => 0.16,
      'al' => 0.09,
      'de' => 0.09,
      'se' => 0.08,
      'le' => 0.08,
      'sa' => 0.06,
      'si' => 0.05,
      'ar' => 0.04,
      've' => 0.04,
      'ra' => 0.04,
      'ld' => 0.02,
      'ur' => 0.02 
    }
  end

  # hopefully from some sufficiently large corpus...
  def full_bigram_counts
    {
'TH' => 116997844,
'HE' => 100689263,
'IN' => 87674002,
'ER' => 77134382,
'AN' => 69775179,
'RE' => 60923600,
'ES' => 57070453,
'ON' => 56915252,
'ST' => 54018399,
'NT' => 50701084,
'EN' => 48991276,
'AT' => 48274564,
'ED' => 46647960,
'ND' => 46194306,
'TO' => 46115188,
'OR' => 45725191,
'EA' => 43329810,
'TI' => 42888666,
'AR' => 42353262,
'TE' => 42295813,
'NG' => 38567365,
'AL' => 38211584,
'IT' => 37938534,
'AS' => 37773878,
'IS' => 37349981,
'HA' => 35971841,
'ET' => 32872552,
'SE' => 31532272,
'OU' => 31112284,
'OF' => 30540904,
'LE' => 30383262,
'SA' => 30080131,
'VE' => 29320973,
'RO' => 29230770,
'RA' => 28645577,
'RI' => 27634643,
'HI' => 27495342,
'NE' => 27331675,
'ME' => 27237733,
'DE' => 27029835,
'CO' => 26737101,
'TA' => 26147593,
'EC' => 25775798,
'SI' => 25758841,
'LL' => 24636875,
'SO' => 23903631,
'NA' => 23547524,
'LI' => 23291169,
'LA' => 23178317,
'EL' => 23092248,
'MA' => 21828378,
'DI' => 21673998,
'IC' => 21468412,
'RT' => 21456059,
'NS' => 21306421,
'RS' => 21237259,
'IO' => 21210160,
'OM' => 21066156,
'CH' => 20132750,
'OT' => 20088048,
'CA' => 19930754,
'CE' => 19803619,
'HO' => 19729026,
'BE' => 19468489,
'TT' => 19367472,
'FO' => 18923772,
'TS' => 18922522,
'SS' => 18915696,
'NO' => 18894111,
'EE' => 18497942,
'EM' => 18145294,
'AC' => 17904683,
'IL' => 17877600,
'DA' => 17584055,
'NI' => 17452104,
'UR' => 17341717,
'WA' => 16838794,
'SH' => 16773127,
'EI' => 16026915,
'AM' => 15975981,
'TR' => 15821226,
'DT' => 15759673,
'US' => 15699353,
'LO' => 15596310,
'PE' => 15573318,
'UN' => 15237699,
'NC' => 15214623,
'WI' => 15213018,
'UT' => 15137169,
'AD' => 14877234,
'EW' => 14776406,
'OW' => 14610429,
'GE' => 14425023,
'EP' => 14024377,
'AI' => 13974919,
'LY' => 13742031,
'OL' => 13726491,
'FT' => 13696078,
'OS' => 13596265,
'EO' => 13524186,
'EF' => 13252227,
'PR' => 13191182,
'WE' => 13185116,
'DO' => 13120322,
'MO' => 12950768,
'ID' => 12896787,
'IE' => 12505546,
'MI' => 12168944,
'PA' => 12068709,
'FI' => 11993833,
'PO' => 11917535,
'CT' => 11888752,
'WH' => 11852909,
'IR' => 11681353,
'AY' => 11523416,
'GA' => 11239788,
'SC' => 10800636,
'KE' => 10650670,
'EV' => 10574011,
'SP' => 10570626,
'IM' => 10544422,
'OP' => 10459455,
'DS' => 10429887,
'LD' => 10245579,
'UL' => 10173468,
'OO' => 10168856,
'SU' => 10031005,
'IA' => 10002012,
'GH' => 9880399,
'PL' => 9812226,
'EB' => 9738798,
'IG' => 9530574,
'VI' => 9380037,
'IV' => 9129232,
'WO' => 9106647,
'YO' => 9088497,
'RD' => 9025637,
'TW' => 8910254,
'BA' => 8867461,
'AG' => 8809266,
'RY' => 8788539,
'AB' => 8775582,
'LS' => 8675452,
'SW' => 8673234,
'AP' => 8553911,
'FE' => 8529289,
'TU' => 8477495,
'CI' => 8446084,
'FA' => 8357929,
'HT' => 8351551,
'FR' => 8339376,
'AV' => 8288885,
'EG' => 8286463,
'GO' => 8188708,
'BO' => 8172395,
'BU' => 8113271,
'TY' => 8008918,
'MP' => 7835172,
'OC' => 7646952,
'OD' => 7610214,
'EH' => 7559141,
'YS' => 7539621,
'EY' => 7528342,
'RM' => 7377989,
'OV' => 7350014,
'GT' => 7347990,
'YA' => 7239548,
'CK' => 7205091,
'GI' => 7103140,
'RN' => 7064635,
'GR' => 6989963,
'RC' => 6974063,
'BL' => 6941044,
'LT' => 6817273,
'YT' => 6714151,
'OA' => 6554221,
'YE' => 6499305,
'OB' => 6212512,
'DB' => 6106719,
'FF' => 6085519,
'SF' => 6073995,
'RR' => 5896212,
'DU' => 5861311,
'KI' => 5814357,
'UC' => 5742385,
'IF' => 5740414,
'AF' => 5702567,
'DR' => 5701879,
'CL' => 5683204,
'EX' => 5649363,
'SM' => 5580755,
'PI' => 5559210,
'SB' => 5553684,
'CR' => 5514347,
'TL' => 5403137,
'OI' => 5336616,
'RU' => 5330557,
'UP' => 5306948,
'BY' => 5232074,
'TC' => 5196817,
'NN' => 5180899,
'AK' => 5137311,
'SL' => 4965012,
'NF' => 4950333,
'UE' => 4927837,
'DW' => 4906814,
'AU' => 4884168,
'PP' => 4873393,
'UG' => 4832325,
'RL' => 4803246,
'RG' => 4645938,
'BR' => 4621080,
'CU' => 4604045,
'UA' => 4589997,
'DH' => 4585765,
'RK' => 4491400,
'YI' => 4461214,
'LU' => 4402940,
'UM' => 4389720,
'BI' => 4356462,
'NY' => 4343290,
'NW' => 4215967,
'QU' => 4169424,
'OG' => 4163126,
'SN' => 4157990,
'MB' => 4121764,
'VA' => 4111375,
'DF' => 4033878,
'DD' => 4001275,
'MS' => 3922855,
'GS' => 3920675,
'AW' => 3918960,
'NH' => 3915410,
'PU' => 3858148,
'HR' => 3843001,
'SD' => 3842250,
'TB' => 3815459,
'PT' => 3812475,
'NM' => 3796928,
'DC' => 3782481,
'GU' => 3768430,
'TM' => 3759861,
'MU' => 3755834,
'NU' => 3732602,
'MM' => 3730508,
'NL' => 3692985,
'EU' => 3674130,
'WN' => 3649615,
'NB' => 3602692,
'RP' => 3588188,
'DM' => 3544905,
'SR' => 3513808,
'UD' => 3499535,
'UI' => 3481482,
'RF' => 3436232,
'OK' => 3397570,
'YW' => 3379064,
'TF' => 3368452,
'IP' => 3348621,
'RW' => 3348005,
'RB' => 3346212,
'OH' => 3254659,
'KS' => 3227333,
'DP' => 3145043,
'FU' => 3138900,
'YC' => 3128053,
'TP' => 3070427,
'MT' => 3055946,
'DL' => 3050945,
'NK' => 3043200,
'CC' => 3026492,
'UB' => 2990868,
'RH' => 2968706,
'NP' => 2968126,
'JU' => 2924815,
'FL' => 2890839,
'DN' => 2840522,
'KA' => 2833038,
'PH' => 2825344,
'HU' => 2771830,
'JO' => 2721345,
'LF' => 2702522,
'YB' => 2696786,
'RV' => 2692445,
'OE' => 2616308,
'IB' => 2598444,
'IK' => 2585124,
'YP' => 2581863,
'GL' => 2576787,
'LP' => 2543957,
'YM' => 2516273,
'LB' => 2463693,
'HS' => 2462026,
'DG' => 2442139,
'GN' => 2426429,
'EK' => 2411639,
'NR' => 2393580,
'PS' => 2377036,
'TD' => 2346516,
'LC' => 2328063,
'SK' => 2321888,
'YF' => 2305244,
'YH' => 2291273,
'VO' => 2253292,
'AH' => 2225270,
'DY' => 2218040,
'LM' => 2216514,
'SY' => 2214270,
'NV' => 2194534,
'YD' => 2122337,
'FS' => 2047416,
'SG' => 2043770,
'YR' => 2021939,
'YL' => 2013939,
'WS' => 1988727,
'MY' => 1949129,
'OY' => 1932892,
'KN' => 1903836,
'IZ' => 1865802,
'XP' => 1840696,
'LW' => 1836811,
'TN' => 1782119,
'KO' => 1758001,
'AA' => 1721143,
'JA' => 1712763,
'ZE' => 1709871,
'FC' => 1570791,
'GW' => 1567991,
'TG' => 1530045,
'XT' => 1509969,
'FH' => 1507604,
'LR' => 1505092,
'JE' => 1487348,
'YN' => 1485655,
'GG' => 1468286,
'GF' => 1465290,
'EQ' => 1461436,
'HY' => 1446451,
'KT' => 1443985,
'HC' => 1441057,
'BS' => 1409672,
'HW' => 1403223,
'HN' => 1383958,
'CS' => 1381608,
'HM' => 1353001,
'NJ' => 1342735,
'HH' => 1329998,
'WT' => 1301293,
'GC' => 1299541,
'LH' => 1274048,
'EJ' => 1256993,
'FM' => 1251312,
'DV' => 1238565,
'LV' => 1238287,
'WR' => 1226755,
'GP' => 1215204,
'FP' => 1199845,
'GB' => 1184377,
'GM' => 1178511,
'HL' => 1169468,
'LK' => 1164186,
'CY' => 1145316,
'MC' => 1101727,
'YG' => 1049082,
'XI' => 1024736,
'HB' => 1014004,
'FW' => 1005903,
'GY' => 979804,
'HP' => 978649,
'MW' => 937621,
'PM' => 931225,
'ZA' => 929119,
'LG' => 926472,
'IW' => 922059,
'XA' => 904148,
'FB' => 888155,
'SV' => 882083,
'GD' => 879792,
'IX' => 879360,
'AJ' => 870262,
'KL' => 846309,
'HF' => 834284,
'HD' => 828755,
'AE' => 815963,
'SQ' => 800346,
'DJ' => 799366,
'FY' => 789961,
'AZ' => 768359,
'LN' => 752316,
'AO' => 749566,
'FD' => 748027,
'KW' => 719633,
'MF' => 715087,
'MH' => 710864,
'SJ' => 704442,
'UF' => 701892,
'TV' => 698150,
'XC' => 697995,
'YU' => 695512,
'BB' => 689158,
'WW' => 674610,
'OJ' => 661082,
'AX' => 660826,
'MR' => 660619,
'WL' => 657782,
'XE' => 653947,
'KH' => 650095,
'OX' => 650078,
'UO' => 649906,
'ZI' => 644035,
'FG' => 637758,
'IH' => 610683,
'TK' => 610333,
'II' => 607124,
'IU' => 576683,
'TJ' => 559473,
'MN' => 558397,
'WY' => 553647,
'KY' => 553296,
'KF' => 537342,
'FN' => 534362,
'UY' => 531960,
'PW' => 530411,
'DK' => 525744,
'RJ' => 518157,
'UK' => 514873,
'KR' => 507020,
'KU' => 506618,
'WM' => 505687,
'KM' => 485617,
'MD' => 481126,
'ML' => 478528,
'EZ' => 465466,
'KB' => 457860,
'WC' => 448394,
'WD' => 432646,
'HG' => 429607,
'BT' => 428276,
'ZO' => 424016,
'KC' => 420017,
'PF' => 418168,
'YV' => 411487,
'PC' => 400308,
'PY' => 396147,
'WB' => 394820,
'YK' => 391953,
'CP' => 382923,
'YJ' => 378679,
'KP' => 375653,
'PB' => 369336,
'CD' => 358435,
'JI' => 357577,
'UW' => 352732,
'UH' => 339341,
'WF' => 336213,
'YY' => 332973,
'WP' => 321746,
'BC' => 320380,
'AQ' => 315068,
'CB' => 298053,
'IQ' => 291635,
'CM' => 285942,
'MG' => 285133,
'DQ' => 283314,
'BJ' => 282608,
'TZ' => 280007,
'KD' => 277982,
'PD' => 273162,
'FJ' => 269865,
'CF' => 267630,
'NZ' => 266461,
'CW' => 257253,
'FV' => 244685,
'VY' => 233082,
'FK' => 228905,
'OZ' => 228556,
'ZZ' => 221275,
'IJ' => 219128,
'LJ' => 218362,
'NQ' => 217422,
'UV' => 212051,
'XO' => 211173,
'PG' => 211133,
'HK' => 210385,
'KG' => 209266,
'VS' => 204093,
'HV' => 197539,
'BM' => 191807,
'HJ' => 189906,
'CN' => 188046,
'GV' => 186777,
'CG' => 181590,
'WU' => 180884,
'GJ' => 176947,
'XH' => 166599,
'GK' => 163830,
'TQ' => 159111,
'CQ' => 157546,
'RQ' => 156933,
'BH' => 154489,
'XS' => 154347,
'UZ' => 153736,
'WK' => 148964,
'XU' => 147533,
'UX' => 144814,
'BD' => 141752,
'BW' => 140189,
'WG' => 139890,
'MV' => 136314,
'MJ' => 134263,
'PN' => 131645,
'XM' => 127492,
'OQ' => 122677,
'BV' => 120081,
'XW' => 119322,
'KK' => 118811,
'BP' => 115161,
'ZU' => 113538,
'RZ' => 113432,
'XF' => 113031,
'MK' => 111041,
'ZH' => 107639,
'BN' => 106125,
'ZY' => 105871,
'HQ' => 101241,
'WJ' => 99435,
'IY' => 98361,
'DZ' => 98038,
'VR' => 96416,
'ZS' => 94993,
'XY' => 94329,
'CV' => 94224,
'XB' => 94041,
'XR' => 90046,
'UJ' => 88168,
'YQ' => 87953,
'VD' => 85611,
'PK' => 83017,
'VU' => 82830,
'JR' => 80471,
'ZL' => 80039,
'SZ' => 79840,
'YZ' => 78281,
'LQ' => 77148,
'KJ' => 76816,
'BF' => 75352,
'NX' => 74844,
'QA' => 73527,
'QI' => 73387,
'KV' => 73184,
'ZW' => 68865,
'WV' => 63930,
'UU' => 63043,
'VT' => 62912,
'VP' => 62577,
'XD' => 60101,
'GQ' => 59750,
'XL' => 59585,
'VC' => 59024,
'CZ' => 57914,
'LZ' => 57314,
'ZT' => 56955,
'WZ' => 52836,
'SX' => 50975,
'ZB' => 50652,
'VL' => 49032,
'PV' => 48105,
'FQ' => 47504,
'PJ' => 47043,
'ZM' => 46034,
'VW' => 45608,
'CJ' => 41526,
'ZC' => 41037,
'BG' => 40516,
'JS' => 39326,
'XG' => 39289,
'RX' => 38654,
'HZ' => 37066,
'XX' => 35052,
'VM' => 35024,
'XN' => 34734,
'QW' => 34669,
'JP' => 34520,
'VN' => 33082,
'ZD' => 32906,
'ZR' => 32685,
'FZ' => 31186,
'XV' => 31117,
'ZP' => 30389,
'VH' => 30203,
'VB' => 29192,
'ZF' => 28658,
'GZ' => 28514,
'TX' => 28156,
'VF' => 28090,
'DX' => 27413,
'QB' => 27307,
'BK' => 26993,
'ZG' => 26369,
'VG' => 25585,
'JC' => 24770,
'ZK' => 24262,
'ZN' => 24241,
'UQ' => 23386,
'JM' => 22338,
'VV' => 22329,
'JD' => 21903,
'MQ' => 21358,
'JH' => 20960,
'QS' => 20847,
'JT' => 20408,
'JB' => 19380,
'FX' => 19313,
'PQ' => 18607,
'MZ' => 18271,
'YX' => 16945,
'QT' => 16914,
'WQ' => 16245,
'JJ' => 16085,
'JW' => 16083,
'LX' => 15467,
'GX' => 14778,
'JN' => 14452,
'ZV' => 14339,
'MX' => 14250,
'JK' => 13967,
'KQ' => 13905,
'XK' => 13651,
'JF' => 12640,
'QM' => 12315,
'QH' => 12273,
'JL' => 12149,
'JG' => 12023,
'VK' => 11469,
'VJ' => 11432,
'KZ' => 11192,
'QC' => 10667,
'XJ' => 10629,
'PZ' => 9697,
'QL' => 9603,
'QO' => 9394,
'JV' => 8925,
'QF' => 8778,
'QD' => 8678,
'BZ' => 8132,
'HX' => 7526,
'ZJ' => 7167,
'PX' => 6814,
'QP' => 6062,
'QE' => 6020,
'QR' => 5975,
'ZQ' => 5773,
'JY' => 5723,
'BQ' => 5513,
'XQ' => 5416,
'CX' => 5300,
'KX' => 5083,
'WX' => 4678,
'QY' => 4557,
'QV' => 4212,
'QN' => 3808,
'VX' => 3192,
'BX' => 3021,
'JZ' => 2859,
'VZ' => 2633,
'QG' => 2567,
'QQ' => 2499,
'ZX' => 2463,
'XZ' => 2082,
'QK' => 2023,
'VQ' => 1488,
'QJ' => 1342,
'QX' => 765,
'JX' => 747,
'JQ' => 722,
'QZ' => 280
}
  end

    end
  end
end
