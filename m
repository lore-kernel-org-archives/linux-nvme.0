From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 16 Feb 2017 06:26:21 -0800
Subject: [dm-devel] hch's native NVMe multipathing [was: Re: [PATCH 1/2]
 Don't blacklist nvme]
In-Reply-To: <20170216025357.GA9241@redhat.com>
References: <1487107154-24883-1-git-send-email-keith.busch@intel.com>
 <20170215145617.GA4241@infradead.org>
 <20170216025357.GA9241@redhat.com>
Message-ID: <20170216142621.GA21972@infradead.org>

On Wed, Feb 15, 2017@09:53:57PM -0500, Mike Snitzer wrote:
> going to LSF/MM?).  Yet you're expecting to just drop it into the tree
> without a care in the world about the implications.

I am planning to post it for comments, and then plan to "drop it in the
tree" exactly because I think of the implications.

Keith did that.  But once we already do the discovery of the path
relations in the transport (e.g scsi_dh) we can just move the path
selectors (for which I'm reusing the DM code anyway btw) and the
bouncing of I/O to the block layer and cut out the middle man.

The main reason is that things will just work (TM) instead of having
to carry around additional userspace to configure a an unneded
additional device layer that just causes confusion.  Beyond the
scsi_dh equivalent there is basically no new code in nvme, just a little
new code in the block layer, and a move of the path selectors from dm
to the block layer.  I would not call this fragmentation.

Anyway, there is very little point in having an abstract discussion
here, I'll try to get the code ready ASAP, although until the end of
next week I'm really pressed with other deadlines.
