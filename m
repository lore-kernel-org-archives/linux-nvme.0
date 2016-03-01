From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 1 Mar 2016 07:19:51 -0800
Subject: [PATCH] block: Initialize max_dev_sectors to 0
In-Reply-To: <56BCA6F4.6030807@fb.com>
References: <1455148367-25208-1-git-send-email-keith.busch@intel.com>
 <56BCA6F4.6030807@fb.com>
Message-ID: <20160301151951.GA21997@infradead.org>

On Thu, Feb 11, 2016@08:21:24AM -0700, Jens Axboe wrote:
> On 02/10/2016 04:52 PM, Keith Busch wrote:
> >The new queue limit is not used by the majority of block drivers, and
> >should be initialized to 0 for the driver's requested settings to be used.
> 
> That's much better, thanks.

Btw, I think we also needs this for 4.4-stable, especially as it's
going to be a long term release.
