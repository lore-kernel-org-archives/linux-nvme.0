From: indraneel.m@samsung.com (Indraneel Mukherjee)
Date: Fri, 22 Aug 2014 19:57:31 +0530
Subject: [PATCH] NVMe: Fix partition detection issue(Hot Remove followed by
 Hot Add)
In-Reply-To: <alpine.LRH.2.03.1408211209220.4696@AMR>
References: <060001cfb175$a1c44c00$e54ce400$@samsung.com>
 <alpine.LRH.2.03.1408211209220.4696@AMR>
Message-ID: <00ce01cfbe15$45f887e0$d1e997a0$@samsung.com>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Keith Busch
> Sent: Friday, August 22, 2014 12:37 AM
> To: Indraneel Mukherjee
> Cc: keith.busch at intel.com; willy at linux.intel.com; shiro.itou at outlook.com;
> linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] NVMe: Fix partition detection issue(Hot Remove
followed
> by Hot Add)
> 
> On Wed, 6 Aug 2014, Indraneel Mukherjee wrote:
> > This patch addresses the same issue that has been discussed at
> > http://lists.infradead.org/pipermail/linux-nvme/2014-August/001093.htm
> > l
> > recently
> > and provides the best of both worlds (both static & dynamic minor
> > allocation schemes similar to SCSI driver(sd)).
> >
> > - Partially reverts the dynamic minor allocation scheme (but retains
> > the GENHD_FL_EXT_DEVT flag to allow allocating very large of minors
> > dynamically)
> >
> >  introduced in commit 469071a37afc8a627b6b2ddf29db0a097d864845 and
> > re-introduces static minor allocation.
> > - Aligns Hot-Plug behaviour to SCSI.
> > - Uses one common ida allocation routine for allocating namespace &
> > dev instances.
> > - Introduces a new module parameter nvme_minors to manage the static
> > minor allocations(default is 64).
> >
> > Signed-off-by: Indraneel M <indraneel.m at samsung.com>
> 
> 
> Your patch has formatting issues (bad email client?) so it doesn't apply
without
> some fixing.

Will try to resend using git send-email if the firewall problem is resolved
at my end.

> 
> I do think we need to something like this though; the block_device that
should
> go with the new disk is already opened against the removed disk and so the
new
> one isn't usable.
> 
> 
> > diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> > index 28aec2d..6d01164 100644
> > --- a/drivers/block/nvme-core.c
> > +++ b/drivers/block/nvme-core.c
> > @@ -65,6 +65,10 @@ MODULE_PARM_DESC(retry_time, "time in seconds to
> > retry failed I/O"); static int nvme_major; module_param(nvme_major,
> > int, 0);
> >
> > +static int nvme_minors = 64;
> > +module_param(nvme_minors, int, 0644);
> MODULE_PARM_DESC(nvme_minors,
> > +"Minors numbers to allocate per Namespace");
> 
> You definitely don't want to make this parameter writeable; changing it
after the
> minors were setup will cause breakage.

Won't nvme_minors be changeable only while loading the module as it's a
module param? Driver should be able to handle this without any breakage.
Idea is to provide a way to change this without compiling every time.

 I think the permissions should be set to 0,
> but if you really want to be able to read it, 0444 is okay.
> 
> You also need to make sure the nvme_minors parameter is not 0 otherwise
> you'll hit a divide-by-zero error.

Will add the check.

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
