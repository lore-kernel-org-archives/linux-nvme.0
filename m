From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Nov 2018 13:39:02 -0700
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
In-Reply-To: <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
Message-ID: <20181130203901.GA11193@localhost.localdomain>

On Fri, Nov 30, 2018@01:36:09PM -0700, Jens Axboe wrote:
> On 11/30/18 1:26 PM, Keith Busch wrote:
> > A driver may wish to iterate every tagged request, not just ones that
> > satisfy blk_mq_request_started(). The intended use is so a driver may
> > terminate entered requests on quiesced queues.
> 
> How about we just move the started check into the handler passed in for
> those that care about it? Much saner to make the interface iterate
> everything, and leave whatever state check to the callback.

I agree that's better. I initially didn't want to examine all the users
but looks like only 4 drivers using the current tagset iterator, so
that's not too daunting. I'll give it a look.
