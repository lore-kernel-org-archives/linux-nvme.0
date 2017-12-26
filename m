From: keith.busch@intel.com (Keith Busch)
Date: Tue, 26 Dec 2017 13:35:18 -0700
Subject: [PATCH 1/3] nvme/pci: Start request after doorbell ring
In-Reply-To: <8c7c2b8a-7e26-c1a1-4681-8c7721184d39@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
 <8c7c2b8a-7e26-c1a1-4681-8c7721184d39@grimberg.me>
Message-ID: <20171226203518.GA13188@localhost.localdomain>

On Mon, Dec 25, 2017@12:11:47PM +0200, Sagi Grimberg wrote:
> > This is a performance optimization that allows the hardware to work on
> > a command in parallel with the kernel's stats and timeout tracking.
> 
> Curious to know what does this buy us?

blk_mq_start_request doesn't do anything to make the command ready to
submit to hardware, so this is pure software overhead, somewhere between
200-300 nanoseconds as far as I can measure (YMMV). We can post the command
to hardware before taking on this software overhead so the hardware gets
to fetch the command that much sooner.

One thing to remember is we need to ensure the driver can't complete the
request before starting it. The driver's exisitng locking does ensure
that with this patch, so it's just something to keep in mind if anything
should ever change in the future.
