From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 27 Jul 2012 15:08:21 -0400
Subject: [PATCH] NVMe: Add a character device for each nvme device
In-Reply-To: <20120727182546.GA23874@kroah.com>
References: <1343407458-29909-1-git-send-email-keith.busch@intel.com>
 <20120727181212.GM22985@linux.intel.com>
 <20120727182546.GA23874@kroah.com>
Message-ID: <20120727190821.GO22985@linux.intel.com>

On Fri, Jul 27, 2012@11:25:46AM -0700, Greg KH wrote:
> On Fri, Jul 27, 2012@02:12:12PM -0400, Matthew Wilcox wrote:
> > I don't see a problem here, but I'm no expert at sysfs / character devices.
> > Alan, Greg, anyone else see any problems with how this character device is
> > created / destroyed?
> 
> Yes, see below:

Thanks!

> > > +	device_create(nvme_char_cl, NULL, MKDEV(nvme_char_major, dev->instance),
> > > +						NULL, "nvme%d", dev->instance);
> 
> You just created a device at the "root" of sysfs, which is wrong,
> especially when you do have a parent device here.  Please use it.

OK, that makes sense; this device should be the child of the pci_dev that
it belongs to.

> Also, why are you creating your own class?  Can't this just be a misc
> device?  And if you want to create your own class, please don't, use a
> bus, as that is what is really happening here, right?  We are trying to
> move away from using 'struct class' wherever possible (one of these days
> we'll just remove it...)

What we're trying to achieve here is to create one character device
per NVMe controller that gets plugged in.  Each NVMe controller is-a
PCI function.  The reason we're trying to do this is so that we can send
commands to the NVMe controller, even when there is no storage present
(eg a drive is shipped from the factory with no configured storage).

So we have no particular desire to create a new struct class, or struct
bus.  If we can create a misc device per PCIe function that's bound to our
driver, that's great!  Can you recommend a driver that does this already?
