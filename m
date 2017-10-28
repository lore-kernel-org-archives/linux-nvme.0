From: hch@lst.de (Christoph Hellwig)
Date: Sat, 28 Oct 2017 08:20:41 +0200
Subject: [PATCH 17/17] nvme: also expose the namespace identification
 sysfs files for mpath nodes
In-Reply-To: <ab2161cc-aa24-4137-8a68-08e63adce764@suse.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-18-hch@lst.de>
 <ab2161cc-aa24-4137-8a68-08e63adce764@suse.de>
Message-ID: <20171028062041.GC13723@lst.de>

On Tue, Oct 24, 2017@09:45:44AM +0200, Hannes Reinecke wrote:
> device_add_disk_with_groups()?
> What happened to that proposal?

Doesn't look like it got anywhere near a tree I could base this work
on.

And what happen to not fullquoting a patch for a two line comment?
