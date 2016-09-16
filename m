From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 12:10:16 +0200
Subject: [PATCH RFC 00/21] blk-mq: Introduce combined hardware queues
In-Reply-To: <20160916092743.GA5079@infradead.org>
References: <cover.1474014910.git.agordeev@redhat.com>
 <20160916092743.GA5079@infradead.org>
Message-ID: <20160916101015.GD2476@agordeev.lab.eng.brq.redhat.com>

On Fri, Sep 16, 2016@02:27:43AM -0700, Christoph Hellwig wrote:
> Hi Alex,
> 
> this clashes badly with the my queue mapping rework that went into
> Jens tree recently.

Yeah, I fully aware the RFC-marked patches would clash with your
works. I will surely rework them if the proposal considered worthwhile.

> But in the meantime: there seem to be lots of little bugfixes and
> cleanups in the series, any chance you could send them out as a first
> series while updating the rest?

[He-he :) I can even see you removed map_queue() as well]
I will rebase the cleanups on top of your tree.

> Also please Cc the linux-block list for block layer patches that don't
> even seem to touch the nvme driver.

Just wanted let NVMe people know, as this h/w is presumably main
beneficiary.

Thanks!
