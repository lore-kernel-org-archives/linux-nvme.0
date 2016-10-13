From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Oct 2016 10:18:21 -0400
Subject: Scalability issue with multiple NVMe Devices with one core
In-Reply-To: <50e02652-9e54-c314-6551-cd3075ccb005@mellanox.com>
References: <50e02652-9e54-c314-6551-cd3075ccb005@mellanox.com>
Message-ID: <20161013141820.GA17823@localhost.localdomain>

On Thu, Oct 13, 2016@08:44:37AM +0300, Roy Shterman wrote:
> scenario is when running traffic over 1 NVMe Device with 1 core I'm getting
> X IOPS and Y% core utilization.
> 
> In my perception, when adding more NVMe Devices I should see some linearity
> of the above results, but I'm getting only a small improvement in IOPS and
> still not getting 100% (or closer ) in CPU utilization.
> 
> Any suggestions?

How are you generating IO?
