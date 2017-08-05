From: yogi43222@gmail.com (Yogi Wannabe)
Date: Fri, 4 Aug 2017 18:04:23 -0700
Subject: NVME card works on kernel 3.19.8 but not on 4.19.31
Message-ID: <CAGSHeY0H82iiKtYDiAmqdH_C6PytitvfkrmgYmQVcFnnmVWhmA@mail.gmail.com>

Hi,

Our NVME card works fine on Centos 7.3 with kernel 3.19.8. But with
Centos 7.3 and kernel 4.19.31 the driver

1. detects the board
2. creates I/O submission and completion queues
3. sends identify cmd to retrive controller information
4. /dev/nvme0 node is created.

However, /dev/nvme0n1 is not created and the drive does not show up in
/proc/partitions. Two things we have observed are that

1. identify cmd to retrive namespace information is not called
2. BLK_DEV_NVME_SCSI is not set in .config file on the running kernel

Any clues on what could be going wrong?

TIA
