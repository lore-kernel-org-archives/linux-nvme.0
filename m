From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 30 Nov 2018 13:36:09 -0700
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
In-Reply-To: <20181130202635.11145-1-keith.busch@intel.com>
References: <20181130202635.11145-1-keith.busch@intel.com>
Message-ID: <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>

On 11/30/18 1:26 PM, Keith Busch wrote:
> A driver may wish to iterate every tagged request, not just ones that
> satisfy blk_mq_request_started(). The intended use is so a driver may
> terminate entered requests on quiesced queues.

How about we just move the started check into the handler passed in for
those that care about it? Much saner to make the interface iterate
everything, and leave whatever state check to the callback.

-- 
Jens Axboe
