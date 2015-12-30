From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Dec 2015 17:56:58 +0000
Subject: [PATCH 1/5] NVMe: Fix admin queue ring wrap
In-Reply-To: <20151230174954.GB21400@infradead.org>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-2-git-send-email-keith.busch@intel.com>
 <20151230174954.GB21400@infradead.org>
Message-ID: <20151230175658.GB22501@localhost.localdomain>

On Wed, Dec 30, 2015@09:49:54AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 30, 2015@10:27:47AM -0700, Keith Busch wrote:
> > The tag set queue depth needs to be one less than the h/w queue depth
> > so we don't wrap the circular buffer. This conforms to the specification
> > defined "Full Queue" condition.
> 
> You'll need to change NVME_AQ_DEPTH to make sure the magic for the
> AEN commands still work.

It'll still work. The command id is just a cookie to the controller,
and the AEN command id is still higher than the highest request "tag",
so the logic all works.
 
> But can you explain the actual issue a little more while we're at it?
> Preferably in a comment in the code!

Our admin queue depth is fixed to 256. We reserve one for AEN, so the
depth we told blk-mq is 255. If we use all 255 tags, plus the special one
for AEN, we wrapped the queue. In practice, it is unlikely you're going
to use up 255 admin tags, so I don't think it's a condition frequently
tested, but we need to tell blk-mq to use only 254 tags instead.
