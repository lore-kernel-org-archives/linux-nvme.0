From: ks0204.kim@samsung.com (=?ks_c_5601-1987?B?seiw5rvq?=)
Date: Wed, 09 Sep 2015 09:35:08 +0900
Subject: setting nvme irq per cpu affinity in device driver
In-Reply-To: <alpine.LNX.2.00.1509081446250.23840@localhost.lm.intel.com>
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
 <20150902140517.GA9787@infradead.org>
 <000001d0e87a$ec9905d0$c5cb1170$@samsung.com>
 <alpine.LNX.2.00.1509081446250.23840@localhost.lm.intel.com>
Message-ID: <006501d0ea97$6174cbf0$245e63d0$@samsung.com>

Actually, That's true.
Even though driver sets affinity during  queue initialization, irqbalance
overwrite the setting when it run. 
So, My suggestion is remain this feature for those who need to archieve
high IOPS with a direction exposed like something below.

-disable irqbalance
-insmod nvme.ko use_set_irq_affinity=1
-optionally, enable irqbalance again with -i option lists, nvme irq lists
monitoring banned


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Keith Busch
Sent: Tuesday, September 08, 2015 11:48 PM
To: ???
Cc: 'Christoph Hellwig'; Linux-nvme at lists.infradead.org
Subject: RE: setting nvme irq per cpu affinity in device driver

On Sun, 6 Sep 2015, ??? wrote:
> Hi Christoph Hellwig,
>
> I'd like to know the plan to provide the API from irq sybsystem.
> Let me kindly ask you to how can I get to know the status.
> Do you think should I need to contact to the irq maintainer?

I think it'd be great to propose to the irq subsystem, but I think this
doesn't necessarilly solve the problem. Won't irqbalance still undo
whatever the driver requested?
