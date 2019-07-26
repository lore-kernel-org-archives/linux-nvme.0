From: hare@suse.de (Hannes Reinecke)
Date: Fri, 26 Jul 2019 08:23:45 +0200
Subject: [PATCH v6 00/16] nvmet: add target passthru commands support
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>

Hi Logan,

On 7/25/19 7:23 PM, Logan Gunthorpe wrote:
> Hi,
> 
> Chaitainya has asked us to take on these patches as we have an
> interest in getting them into upstream. To that end, we've done
> a large amount of testing, bug fixes and cleanup.
> 
> Passthru support for nvmet allows users to export an entire
> NVMe controller through NVMe-oF. When exported in this way (as opposed
> to exporting each namespace as a block device), all the NVMe commands
> are passed to the given controller unmodified, including most admin
> commands and Vendor Unique Commands (VUCs). A passthru target will
> expose all namespaces for a given device to the remote host.
> 
In general I'm very much in favour of this, yet there are some issues
which I'm not quite clear about.

> There are three major non-bugfix changes that we've done to the series:
> 
> 1) Instead of using a seperate special passthru subsystem in
>    configfs simply add a passthru directory that's analogous to
>    the existing namespace directories. The directories have
>    very similar attributes to namespaces but are mutually exclusive.
>    If a user enables a namespaces, they can't then enable
>    passthru controller and vice versa. This simplifies the code
>    required to implement passthru configfs and IMO creates a much
>    clearer and uniform interface.
> 
How do you handle subsystem naming?
If you enable the 'passthru' device, the (nvmet) subsystem (and its
name) is already created. Yet the passthru device will have its own
internal subsystem naming, so if you're not extra careful you'll end up
with a nvmet subsystem which doesn't have any relationship with the
passthru subsystem, making addressing etc ... tricky.
Any thoughts about that?

Similarly: how do you propose to handle multipath devices?
Any NVMe with several paths will be enabling NVMe multipathing
automatically, presenting you with a single multipathed namespace.
How will these devices be treated?
Will the multipathed namespace be used for passthru?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
