From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Oct 2016 11:07:23 -0400
Subject: Scalability issue with multiple NVMe Devices with one core
In-Reply-To: <2F56CFEA-4C6D-48B9-92B0-C4E74AF0B60B@mellanox.com>
References: <50e02652-9e54-c314-6551-cd3075ccb005@mellanox.com>
 <20161013141820.GA17823@localhost.localdomain>
 <5db865d2-3698-b621-8511-a996499d66bf@mellanox.com>
 <20161013144433.GB17823@localhost.localdomain>
 <2F56CFEA-4C6D-48B9-92B0-C4E74AF0B60B@mellanox.com>
Message-ID: <20161013150723.GC17823@localhost.localdomain>

On Thu, Oct 13, 2016@02:48:34PM +0000, Roy Shterman wrote:
>> And if you append "--name task_nvme1n1 --filename=/dev/nvme1n1" to this
>> command, you are not observing a
>> meaningful IOPS improvement?
> 
> I appended only --filename=/dev/nvme0n1 without the new name, I'm not sure if it makes any difference but I can check.

If you don't add --name, fio isn't going to start another job, so you're
not accessing the devices in parallel and shouldn't expect an IOPS
improvement.
