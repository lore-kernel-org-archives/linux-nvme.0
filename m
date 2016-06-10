From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Fri, 10 Jun 2016 11:03:43 +0200 (CEST)
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <009601d1c266$5820eaa0$0862bfe0$@opengridcomputing.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <575973A4.9080001@lightbits.io>
 <006501d1c258$835dacc0$8a190640$@opengridcomputing.com>
 <006a01d1c25a$5b23c0d0$116b4270$@opengridcomputing.com>
 <007501d1c25b$574f43c0$05edcb40$@opengridcomputing.com>
 <1118189510.33005805.1465484651257.JavaMail.zimbra@kalray.eu>
 <009201d1c265$41fead30$c5fc0790$@opengridcomputing.com>
 <009601d1c266$5820eaa0$0862bfe0$@opengridcomputing.com>
Message-ID: <135617120.33923984.1465549423989.JavaMail.zimbra@kalray.eu>

----- Le 9 Juin 16, ? 17:48, Steve Wise swise at opengridcomputing.com a ?crit :

>> 
>> 
>> Thanks Marta.  That card has less memory than the T580-CR.  I'm checking with
>> Chelsio on the details.  The "-SO" might mean a mem-free card.
>> 
>> Also, can you email me the output of 'cat
> /sys/kernel/debug/cxgb4/blah/meminfo'?

Here it is:
# cat /sys/kernel/debug/cxgb4/0000\:09\:00.4/meminfo 
EDC0:           0x0-0x2fffff [3.00 MiB]
EDC1:           0x300000-0x5fffff [3.00 MiB]

RQUDP region:   0xffffffff-0xfffffffe [0 B]
DBQ contexts:   0x27fa80-0x28ba7f [48.0 KiB]
IMSG contexts:  0x28ba80-0x297a7f [48.0 KiB]
FLM cache:      0x297a80-0x2d9a7f [264 KiB]
ULPTX state:    0x2d9a80-0x2d9e3f [960 B]
ULPRX state:    0x2d9e40-0x2d9e7f [64.0 B]
Timers:         0x2d9e80-0x2e7e7f [56.0 KiB]
TCBs:           0x2e7e80-0x327fff [256 KiB]
Tx payload:     0x328000-0x3e7fff [768 KiB]
Rx payload:     0x3e8000-0x507fff [1.13 MiB]
Pstructs:       0x508000-0x50afff [12.0 KiB]
Rx FL:          0x50b000-0x50b0bf [192 B]
Tx FL:          0x50b0c0-0x50b13f [128 B]
Pstruct FL:     0x50b140-0x50b33f [512 B]
TDDP region:    0x50b340-0x537b3f [178 KiB]
iSCSI region:   0x537b40-0x557b3f [128 KiB]
TPT region:     0x557b40-0x56df3f [89.0 KiB]
STAG region:    0x557b40-0x56df3f [89.0 KiB]
TXPBL region:   0x56df40-0x5a593f [223 KiB]
PBL region:     0x56df40-0x5a593f [223 KiB]
RQ region:      0x5a5940-0x5f373f [312 KiB]

uP RAM:         0x0-0xffffffff [4.00 GiB]
uP Extmem2:     0x0-0xffffffff [4.00 GiB]

72 Rx pages of size 16KiB for 1 channels
48 Tx pages of size 16KiB for 2 channels
192 p-structs

Port 0 using 2 pages out of 432 allocated
Port 1 using 2 pages out of 432 allocated
Port 2 using 2 pages out of 432 allocated
Port 3 using 2 pages out of 432 allocated
Loopback 0 using 0 pages out of 144 allocated
Loopback 1 using 0 pages out of 144 allocated
Loopback 2 using 0 pages out of 144 allocated
Loopback 3 using 0 pages out of 144 allocated


Marta
