From: alexnln@yahoo.com (alex nln)
Date: Sun, 7 Jun 2015 22:17:17 +0000 (UTC)
Subject: nvme  single core performance question
Message-ID: <682248939.6745169.1433715437812.JavaMail.yahoo@mail.yahoo.com>

Hello list,

I am testing Intel P3600 NVMe SSD and I experience performance 

degradation of 20% between kernels 3.16.0 and 4.0.5 in random 

read test on single core system.

kernel                IOPS    BW         CPU (usr/sys)

-------------------------------------------------------

4.0.5                 207K    103MB/s    32/68
3.16.0-34-generic     250K    124MB/s    39/61

What possibly can cause such performance degradation?

I use fio tool, random read of 512B blocks:

[global]
filename=/dev/nvme0n1
ioengine=libaio
direct=1
buffered=0
blocksize=512
rw=randread
iodepth=60
numjobs=1
time_based
runtime=120
norandommap
refill_buffers
group_reporting

Kernel boot parameters: "idle=poll nosmp"
I tested 4.0.5 with use_blk_mq=Y and use_blk_mq=N and receive same results.

Thank you
