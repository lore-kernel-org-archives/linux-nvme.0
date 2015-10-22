From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 09:38:08 +0200
Subject: [PATCH 15/18] nvme: add a common helper to read Identify
 Controller data
In-Reply-To: <1445467463.3307.72.camel@linux.intel.com>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-16-git-send-email-hch@lst.de>
 <1445467463.3307.72.camel@linux.intel.com>
Message-ID: <20151022073808.GC20076@lst.de>

On Wed, Oct 21, 2015@03:44:23PM -0700, J Freyensee wrote:
> On Fri, 2015-10-16@07:58 +0200, Christoph Hellwig wrote:
> > And add the 64-bit register read operation for it.
> 
> I apologize, but I am getting tripped up by the subject line of this
> patch and then the following description.
> 
> To me, this patch sounds and looks like it is doing two distinct,
> separate things, thereby two separate patches:
> 
> 1. Add a helper function to read and cache Identify Controller data
> 2. Add a 64-bit read register function pointer to nvme_ctrl_ops
> 
> I think it was PATCH 6 of this series that introduced "int
> (*reg_read32)()".  If it is easier, it would also make sense to also
> add "int (*reg_read64)()" there, instead of its own separate patch.

Through the whole series I've introduced the abstractions on an as-needed
basis, and this patch follows that style.
