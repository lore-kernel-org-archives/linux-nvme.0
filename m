From: keith.busch@intel.com (Busch, Keith)
Date: Thu, 22 Oct 2015 13:48:30 +0000
Subject: [PATCH 17/18] nvme: move namespace scanning to common code
In-Reply-To: <20151022073940.GD20076@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-18-git-send-email-hch@lst.de>
 <1445470059.3307.85.camel@linux.intel.com> <20151022073940.GD20076@lst.de>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93CD26AE0@fmsmsx104.amr.corp.intel.com>

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Thursday, October 22, 2015 1:40 AM
> To: J Freyensee
> Cc: Christoph Hellwig; axboe at fb.com; Busch, Keith; Sternberg, Jay E; Cayton, Phil;
> mlin at kernel.org; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH 17/18] nvme: move namespace scanning to common code
> 
> On Wed, Oct 21, 2015@04:27:39PM -0700, J Freyensee wrote:
> > I know this is basically just a move into core.c, but with the concept
> > of namespace management in the 1.2 spec, would something like
> > list_for_each_entry_safe() and/or a spinlock be more appropriate?
> 
> Yes, someone should sit down and think about the concurrency model
> for namespace scanning.  Also we really should look into using Identify
> for the active name space list as that will be a lot more efficient for
> controllers with lots of namespaces.

Here's a namespace list proposal:

http://lists.infradead.org/pipermail/linux-nvme/2015-September/002325.html

I'll rebase it on the latest and resend.
