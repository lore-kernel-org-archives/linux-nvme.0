From: jinglei@ren.systems (Jinglei Ren)
Date: Sat, 18 Apr 2015 18:39:37 +0000
Subject: Latency of sequential vs. random small writes
Message-ID: <1429382376563.7463@ren.systems>

Hi guys,

I am trying NVMe user utilities (http://git.infradead.org/users/kbusch/nvme-user.git) on Intel SSD DC P3600, but find some counterintuitive results.
?
Why individual latency of sequential 512-bytes writes is much larger than that of random ones?

In my program, I issue 100 writes via ioctl(), whose "nblocks" is set to 0, i.e., 512 bytes. "Sequential" writes mean their "slba" (starting logical block address) is from 0 to 100 in order, while "random" writes mean their "slba" is a random number (below 1000 in my case). I calculate the average time to complete each ioctl() call. As a result, sequential writes each see whopping 1500+ usec latency, while random ones see only around 80 usec each.

This phenomenon is also confirmed by running FIO (http://freecode.com/projects/fio). For direct-device 1 KB writes with a single queue depth, sequential ones show 884 usec latency on average, while random ones show 10 usec.

I also tried options like NVME_RW_DSM_LATENCY_LOW and NVME_RW_DSM_SEQ_REQ, but none seems to help. By the way, any suggestion on these settings if I want low latency small writes that have to be sequentially appended?

Many thanks in advance for your help!

Best,
Jinglei
