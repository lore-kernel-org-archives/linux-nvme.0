From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Jun 2016 23:24:42 -0700
Subject: [PATCH v2 00/12] gendisk: Generate uevent after attribute
 available
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
Message-ID: <20160630062442.GA19761@infradead.org>

On Thu, Jun 30, 2016@09:59:41AM +0800, Fam Zheng wrote:
> Documentation/kobject.txt:
> > Use the KOBJ_ADD action for when the kobject is first added to the kernel.
> > This should be done only after any attributes or children of the kobject
> > have been initialized properly, as userspace will instantly start to look
> > for them when this call happens.
> 
> Unfortunately it seems impossible to fix this generally without touching the
> offending callers.  The approach I'm proposing here is adding a flag to
> suppress uevent in add_disk(), which is patch 1, then in later patches, convert
> any caller to only trigger the uevent when attributes are added.

We (or rather Dan) is touching most add_disk callers anyway for the
driverfs_dev removal.  Let's just pass the array of attributes to
a disk_add variant and solve the issue for real.
