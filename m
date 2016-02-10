From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 18:24:17 +0000
Subject: [PATCH for-4.5 04/13] NVMe: Set queue limits max_dev_sectors
In-Reply-To: <20160210182051.GA28235@infradead.org>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-5-git-send-email-keith.busch@intel.com>
 <20160210182051.GA28235@infradead.org>
Message-ID: <20160210182416.GC32064@localhost.localdomain>

On Wed, Feb 10, 2016@10:20:51AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 10, 2016@11:17:21AM -0700, Keith Busch wrote:
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> 
> why?

Ah, missing change log here.

It is so the queue limits will be correct. The max_hw_sectors will be
wrong without this.
