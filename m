From: hare@suse.de (Hannes Reinecke)
Date: Tue, 3 Oct 2017 18:01:10 +0200
Subject: [PATCH 4/6] nvme: display 'NMIC' namespace attribute
In-Reply-To: <20171003114924.GA24650@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-5-git-send-email-hare@suse.de>
 <20171002161654.GC11048@lst.de>
 <e5f46d2d-9473-c99c-9319-8567567b6994@suse.de>
 <20171003114924.GA24650@lst.de>
Message-ID: <a99239fb-2f35-a53a-2a7b-52b324e76d86@suse.de>

On 10/03/2017 01:49 PM, Christoph Hellwig wrote:
> On Tue, Oct 03, 2017@12:00:16PM +0200, Hannes Reinecke wrote:
>> Do stop systemd/udev doing weird things on the device.
> 
> Please define weird things, preferably actual practical wierd things
> you've observed with this implementation and then document them here
> in the patch description.
> 
Any event will be passed to systemd, and ends up being passed as a
'target' to the systemd service evaluation routines.
One of the services happens to be the systemd-fsck at .service, which will
be calling fsck on every device found in /etc/fstab.

If now this device is specified with an fs uuid (as it's common
nowadays) systemd will be invoking fsck on each device carrying this UUID.
As we're having _two_ devices with the same UUID (at the very least;
actually it's 'number of paths + 1'), systemd will be invoking fsck on
_each_ of those devices.
All pointing to the same underlying namespace.
I'd be very curious to figure out how fsck deals with such a situation.

And then systemd will try to _mount_ each of those devices, which is
where the real fun begins. Depending on the timing it might chose to
mount any of those devices, more often than not at the same time as
another fsck instance is running on another path.
Again, I sincerely doubt that either mount nor fsck is able to handle
these situations.

The errors from these scenarios will vary wildly, from simple I/O errors
to filesystems corruption.

Hence it's adviseable to set the 'SYSTEMD_READY=0' flag on all
underlying paths, and only forward the 'real' multipathed device to
systemd for evaluation.
But this needs to be done _before_ any other event has a chance to
interrupt here.
_And_ we cannot call an external userspace program here, as this is
multipathing, and we might be called for an 'add' event when all paths
are down, at which point we cannot access the root-fs and udev will
stall trying to load the said program.
Hence the event will never finished processing, the path will never
recover, and your system is dead with all paths running.
Not good.

>> If we have the 'NMIC' attribute in sysfs we can evaluate it during event
>> handling, and set the 'SYSTEMD_READY=0' flag if NMIC=1.
> 
> Bonus points of including such sniplets in the patch description,
> similar to how I offered udev rules in the main multipath path.
> 
Okay, will be doing so.

>> One of the painful lessons learned when moving multipath-tools to
>> systemd; we absolutely need an indicator in sysfs to handle multipath
>> devices race-free.
> 
> dm-multipath devices require userspace setup, nvme-mpath ones don't.
> That's a huge difference that would make udev rules a lot simpler.
> But if they don't I'd like to see a good explanation here, both to
> understand why you'd want this flag, and also if there is a way to
> just do the right thing from the kernel.
> 

As mentioned above, yes, the udev rules will be massively simpler.
Essentially, the rule just boils down to setting the 'SYSTEMD_READY=0'
flag when NMIC is set.
But for that we need to figure out _if_ that bit is set, and we need to
do so without any external userspace program.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
