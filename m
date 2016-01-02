From: keith.busch@intel.com (Keith Busch)
Date: Sat, 2 Jan 2016 21:30:09 +0000
Subject: [PATCH 5/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160102170730.GA30184@infradead.org>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-6-git-send-email-keith.busch@intel.com>
 <20151230180430.GA12828@infradead.org>
 <20151230190706.GC12454@localhost.localdomain>
 <20160102170730.GA30184@infradead.org>
Message-ID: <20160102213008.GA10969@localhost.localdomain>

On Sat, Jan 02, 2016@09:07:30AM -0800, Christoph Hellwig wrote:
> Just curious:  why do we even both with the async queue shutdown.  At
> least the controllers I have access to complete queue deletions very
> quickly.

The async deletion was written for a bug reporting "hang" on a device
removal. The "hang" was the controller taking on the order of 100's msec
to delete a queue (sometimes >1sec if lots of commands queued). This
controller had 2k queues, and took ~15 minutes to remove serially. Async
deletion brought it down to ~20 seconds, so looked like a good idea.

It wasn't a controller I make, so I personally don't care about
parallelizing queue deletion. The driver's been this way for so long
though, I don't have a good way to know how beneficial this feature
is anymore.
