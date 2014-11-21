From: keith.busch@intel.com (Keith Busch)
Date: Fri, 21 Nov 2014 15:52:08 +0000 (UTC)
Subject: [PATCH] NVMe: Reduce divide operations
In-Reply-To: <20141121135000.GQ11522@wil.cx>
References: <546E6784.6000609@micron.com> <20141121135000.GQ11522@wil.cx>
Message-ID: <alpine.LNX.2.00.1411211542000.4225@localhost.lm.intel.com>

On Fri, 21 Nov 2014, Matthew Wilcox wrote:
> We could further optimise it by knowing that we need 0 pages if the I/O
> is <= 8k in size:

I think that'll break if the first page has a non-zero offset, so
we'd have to allow the overestimate if we want to keep this function
simple. We could micro-optimize to return 0 if it's <= 4k, though.
