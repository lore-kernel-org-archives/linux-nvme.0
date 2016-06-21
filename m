From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 21 Jun 2016 09:22:52 -0500
Subject: Windows NVMeoF client - debug assistance requested
In-Reply-To: <ad34b8cf5ca544588b2d3fc9cc63fba0@bowex36e.micron.com>
References: <3286b6ca966947ff8aca316b5ab56435@bowex36e.micron.com>
 <005401d1cbc4$b263ab80$172b0280$@opengridcomputing.com>
 <ad34b8cf5ca544588b2d3fc9cc63fba0@bowex36e.micron.com>
Message-ID: <007201d1cbc8$65846c10$308d4430$@opengridcomputing.com>


> 
> Similar problems?  What kind of problems.
>

The same, I think.  From me in an earlier private email:

> > When using nvmf-all.2 branch from infradead, I can discover/connect ok to
> > a target, but when I do an mkfs.ext4 on the nvmf device, it succeeds, but
> > the data isn't written to the device.  So a subsequent mount will fail.  I
> > backed up to nvmf-all branch, and it works fine.

Christoph provided me a patch to include, and I think it is here in nvmf-all.3:

commit bb18f6e76300970383d66dbc17936b854f6d79e6
Author: Christoph Hellwig <hch at lst.de>
Date:   Tue Jun 14 09:27:53 2016 +0200

    nvmet: more fixups for the op vs flags split

    Signed-off-by: Christoph Hellwig <hch at lst.de>

I didn't try .2 + just this fix, because .3 popped out and went to that version.



Steve.
