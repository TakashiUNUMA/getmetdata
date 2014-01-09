#
# README for getmetdata repository
#
# original file coded by Takashi Unuma, Kyoto Univ.
# Last modified: 2014/01/09
#

0. ディレクトリツリーは以下の通りです。
.
|-- README.txt # このファイル
|
|-- amedas
|   |-- amedas10_manual.csh       # アメダスデータ 取得用スクリプト
|   |-- station_list_r.txt        # アメダス地点リスト (雨量のみ)
|   `-- station_list_rtw.txt      # 気象官署地点リスト (雨量、気温、風向風速)
|
|-- jmagpv
|   `-- get_jmagpv_from_rish.csh  # JMAGPV 取得用スクリプト
|
|-- jra
|   `-- get_jra_from_jmaftp.csh   # JRA 取得用スクリプト
|
|-- ncep
|   `-- get_ncepfnl_from_ncar.csh # NCEP 最終解析値 取得用スクリプト
|
`-- devel                         # 開発中のスクリプト
    |-- get_jra55_ccs.sh
    |-- jcdas_lftp.sh
    |-- satelite
    `-- sounding
        |-- get_jma.sh
        |-- get_wyoming.sh
        |-- loop.sh
        `-- my_sites.txt


1. 使用方法
 使用する場合には、以下のようにコマンドラインにて実行します。

 $ csh [script] YYYYMMDDHH

    YYYY: 年4桁
      MM: 月2桁
      DD: 日2桁
      HH: 時2桁


 例: 気象庁GPVデータの取得

  $ csh get_jmagpv_from_rish.csh 2012081321

    デフォルトではMSMの気圧面データ(GRIB2形式)を取得します。
    GSMを取得したい場合は、スクリプト内の FILETYPE を変更して下さい。
    現段階では、以下の FILETYPE を用意しています。
     # CWM
     set FILETIPE = CWM_GPV_Rjp_Gll0p05deg_FD0000-0300_grib2 # 波浪モデル？
     # JMA-GSM
     set FILETYPE = GSM_GPV_Rgl_FD0000_grib2                 # 全球モデル
     set FILETYPE = GSM_GPV_Rjp_L-pall_FD0000-0312_grib2     # 日本域GSMのP面
     set FILETYPE = GSM_GPV_Rjp_Lsurf_FD0000-0312_grib2      # 日本域GMSのS面
     # JMA-MSM
     set FILETYPE = MSM_GPV_Rjp_L-pall_FH00-15_grib2         # 日本域MSMのP面
     set FILETYPE = MSM_GPV_Rjp_Lsurf_FH00-15_grib2          # 日本域MSMのS面



 質問・コメント等ありましたら kijima.m.u at gmail.com までお知らせください。
 at は @ に直してお送り下さい。

#
# end of file
#
