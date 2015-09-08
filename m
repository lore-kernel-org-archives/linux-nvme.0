From: keith.busch@intel.com (Keith Busch)
Date: Tue, 8 Sep 2015 14:47:39 +0000 (UTC)
Subject: setting nvme irq per cpu affinity in device driver
In-Reply-To: <000001d0e87a$ec9905d0$c5cb1170$@samsung.com>
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
 <20150902140517.GA9787@infradead.org>
 <000001d0e87a$ec9905d0$c5cb1170$@samsung.com>
Message-ID: <alpine.LNX.2.00.1509081446250.23840@localhost.lm.intel.com>

On Sun, 6 Sep 2015, ??? wrote:
> Hi Christoph Hellwig,
>
> I'd like to know the plan to provide the API from irq sybsystem.
> Let me kindly ask you to how can I get to know the status.
> Do you think should I need to contact to the irq maintainer?

I think it'd be great to propose to the irq subsystem, but I think this
doesn't necessarilly solve the problem. Won't irqbalance still undo
whatever the driver requested?
