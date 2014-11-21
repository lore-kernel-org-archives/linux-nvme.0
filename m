From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 21 Nov 2014 12:14:04 -0500
Subject: [PATCH] NVMe: Reduce divide operations
In-Reply-To: <alpine.LNX.2.00.1411211542000.4225@localhost.lm.intel.com>
References: <546E6784.6000609@micron.com> <20141121135000.GQ11522@wil.cx>
 <alpine.LNX.2.00.1411211542000.4225@localhost.lm.intel.com>
Message-ID: <20141121171404.GR11522@wil.cx>

On Fri, Nov 21, 2014@03:52:08PM +0000, Keith Busch wrote:
> On Fri, 21 Nov 2014, Matthew Wilcox wrote:
> >We could further optimise it by knowing that we need 0 pages if the I/O
> >is <= 8k in size:
> 
> I think that'll break if the first page has a non-zero offset, so
> we'd have to allow the overestimate if we want to keep this function
> simple. We could micro-optimize to return 0 if it's <= 4k, though.

Yes, sorry, you're right.
