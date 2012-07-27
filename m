From: jgarzik@pobox.com (Jeff Garzik)
Date: Fri, 27 Jul 2012 15:28:25 -0400
Subject: [PATCH] NVMe: Add a character device for each nvme device
In-Reply-To: <20120727181212.GM22985@linux.intel.com>
References: <1343407458-29909-1-git-send-email-keith.busch@intel.com>
 <20120727181212.GM22985@linux.intel.com>
Message-ID: <5012EBD9.8010602@pobox.com>

On 07/27/2012 02:12 PM, Matthew Wilcox wrote:
> On Fri, Jul 27, 2012@10:44:18AM -0600, Keith Busch wrote:
>> Registers a character device for the nvme module and creates character
>> files as /dev/nvmeN for each nvme device probed, where N is the device
>> instance. The character devices support nvme admin ioctl commands so
>> that nvme devices without namespaces can be managed.
>
> I don't see a problem here, but I'm no expert at sysfs / character devices.
> Alan, Greg, anyone else see any problems with how this character device is
> created / destroyed?

This seems like something normally done via a control device that is 
addressible via bsg.

This is -not- a NAK, but maybe the storage folks have a different 
preference for an admin-command path.

	Jeff
