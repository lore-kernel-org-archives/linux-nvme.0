From: keith.busch@intel.com (Keith Busch)
Date: Tue, 8 Dec 2015 19:15:55 +0000
Subject: [PATCH] NVMe: Expose namespace unique identifier to sysfs
In-Reply-To: <20151208185325.GC2457@linux.intel.com>
References: <1449595605-20735-1-git-send-email-keith.busch@intel.com>
 <20151208185325.GC2457@linux.intel.com>
Message-ID: <20151208191555.GB16241@localhost.localdomain>

On Tue, Dec 08, 2015@01:53:25PM -0500, Matthew Wilcox wrote:
> On Tue, Dec 08, 2015@10:26:45AM -0700, Keith Busch wrote:
> > This patch determines which the device supports and reports the unique
> > identifier in new sysfs binary attribute "uuid". The attribute group is
> > added to the gendisk's kobject directory.
> 
> I don't understand why we want to produce a binary attribute here instead
> of a text attribute?  We already have nicely-formatted UUIDs in sysfs
> (see the %pU specifier to printk)

I don't have a strong opinion here. Just copying scsi vpd83 attribute,
and thought it's easier for a program to consume as binary, and easy to
read from the shell with hexdump.

> I don't think we should have one attribute that might be an eui64 or might
> be a uuid.  Maybe we should produce either an eui64 or a uuid attribute,
> depending on which one the device reports?

Sure, sounds reasonable.

These are supposed to be consumed by userspace to do something useful,
but I'm not getting much direction (I don't know why they insist on
these being available in sysfs instead of using existing ioctl).

I've no problem dynamically providing these based on device capabilities.
Hopefully the user space is okay with looking for the presense of two
different files.
 
> > +		if (bitmap_empty((void *)identifier, len * 8) &&
> 
> I'm a bit reluctant to use bitmap_empty here, because it's not actually
> a bitmap.  We almost want the inverse of memchr ("find me the first
> byte that is non-zero").  Maybe somebody else knows a better functoin
> to call here?

Better methods are learned all the time! It was nearly a year ago today
you suggested bitmap_empty for checking the very same fields. :)

  http://lists.infradead.org/pipermail/linux-nvme/2014-December/001349.html
