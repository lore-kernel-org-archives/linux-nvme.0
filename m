From: hch@lst.de (Christoph Hellwig)
Date: Tue, 22 May 2018 17:19:37 +0200
Subject: [RFC PATCH 1/3] blk-mq: Reference count request usage
In-Reply-To: <20180521231131.6685-2-keith.busch@intel.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-2-keith.busch@intel.com>
Message-ID: <20180522151937.GA18664@lst.de>

On Mon, May 21, 2018@05:11:29PM -0600, Keith Busch wrote:
> This patch adds a struct kref to struct request so that request users
> can be sure they're operating on the same request without it changing
> while they're processing it. The request's tag won't be released for
> reuse until the last user is done with it.

Can you please use a raw refcount_t instead of the kref?  That avoids
a possible indirect call in the fast path, which have become really
painful with the spectre mitigrations, and also is easier to follow
to start with.

I also think this should be merged into patch 3, as it isn't very
useful on its own.
