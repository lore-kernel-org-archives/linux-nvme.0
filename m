From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 21 Feb 2017 12:41:39 -0800
Subject: [PATCH v2] nvmet: discovery controller to set ioccsz and iorcsz
In-Reply-To: <20170217091532.GA16652@infradead.org>
References: <58a6630c.QwbzGsQTsh8C63rk%jsmart2021@gmail.com>
 <20170217091532.GA16652@infradead.org>
Message-ID: <1487709699.3502.24.camel@linux.intel.com>

On Fri, 2017-02-17@01:15 -0800, Christoph Hellwig wrote:
> On Thu, Feb 16, 2017@06:42:20PM -0800, James Smart wrote:
> > 
> > 
> > Revised the patch: add transport capsule inline size into ioccsz value
> > 
> > The discovery controller's Identify command handler never set these
> > fields leaving them zero. The host-side fc transport validates that
> > these values are appropriate and was killing the connection with the
> > controller as they were zero.
> > 
> > Set the controller ioccsz and iorcsz values
> 
> Discovery controllers do not support I/O commands, so these settings
> don't make any sense there.??They are also not included in the
> fields that Idenitfy Controller should report for Discovery controllers
> (Figure 33 in Fabrics 1.0)

I didn't think it hurt making sure these two fields contain the minimum
required values, per Fabrics spec, as values of 0 are invalid (Figure 28). ?But
I also see your point.

Jay

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
