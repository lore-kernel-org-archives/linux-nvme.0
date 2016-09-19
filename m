From: kirubak@zadarastorage.com (Kirubakaran Kaliannan)
Date: Mon, 19 Sep 2016 11:03:18 +0530
Subject: NVMf (NVME over fabrics) Performance
Message-ID: <c53316925d9da9f13925a29674533f2e@mail.gmail.com>

Hi All,

I am working on measuring the NVMf (with Mellanox ConnectX-3 pro(40Gps)
and Intel P3600) performance numbers on my 2 servers with 32 CPU each
(64GB RAM).

These are the numbers I am getting from IOPS perspective for Read, and for
4K size I/O?s

1 NULL block-devices using NVMf = 600K
2 NULL block-device using NVMf = 600k (not growing linearly per device)

1 Intel NVME device through NVMf= 450K
2 Intel NVME device through NVMf = 470K (There is no increase in IOPs
beyond 500K by adding more devices)

I installed 4.7 + rc2 Linux kernel
(git://git.infradead.org/nvme-fabrics.git)
CPU/RAM is not the bottleneck.
Mellanox card is 40GBps ? 600 IOPs use only 2400 MB (it still have ~2000
MB bandwidth)

With NVME (same server) I can see the linear increase in performance by
adding more devices.

Questions:

Can you please share the NVMf numbers available ?
Is there any configuration required to improve the performance linearly by
adding more devices ?
Looking for your direction/suggestion in achieving the max NVMf
performance numbers.

Thanks,
-kiru
