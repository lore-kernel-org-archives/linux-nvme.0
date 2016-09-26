From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Sep 2016 08:02:29 -0700
Subject: [PATCH 2/3] nvme-fabrics: set sqe.command_id in core not
 transports
In-Reply-To: <57e93219.xbYWGJXKaa4jLjGe%james.smart@broadcom.com>
References: <57e93219.xbYWGJXKaa4jLjGe%james.smart@broadcom.com>
Message-ID: <20160926150229.GA9220@infradead.org>

On Mon, Sep 26, 2016@07:35:05AM -0700, James Smart wrote:
> set sqe.command_id in core not transports
> 
> Prior patch updated to correct pci and loop transports
> 

The patch shows it was actually set both in the core and transport
before..  Either way, the patch looks fine, but I'd rewrite the
changelog before rewriting:

Reviewed-by: Christoph Hellwig <hch at lst.de>
