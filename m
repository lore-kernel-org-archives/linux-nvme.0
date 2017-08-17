From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Aug 2017 17:04:50 -0400
Subject: [PATCH] nvme-cli: add support for directive command
In-Reply-To: <4f5e8a927f0d485b8a51a50224a4d64e@samsung.com>
References: <CGME20170811025053epcas2p1ec98081d04a0488a2c08836c909f368c@epcas2p1.samsung.com>
 <1502420051-12378-1-git-send-email-kwan.huen@samsung.com>
 <20170811170314.GB7233@localhost.localdomain>
 <4f5e8a927f0d485b8a51a50224a4d64e@samsung.com>
Message-ID: <20170817210450.GC21397@localhost.localdomain>

On Wed, Aug 16, 2017@02:10:48AM +0000, Kwan (Hingkwan) Huen wrote:
> > From: Keith Busch [mailto:keith.busch at intel.com]
> > Sent: Friday, August 11, 2017 10:03 AM
> > To: Kwan (Hingkwan) Huen <kwan.huen at samsung.com>
> > Cc: linux-nvme at lists.infradead.org; axboe at kernel.dk; Changho Choi
> > <changho.c at samsung.com>; Vijay Balakrishnan <vijay.bala at samsung.com>
> > Subject: Re: [PATCH] nvme-cli: add support for directive command
> > 
> > On Thu, Aug 10, 2017@07:54:09PM -0700, kwan.huen@samsung.com wrote:
> > > Directive is a feature introduced in NVMe v1.3 that allows host and
> > > NVM subsystem or controller information exchange, namely data lifetime
> > > hint for example. Information is transmitted using the Directive Send
> > > and Directive Receive commands.
> > >
> > > This patch set allows control of the directive resources of a
> > > directive-enabled nvme device.
> > 
> > The patches themselves look great, but I didn't realize this was a feature user-
> > space should be accessing. Providing this could mess up the streams the kernel
> > believes are set up, right?
> 
> Hi Keith,
> Sorry for late! 
> That's a valid concern. But the only thing I can see, which potentially cause 
> problem, is the stream directive enable/disable. With kernel enables and 
> manages the streams, if the tool can disable it, it'll cause IO error because the 
> device no longer takes stream write commands. I think we can disable this 
> directive enable/disable in this patch for now to avoid this problem, until 
> we have a better way to coordinate this with the driver.
> Besides that, I think it is still valuable for the tool that allows users 
> to quickly check the directive functionalities and get status. In addition, the patch
> also enables other features, e.g., users can allocate stream resources 
> dedicated to namespace.

Okay, that sounds reasonable, and I've applied the patch as-is. The tool
has always provided a means to break stuff anyway, so it's always been
assumed that you're a responsible root user when executing it. :)

Thanks for the patches.
