From: john.p.donnelly@oracle.com (John Donnelly)
Date: Wed, 24 Jul 2019 09:51:36 -0500
Subject: nvme statistics :  iostat vs  sar 
Message-ID: <D4F9A3CB-489A-4946-ADF2-C7C17A21E076@oracle.com>

Hi,

I noticed  nvme I/O  does not appear  in sar disk data (-d ) ,  but it does appear with  sar block (-b)  and iostat.

Is this expected ?

sar -d 


07:49:47 AM       DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util
07:49:49 AM   dev8-32      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
07:49:49 AM   dev8-16      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
07:49:49 AM   dev8-48      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
07:49:49 AM    dev8-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
07:49:49 AM  dev259-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
07:49:49 AM  dev252-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
07:49:49 AM  dev252-1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
07:49:49 AM  dev252-2      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00



sar -b   2 2 

07:47:35 AM       tps      rtps      wtps   bread/s   bwrtn/s
07:47:37 AM    792.50    395.50    397.00  25312.00  25316.00
07:47:39 AM    796.50    394.00    402.50  25216.00  25760.00
Average:       794.50    394.75    399.75  25264.00  25538.00



iostat:


avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.05    0.00    0.33    0.33    0.00   99.29

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdc               0.07         2.43         0.00       6295          0
sdb               0.07         2.43         0.00       6295          0
sdd               0.07         2.43         0.00       6295          0
sda               6.07       117.40        21.34     303739      55202
nvme0n1           0.48        15.18         0.00      39283          0
dm-0              5.60       103.39        19.45     267499      50321
dm-1              0.03         0.95         0.00       2460          0
dm-2              0.23         1.40         0.79       3617       2048
nvme1c1n1       284.39      3011.48      2814.17    7791448    7280960
nvme1c1n2        96.70       756.17       750.80    1956388    1942520
nvme1c3n2         0.00         0.00         0.00          0          0
nvme1c2n2        60.15       962.11       962.63    2489220    2490560
nvme1c4n2         0.00         0.00         0.00          0          0
