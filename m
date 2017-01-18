From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Jan 2017 13:45:05 -0500
Subject: [PATCH v4 5/6] nvme: Add Support for Opal: Unlock from S3 & Opal
 Allocation/Ioctls
In-Reply-To: <20170108142020.GC25986@infradead.org>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-6-git-send-email-scott.bauer@intel.com>
 <20170108142020.GC25986@infradead.org>
Message-ID: <20170118184505.GB27274@localhost.localdomain>

On Sun, Jan 08, 2017@06:20:20AM -0800, Christoph Hellwig wrote:
> > +config BLK_DEV_SED_OPAL
> > +       bool "Enable support for Opal Enabled NVMe Device"
> > +       depends on BLK_SED_OPAL
> > +       default n
> > +       ---help---
> > +       This enables support for an Opal enabled NVMe device.
> 
> I'd like to hear an opinion from Keith as well, but I personally would
> drop this confif option and just enable NVMe OPAL support if core block
> OPAL is supported.

Yes, I'd agree to just dropping this and tying it to BLK_SED_OPAL rather
than having this longer chain of config dependencies.
 
> > +#ifdef CONFIG_BLK_DEV_SED_OPAL
> > +		if (is_sed_ioctl(cmd))
> > +			return sed_ioctl(&ns->sed_ctx, cmd, arg);
> > +#endif
> 
> To avoid these ifdefs I would suggest to provide an always false
> inline version of is_sed_ioctl and a no-op inline of sed_ioctl
> in the header.

Yeah, see section 20 of the Linux kernel coding-style in
Documentation/process/coding-style.rst on the recommended way of
conditional code depending on config options.
