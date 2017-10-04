From: hch@lst.de (Christoph Hellwig)
Date: Wed, 4 Oct 2017 08:15:33 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
 <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
 <20171003115506.GC24650@lst.de>
 <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>
Message-ID: <20171004061533.GA20131@lst.de>

On Wed, Oct 04, 2017@07:42:00AM +0200, Hannes Reinecke wrote:
> Hmm. Not sure how you would be doing that. Who should be doing the
> claiming? Typically the claim is done whenever a device is created on
> top of the other...

We'd need a callback in the driver if it is claimed, and use that
to for propagating the claim, or use a shared struture to record the
claim.  I haven't looked into the details yet, though.

> What about an alternative plan: make creation of the subsystem device
> fully dynamic.
> But if a subsystem device is created it will always claim the underlying
> device. Then we can make the creation dependent on the NMIC attribute,
> and existing setups would not be affected.

This doesn't work because a lot of devices can just set NMIC.  E.g.
every namespace exported by the Linux NVMe target.
