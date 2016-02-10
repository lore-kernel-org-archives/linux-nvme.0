From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 21:01:03 +0000
Subject: [PATCH for-4.5 03/13] NVMe: Allow request merges
In-Reply-To: <56BB8351.8040401@fb.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-4-git-send-email-keith.busch@intel.com>
 <20160210183627.GA7512@infradead.org> <56BB8351.8040401@fb.com>
Message-ID: <20160210210103.GB23402@localhost.localdomain>

On Wed, Feb 10, 2016@11:37:05AM -0700, Jens Axboe wrote:
> On 02/10/2016 11:36 AM, Christoph Hellwig wrote:
> >In general it is, but it might be good to try to understand
> >why this flag was set in the first place, and why the argument
> >for that isn't true anymore, or never was.
> 
> IIRC, it was set when the conversion to blk-mq happened, since the
> original driver could not do merges being bio based.

This actually carried over from when it was still bio-based. The flag
was set in the driver's initial commit, but should not have been.
