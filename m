From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 10 Jul 2016 02:47:00 -0700
Subject: [PATCHv3 for-4.7] nvme: Remove RCU namespace protection
In-Reply-To: <20160709010754.GA28997@localhost.localdomain>
References: <1467825770-27355-1-git-send-email-keith.busch@intel.com>
 <20160709010754.GA28997@localhost.localdomain>
Message-ID: <20160710094700.GA5897@infradead.org>

On Fri, Jul 08, 2016@09:07:55PM -0400, Keith Busch wrote:
> On Wed, Jul 06, 2016@11:22:50AM -0600, Keith Busch wrote:
> > We can't block with RCU read lock held, but we need to do potentially
> > blocking stuff to namespace queues when iterating the list. This patch
> > removes the rcu read locking.
> > 
> > Any list iteration that does IO has to be done unlocked to allow recovery.
> > The caller must ensure the list can not be manipulated under such
> > conditions. List iterations that do not issue IO can safely use the lock
> > since it wouldn't block recovery from missing IO completions.
> 
> Ping? Would hate to release a kernel with obvious bugs.

Where are the other two patches from this series?
