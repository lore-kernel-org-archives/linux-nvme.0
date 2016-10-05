From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 05 Oct 2016 11:20:13 -0700
Subject: [PATCH 1/1] nvme : Add sysfs entry for NVMe CMBs when appropriate
In-Reply-To: <20161005174841.GA23679@cgy1-donard.priv.deltatee.com>
References: <1475014513-18083-1-git-send-email-sbates@raithlin.com>
 <1475014513-18083-2-git-send-email-sbates@raithlin.com>
 <9d062df7-d895-4c21-ca0d-b4fc3cb878c1@grimberg.me>
 <20161005143843.GA23281@cgy1-donard.priv.deltatee.com>
 <b8f19ee3-e641-1e30-3294-192b1f519181@grimberg.me>
 <20161005174841.GA23679@cgy1-donard.priv.deltatee.com>
Message-ID: <1475691613.26632.36.camel@linux.intel.com>

On Wed, 2016-10-05@11:48 -0600, Stephen Bates wrote:
> On Wed, Oct 05, 2016@07:50:57PM +0300, Sagi Grimberg wrote:
> > 
> > 
> > > 
> > > The fabrics specification currently denotes the CMBLOC and CMBSZ
> > > properties as reserved [1].
> > 
> > Managed to forget that... So I guess I'm fine with the patch as
> > it is,
> > 
> > Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> > 
> 
> Sagi
> 
> Thanks! I will work on a v1 to address Jonathan's issue and add your
> tag to that. Coming soon...

You can add my tag too if you like as well, as I've chatted my thoughts
to you via phone/email:

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>


> 
> > 
> > > 
> > > Also I am wondering where the physical memory backing a fabrics
> > > CMB
> > > would reside. Would this be memory in the fabric NIC on the host,
> > > in
> > > the NIC on the target or somewhere else?
> > 
> > This was discussed in the WG a few times before, not sure if we
> > can discuss this before its in the spec though...
> 
> Ooops, you are correct. Us lowely kernel developers should not be
> discussing things related to changes to the NVMe specification ;-). I
> will take this discussion inside the NVMe technical working group.
> 
> Cheers
> 
> Stephen
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
