From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 21 Feb 2016 08:17:14 -0800
Subject: [PATCH-4.5-v3 2/5] NVMe: Fix namespace removal deadlock
In-Reply-To: <1455734215-20396-3-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-3-git-send-email-keith.busch@intel.com>
Message-ID: <20160221161714.GB21896@infradead.org>

On Wed, Feb 17, 2016@11:36:52AM -0700, Keith Busch wrote:
> This patch makes nvme namespace removal lockless. It is up to the caller
> to ensure no active namespace scanning is occuring.

I wonder if it wouldn't be safer in the long run if we just switch
to RCU locking - that way we don't need any locks in the readers, they
can just grab a reference under rcu_read_lock(), and we don't need to
rely in implicit serialization for the updaters.
