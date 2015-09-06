From: ks0204.kim@samsung.com (=?ks_c_5601-1987?B?seiw5rvq?=)
Date: Sun, 06 Sep 2015 17:06:24 +0900
Subject: setting nvme irq per cpu affinity in device driver
In-Reply-To: <20150902140517.GA9787@infradead.org>
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
 <20150902140517.GA9787@infradead.org>
Message-ID: <000001d0e87a$ec9905d0$c5cb1170$@samsung.com>

Hi Christoph Hellwig,

I'd like to know the plan to provide the API from irq sybsystem.
Let me kindly ask you to how can I get to know the status.
Do you think should I need to contact to the irq maintainer? 

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Christoph Hellwig
Sent: Wednesday, September 02, 2015 11:05 PM
To: ??????
Cc: Linux-nvme at lists.infradead.org
Subject: Re: setting nvme irq per cpu affinity in device driver

We'll need a proper API in the interrupt subsystem to set the affinity
instead of poking directly into the internals.  The irq subsystem
maintainer already indicated he's fine with adding suh an API in principle.
Please go ahead and propose something similar to your implementation, just
as an exported API in kernel/irq instead of inside the NVMe driver.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
