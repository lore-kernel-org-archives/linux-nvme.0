From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 29 May 2018 16:08:08 +0300
Subject: Bug report: critical medium error during 8k local nvme write
Message-ID: <93935ee4-52eb-a514-1b46-21c0f3b6e31d@mellanox.com>

hi Keith,
I want to report on a bug I've seen in my local nvme drive configured to 
run with metadata format using:

#nvme format /dev/nvme0n1 --namespace-id=1 --lbaf=1 --pi=1 --pil=0 --ms=1 -r


#nvme list
Node             SN                   Model 
       Namespace Usage                      Format           FW Rev
---------------- -------------------- 
---------------------------------------- --------- 
-------------------------- ---------------- --------
/dev/nvme0n1     PHFT620400WS400BGN   INTEL SSDPEDMD400G4 
       1         400.09  GB / 400.09  GB    512   B +  8 B   8DV10171


I run
#fio --group_reporting --rw=randwrite --bs=8k --numjobs=16 --iodepth=128 
--runtime=10 --time_based --loops=1 --ioengine=libaio --direct=1 
--invalidate=1 --randrepeat=1 --norandommap --exitall --name 
task_nvme0n1 --filename=/dev/nvme0n1

and got the following error:

[Tue May 29 13:03:27 2018] nvme nvme0: async event result 00010400
[Tue May 29 13:03:27 2018] print_req_error: 109 callbacks suppressed
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 578479568
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 667255648
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 479641952
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 442707392
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 760990064
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 180216672
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 565387648
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 153238832
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 762160112
[Tue May 29 13:03:27 2018] print_req_error: critical medium error, dev 
nvme0n1, sector 368248592

#nvme error-log /dev/nvme0n1 -e 2
Error Log Entries for device:nvme0n1 entries:2
.................
  Entry[ 0]
.................
error_count  : 64
sqid         : 14
cmdid        : 0x30f
status_field : 0x4500(WRITE_FAULT: The write data could not be committed 
to the media)
parm_err_loc : 0
lba          : 0xffffffff
nsid         : 0x1
vs           : 0
cs           : 0
.................
  Entry[ 1]
.................
error_count  : 63
sqid         : 14
cmdid        : 0x30e
status_field : 0x4500(WRITE_FAULT: The write data could not be committed 
to the media)
parm_err_loc : 0
lba          : 0xffffffff
nsid         : 0x1
vs           : 0
cs           : 0
.................


any idea what can cause this error ?

BTW:

for bs in 1k 2k 4k 16k 32k 64k 128k 256k ; do echo $bs && taskset -c 
0-11 fio --group_reporting --rw=randwrite --bs=$bs --numjobs=16 
--iodepth=128 --runtime=10 --time_based --loops=1 --ioengine=libaio 
--direct=1 --invalidate=1 --randrepeat=1 --norandommap --exitall --name 
task_nvme0n1 --filename=/dev/nvme0n1; done


works good.

Cheers,
-Max
