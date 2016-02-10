From: axboe@fb.com (Jens Axboe)
Date: Wed, 10 Feb 2016 11:37:05 -0700
Subject: [PATCH for-4.5 03/13] NVMe: Allow request merges
In-Reply-To: <20160210183627.GA7512@infradead.org>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-4-git-send-email-keith.busch@intel.com>
 <20160210183627.GA7512@infradead.org>
Message-ID: <56BB8351.8040401@fb.com>

On 02/10/2016 11:36 AM, Christoph Hellwig wrote:
> On Wed, Feb 10, 2016@11:17:20AM -0700, Keith Busch wrote:
>> It is generally more efficient to submit larger IO.
>
> In general it is, but it might be good to try to understand
> why this flag was set in the first place, and why the argument
> for that isn't true anymore, or never was.

IIRC, it was set when the conversion to blk-mq happened, since the 
original driver could not do merges being bio based.

-- 
Jens Axboe
