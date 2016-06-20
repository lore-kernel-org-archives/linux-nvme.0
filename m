From: kernel@jbeekman.nl (Jethro Beekman)
Date: Mon, 20 Jun 2016 11:21:09 -0700
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
In-Reply-To: <20160620152639.GD12936@localhost.localdomain>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
 <20160620152639.GD12936@localhost.localdomain>
Message-ID: <57683415.1060202@jbeekman.nl>

On 20-06-16 08:26, Keith Busch wrote:
> On Sun, Jun 19, 2016@04:06:31PM -0700, Jethro Beekman wrote:
>> If an NVMe drive is locked with ATA Security, most commands sent to the drive 
>> will fail. This includes commands sent by the kernel upon discovery to probe 
>> for partitions. The failing happens in such a way that trying to do anything 
>> with the drive (e.g. sending an unlock command; unloading the nvme module) is 
>> basically impossible with the high default command timeout.
> 
> Why is the timeout a factor here? Is it because the error your drive
> returns does not have DNR set and goes through 30 seconds of retries?

I looked into this but couldn't figure out where DNR's were being handled. Upon
closer inspection, I suppose I could add some debug code in nvme_complete_rq.

> If so, I think we should probably have a limited retry count instead of
> unlimited retries within the command timeout.

Would this just be a matter of setting req->retries and checking for it in
nvme_req_needs_retry? How does one keep track of the number of tries so far?

>> This patch adds a check to see if the drive is locked, and if it is, its 
>> namespaces are not initialized. It is expected that userspace will send the 
>> proper "security send/unlock" command and then reset the controller. Userspace 
>> tools are available at [1].
> 
> Aren't these security settings per-namespace rather than the entire device?

You're right, I assumed that admin commands can't have namespace ids, but
looking at the spec, that's not the case. Turns out there's a problem with the
driver then: nvme_ioctl never includes the ns for NVME_IOCTL_ADMIN_CMD. I'll fix
this and the above suggestion. Hopefully that also obviates the need for the
nvme_scan_namespaces code path, otherwise we'll have to rethink how to do this.

>> I intend to also submit a future patch that tracks ATA Security commands sent 
>> from userspace and remembers the password so it can be submitted to a locked 
>> drive upon pm_resume. (still WIP)
> 
> This subjects the system to various attacks like cold boot or hotswap,
> but that's what users want!

Yes. Unfortunately I couldn't think of a sane way to have userspace prompt for
the password on resume with a non-functional drive. Current BIOS implementations
generally also just unlock this way. I do intend to use the keyring API.

The effects of a hotswap can be partially mitigated by "salting" the password
with the drive serial number [1]. For maximum effect the kernel would check to
see if the drive SN has changed before resending the password, I'm not sure if
we want this extra complexity in the kernel though.

[1] https://jbeekman.nl/blog/2015/03/lenovo-thinkpad-hdd-password/

> This is ATA security, though, so wouldn't ATA also benefit from this? The
> payload setup/decoding should then go in a generic library for everyone.
> 
> Similar was said about the patch adding OPAL security to the NVMe driver:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2016-April/004428.html

Yes this would benefit from being generic. I actually looked whether this
already existed in the kernel and was surprised that it didn't. I suppose most
people using this functionality depend on their BIOS to handle everything. I
will contact Rafael to see we can come up with some generic drive security state
tracker.

Jethro
