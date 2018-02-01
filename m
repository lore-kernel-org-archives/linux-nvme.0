From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Feb 2018 14:28:19 -0700
Subject: [PATCHv2 2/2] block: Handle merging discards in IO schedulers
In-Reply-To: <d2b2eb11-fb1c-91a9-604b-d2dddac88a45@kernel.dk>
References: <20180201203158.24761-1-keith.busch@intel.com>
 <20180201203158.24761-3-keith.busch@intel.com>
 <d2b2eb11-fb1c-91a9-604b-d2dddac88a45@kernel.dk>
Message-ID: <20180201212818.GE24417@localhost.localdomain>

On Thu, Feb 01, 2018@02:02:14PM -0700, Jens Axboe wrote:
> On 2/1/18 1:31 PM, Keith Busch wrote:
> > This adds support for merging discard requests in all IO schedulers.
> 
> As per my last email, some of these aren't correct. Only the
> blk-mq-sched change is correct/useful, so we should just do that
> separately.

Sorry, I got ahead of myself with this one.
