From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 1 Aug 2016 08:53:49 -0700
Subject: [RFC 6/7] NVMe: Use genalloc to allocate CMB regions
In-Reply-To: <1470034653-9097-7-git-send-email-haggaie@mellanox.com>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
 <1470034653-9097-7-git-send-email-haggaie@mellanox.com>
Message-ID: <20160801155348.GB23224@infradead.org>

On Mon, Aug 01, 2016@09:57:32AM +0300, Haggai Eran wrote:
> Register the CMB in a gen_pool dedicated to manage CMB regions. Use the
> pool to allocate the SQs to make sure they are registered.

And why would the NVMe driver care if "they are registered"?

Once we start allowing diverse CMB uses (what happened to Jon's patches
btw?) genalloc might be a good backend allocator, but without that
it's entirely pointless.  Also please don't introduce useless header
files.
