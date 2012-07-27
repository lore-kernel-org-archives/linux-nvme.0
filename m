From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 27 Jul 2012 16:26:55 -0400
Subject: [PATCH] NVMe: Add a character device for each nvme device
In-Reply-To: <5012EBD9.8010602@pobox.com>
References: <1343407458-29909-1-git-send-email-keith.busch@intel.com>
 <20120727181212.GM22985@linux.intel.com>
 <5012EBD9.8010602@pobox.com>
Message-ID: <20120727202655.GP22985@linux.intel.com>

On Fri, Jul 27, 2012@03:28:25PM -0400, Jeff Garzik wrote:
> On 07/27/2012 02:12 PM, Matthew Wilcox wrote:
> >On Fri, Jul 27, 2012@10:44:18AM -0600, Keith Busch wrote:
> >>Registers a character device for the nvme module and creates character
> >>files as /dev/nvmeN for each nvme device probed, where N is the device
> >>instance. The character devices support nvme admin ioctl commands so
> >>that nvme devices without namespaces can be managed.
> >
> >I don't see a problem here, but I'm no expert at sysfs / character devices.
> >Alan, Greg, anyone else see any problems with how this character device is
> >created / destroyed?
> 
> This seems like something normally done via a control device that is
> addressible via bsg.

I'm not convinced about that.  bsg requires a request_queue, and we
don't have one in the absence of any storage.  There doesn't even seem
to be a standard way of sending commands to SCSI hosts, let alone block
device controllers.

Maybe we should design such a mechanism, but maybe we shouldn't ... as we
find common things to do, we tend to move those to sysfs, not ioctls,
and the kinds of commands that are being sent here are essentially
vendor-specific NVMe commands; it's not clear they'd fit neatly into a
generic mechanism.

> This is -not- a NAK, but maybe the storage folks have a different
> preference for an admin-command path.
> 
> 	Jeff
> 
