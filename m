From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 22 Jun 2016 14:31:10 -0600
Subject: [PATCH 0/2] Get rid of transport layer retry count config
 parameter
In-Reply-To: <20160622161559.GA18361@infradead.org>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
 <20160622161559.GA18361@infradead.org>
Message-ID: <20160622203110.GA20838@obsidianresearch.com>

On Wed, Jun 22, 2016@09:15:59AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 22, 2016@03:05:59PM +0300, Sagi Grimberg wrote:
> > This parameter was added in order to support a proper timeout for
> > error recovery before the spec defined a periodic keep-alive.
> > 
> > Now that we have periodic keep-alive, we don't need a user configurable
> > transport layer retry count, the keep-alive timeout is sufficient,
> > transports can retry for as long as they see fit.
> 
> Isn't there some IB protocol level rationale for a low retry count
> in various fabric setups?

IIRC the retry count is part of what drives the APM switch over, so
APM configuration should use a lower value.

Jason
