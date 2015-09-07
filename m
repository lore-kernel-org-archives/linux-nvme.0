From: hch@infradead.org ('Christoph Hellwig')
Date: Mon, 7 Sep 2015 10:54:23 -0700
Subject: setting nvme irq per cpu affinity in device driver
In-Reply-To: <000001d0e87a$ec9905d0$c5cb1170$@samsung.com>
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
 <20150902140517.GA9787@infradead.org>
 <000001d0e87a$ec9905d0$c5cb1170$@samsung.com>
Message-ID: <20150907175423.GA27381@infradead.org>

On Sun, Sep 06, 2015@05:06:24PM +0900, ?????? wrote:
> Hi Christoph Hellwig,
> 
> I'd like to know the plan to provide the API from irq sybsystem.
> Let me kindly ask you to how can I get to know the status.
> Do you think should I need to contact to the irq maintainer? 

The plan in still vague.  I'd suggest you kick start the discussion
by submitting a patch that adds the code you suggest into a helper
in kernel/irq/manage.c.
