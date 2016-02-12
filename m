From: keith.busch@intel.com (Keith Busch)
Date: Fri, 12 Feb 2016 15:24:48 +0000
Subject: [PATCHv2-4.5 00/10] NVMe fixes
In-Reply-To: <20160212083508.GA18432@infradead.org>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <20160211222848.GA19595@localhost.localdomain>
 <56BD0D4A.60003@fb.com> <20160212083508.GA18432@infradead.org>
Message-ID: <20160212152447.GA24020@localhost.localdomain>

On Fri, Feb 12, 2016@12:35:08AM -0800, Christoph Hellwig wrote:
> Argg - some of these including the namespace removal changes absolutely
> move into the wrong direction.  I've just been busy reviewing the easier
> parts first before coming up with better ways for those.

Fair enough. I know you're busy in many other areas as well, so I
appreciate the time you've provided.

To the task at hand, this started out to fix a hot-plug regression (is
there any other kind?). More poking revealed other cracks, some of which
are pretty obscure that probably never worked, but still scrambling to
fix before the release anyway.

I'm not trying to significantly alter the design, but I think you're
saying these bolted on fixes are not helping long term. More focus is
moving to Fabrics, so I really want to get this one PCI feature working
before that happens. If you have something in the right direction that
will also help the current cycle, I can wait for when you're ready to
share that.
