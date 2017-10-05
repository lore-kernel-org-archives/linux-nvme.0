From: hch@lst.de (Christoph Hellwig)
Date: Thu, 5 Oct 2017 16:47:38 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <6e9b4ef9-c88a-d8b0-1ae7-16e8403e60df@suse.com>
References: <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
 <20171003115506.GC24650@lst.de>
 <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>
 <20171004061533.GA20131@lst.de>
 <19dbdf11-86c4-b6ea-a18c-a78fcae822d5@suse.de>
 <20171004071312.GA21143@lst.de> <yq1poa2wgd2.fsf@oracle.com>
 <20171005065124.h5t3gtufptevja4s@linux-x5ow.site>
 <20171005140525.GB2384@localhost.localdomain>
 <6e9b4ef9-c88a-d8b0-1ae7-16e8403e60df@suse.com>
Message-ID: <20171005144738.GA28996@lst.de>

On Thu, Oct 05, 2017@04:39:23PM +0200, Hannes Reinecke wrote:
> I'm fine with having individual char devs for the controller and the
> namespaces. That was the plan anyway, and they don't get into play with
> systemd et al.

How hardcoded is the assumption that /dev/nvmeX is the chardev for
/dev/nvmeXn*?

I thought that was quite deep and thus would want to keep /dev/nvmeX
as a multipathed devices (maybe some lightweight multipathing, aka
always go to the first controller) and then have another chardev
like /dev/nvmeXpN or /dev/nvmeXcN for each controller?
