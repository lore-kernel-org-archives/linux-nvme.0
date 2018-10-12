From: yaolin@marvell.com (Yao Lin)
Date: Fri, 12 Oct 2018 04:44:22 +0000
Subject: bad IOPS when running multiple btest/fio in parallel
Message-ID: <1539319463418.78556@marvell.com>

Today I changed to a much simpler setup and the same issue persists.

Directly connect 2 PCs (identical hardware) with a pair of 100G rNICs. Create a null block device on the target PC and configure it as the NVMeOF target. So, there is no switch or SSD in this setup. And this is a single FIO, not the 4 FIO in parallel I mentioned earlier.

Start fio test against that null block device from the host, the best IOPS is 1550K. That's the best IOPS after I try out many different QD, # of job, and CPU affinity setting. Run the same fio test on the target, I get 2250K IOPS (it jumps to 3650K when I increased the number of threads). ?

So it seems to me that Linux NVMe stack is quite good and can support 100Gb/s + throughput. But the same can not be said of the NVMeOF stack. Any tuning possible?
