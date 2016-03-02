From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Mar 2016 22:42:17 +0000
Subject: [PATCH] block: Initialize max_dev_sectors to 0
In-Reply-To: <20160301151951.GA21997@infradead.org>
References: <1455148367-25208-1-git-send-email-keith.busch@intel.com>
 <56BCA6F4.6030807@fb.com> <20160301151951.GA21997@infradead.org>
Message-ID: <20160302224216.GF27636@localhost.localdomain>

On Tue, Mar 01, 2016@07:19:51AM -0800, Christoph Hellwig wrote:
> Btw, I think we also needs this for 4.4-stable, especially as it's
> going to be a long term release.

Agreed, I even received bug reports this week for this issue from
folks using 4.4-stable at the NVMe plugfest. I posted this patch to the
stable list.
