From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 21:10:26 +0000
Subject: [PATCH for-4.5 13/13] NVMe: Rate limit nvme IO warnings
In-Reply-To: <20160210185404.GB10459@infradead.org>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-14-git-send-email-keith.busch@intel.com>
 <20160210185404.GB10459@infradead.org>
Message-ID: <20160210211025.GC23402@localhost.localdomain>

On Wed, Feb 10, 2016@10:54:04AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 10, 2016@11:17:30AM -0700, Keith Busch wrote:
> > We don't need to spam the kernel logs with thousands of messages. We
> > can infer all IO's are being cancelled with fewer messages.
> 
> Do we need this message at all?

I don't find it useful for anything other than confirming a test hit
that path. Delete it?
