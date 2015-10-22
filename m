From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 18:30:00 +0200
Subject: [PATCH 17/18] nvme: move namespace scanning to common code
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93CD26AE0@fmsmsx104.amr.corp.intel.com>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-18-git-send-email-hch@lst.de>
 <1445470059.3307.85.camel@linux.intel.com> <20151022073940.GD20076@lst.de>
 <B58D82457FDA0744A320A2FC5AC253B93CD26AE0@fmsmsx104.amr.corp.intel.com>
Message-ID: <20151022163000.GB20934@lst.de>

On Thu, Oct 22, 2015@01:48:30PM +0000, Busch, Keith wrote:
> > Yes, someone should sit down and think about the concurrency model
> > for namespace scanning.  Also we really should look into using Identify
> > for the active name space list as that will be a lot more efficient for
> > controllers with lots of namespaces.
> 
> Here's a namespace list proposal:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2015-September/002325.html
> 
> I'll rebase it on the latest and resend.

Looks good.  I suspect we might want a fallback if the controller
doesn't support Identify 0x2 - NVMe 1.1 doesn't mention anything about
Identify subcommand being optional or not and 1.2 says "Controllers that
support specification revision 1.1 or later shall support this
capability." which isn't as a strong as a must.  And some lazy people
like me implemented NVMe targets systes that don't support it but claim
to be version 1.2, although I'll try to get that fixed ASAP.
