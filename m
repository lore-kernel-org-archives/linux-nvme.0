From: famz@redhat.com (Fam Zheng)
Date: Thu, 30 Jun 2016 14:35:54 +0800
Subject: [PATCH v2 00/12] gendisk: Generate uevent after attribute
 available
In-Reply-To: <20160630062442.GA19761@infradead.org>
References: <20160630015953.6888-1-famz@redhat.com>
 <20160630062442.GA19761@infradead.org>
Message-ID: <20160630063554.GE23296@ad.usersys.redhat.com>

On Wed, 06/29 23:24, Christoph Hellwig wrote:
> On Thu, Jun 30, 2016@09:59:41AM +0800, Fam Zheng wrote:
> > Documentation/kobject.txt:
> > > Use the KOBJ_ADD action for when the kobject is first added to the kernel.
> > > This should be done only after any attributes or children of the kobject
> > > have been initialized properly, as userspace will instantly start to look
> > > for them when this call happens.
> > 
> > Unfortunately it seems impossible to fix this generally without touching the
> > offending callers.  The approach I'm proposing here is adding a flag to
> > suppress uevent in add_disk(), which is patch 1, then in later patches, convert
> > any caller to only trigger the uevent when attributes are added.
> 
> We (or rather Dan) is touching most add_disk callers anyway for the
> driverfs_dev removal.  Let's just pass the array of attributes to
> a disk_add variant and solve the issue for real.

I thought about that. Its usage is more compact compared to this series, but is
also more code and less flexible IMO.  For example, we need at least two
variants, for attribute_group and device_attribute separately, right?

Fam
