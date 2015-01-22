From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 15:21:28 +0000 (UTC)
Subject: [PATCH 1/1] NVMe: Do not take nsid while a passthrough IO command
 is being issued via a block device file descriptor
In-Reply-To: <20150122084517.GA2093@infradead.org>
References: <1421886503-25276-1-git-send-email-yan@purestorage.com>
 <alpine.LNX.2.00.1501220035170.15481@localhost.lm.intel.com>
 <20150122084517.GA2093@infradead.org>
Message-ID: <alpine.LNX.2.00.1501221430040.15481@localhost.lm.intel.com>

On Thu, 22 Jan 2015, Christoph Hellwig wrote:
> On Thu, Jan 22, 2015@12:47:24AM +0000, Keith Busch wrote:
>> The IOCTL's purpose was to let someone submit completely arbitrary
>> commands on IO queues. This technically shouldn't even need a namespace
>> handle, but we don't have a request_queue associated to IO queues without
>> one like the admin queue has. In fact, we ought to fix that so we can
>> issue IO commands without namespaces.
>
> Honestly, this sounds like a horrible idea.  As namespaces aren't really
> any different from SCSI LUNs they should only be accessible through
> the device associated with the namespaces, and admin commands should
> only be allowed through the character device (if at all).

The case I considered was the "hidden" attribute in the NVMe LBA Range
Type feature. It only indicates the storage should be hidden from the OS
for general use, but the host may still use it for special purposes. In
truth, the driver doesn't handle the hidden attribute very well and it
doesn't seem like a well thought out feature in the spec anyway.

But if you really need to restrict namespace access, shouldn't that be
enforced on the target side with reservations or similar mechanism?

I agree on your last point. Admin commands through namespaces carried over
from before the management device existed, but removing it now will break
some customer tooling. There's probably a responsible way to migrate.

> For these security and usability reasons we did get rid of the
> SG_FLAG_LUN_INHIBIT flag in the SCSI passthrough interface, which
> allowed for similar horrible things in the distant past.
