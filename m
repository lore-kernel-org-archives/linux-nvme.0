From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 8 Dec 2015 15:11:29 -0800
Subject: [PATCH] NVMe: Expose namespace unique identifier to sysfs
In-Reply-To: <20151208191555.GB16241@localhost.localdomain>
References: <1449595605-20735-1-git-send-email-keith.busch@intel.com>
 <20151208185325.GC2457@linux.intel.com>
 <20151208191555.GB16241@localhost.localdomain>
Message-ID: <20151208231129.GA21463@infradead.org>

On Tue, Dec 08, 2015@07:15:55PM +0000, Keith Busch wrote:
> > I don't understand why we want to produce a binary attribute here instead
> > of a text attribute?  We already have nicely-formatted UUIDs in sysfs
> > (see the %pU specifier to printk)
> 
> I don't have a strong opinion here. Just copying scsi vpd83 attribute,
> and thought it's easier for a program to consume as binary, and easy to
> read from the shell with hexdump.

SCSI is a bad example.  James insisted we should not parse the EVPD
pages in kernel space for reasons no one agreed to (and now we'll need
to add that for in-kernel consumers anyway).  So unless some userspace
absolutely needs to do it the same way it might be better to offer a
ASCII representation.

> > I don't think we should have one attribute that might be an eui64 or might
> > be a uuid.  Maybe we should produce either an eui64 or a uuid attribute,
> > depending on which one the device reports?
> 
> Sure, sounds reasonable.
> 
> These are supposed to be consumed by userspace to do something useful,
> but I'm not getting much direction (I don't know why they insist on
> these being available in sysfs instead of using existing ioctl).

Using pass through ioctls from udev has been really painful from SCSI,
mostly in multipath environments or with flakey USB devices where we'd
need to extend a lot of magic done in the SCSI layer to those userspace
callers to get everything right.  NVMe is probably doing better in
that respect at the moment, but I'm not going to take any bets that
it's going to remain that way.

> I've no problem dynamically providing these based on device capabilities.
> Hopefully the user space is okay with looking for the presense of two
> different files.

An alternative might be to show the type of ID if we're using a text
format, but that sounds fairly ugly as well.
