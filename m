From: greg@kroah.com (Greg KH)
Date: Fri, 27 Jul 2012 11:25:46 -0700
Subject: [PATCH] NVMe: Add a character device for each nvme device
In-Reply-To: <20120727181212.GM22985@linux.intel.com>
References: <1343407458-29909-1-git-send-email-keith.busch@intel.com>
 <20120727181212.GM22985@linux.intel.com>
Message-ID: <20120727182546.GA23874@kroah.com>

On Fri, Jul 27, 2012@02:12:12PM -0400, Matthew Wilcox wrote:
> On Fri, Jul 27, 2012@10:44:18AM -0600, Keith Busch wrote:
> > Registers a character device for the nvme module and creates character
> > files as /dev/nvmeN for each nvme device probed, where N is the device
> > instance. The character devices support nvme admin ioctl commands so
> > that nvme devices without namespaces can be managed.
> 
> I don't see a problem here, but I'm no expert at sysfs / character devices.
> Alan, Greg, anyone else see any problems with how this character device is
> created / destroyed?

Yes, see below:

> > +	device_create(nvme_char_cl, NULL, MKDEV(nvme_char_major, dev->instance),
> > +						NULL, "nvme%d", dev->instance);

You just created a device at the "root" of sysfs, which is wrong,
especially when you do have a parent device here.  Please use it.

Also, why are you creating your own class?  Can't this just be a misc
device?  And if you want to create your own class, please don't, use a
bus, as that is what is really happening here, right?  We are trying to
move away from using 'struct class' wherever possible (one of these days
we'll just remove it...)

thanks,

greg k-h
