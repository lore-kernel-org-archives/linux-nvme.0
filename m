From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 22 Jun 2016 09:15:59 -0700
Subject: [PATCH 0/2] Get rid of transport layer retry count config
 parameter
In-Reply-To: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160622161559.GA18361@infradead.org>

On Wed, Jun 22, 2016@03:05:59PM +0300, Sagi Grimberg wrote:
> This parameter was added in order to support a proper timeout for
> error recovery before the spec defined a periodic keep-alive.
> 
> Now that we have periodic keep-alive, we don't need a user configurable
> transport layer retry count, the keep-alive timeout is sufficient,
> transports can retry for as long as they see fit.

Isn't there some IB protocol level rationale for a low retry count
in various fabric setups?
