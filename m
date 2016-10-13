From: roysh@mellanox.com (Roy Shterman)
Date: Thu, 13 Oct 2016 08:44:37 +0300
Subject: Scalability issue with multiple NVMe Devices with one core
Message-ID: <50e02652-9e54-c314-6551-cd3075ccb005@mellanox.com>


Hi,

scenario is when running traffic over 1 NVMe Device with 1 core I'm 
getting X IOPS and Y% core utilization.

In my perception, when adding more NVMe Devices I should see some 
linearity of the above results, but I'm getting only a small improvement 
in IOPS and still not getting 100% (or closer ) in CPU utilization.

Any suggestions?

Thanks,

Roy
