From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Mon, 06 Oct 2014 19:20:59 +0100
Subject: nvme_alloc_iod for discard requests
Message-ID: <5432DD8B.7050404@ranbarg.com>

Hi All,

A quick question/observation on the driver as in the 3.17 sources.

in nvme_submit_bio_queue we call nvme_alloc_iod passing in the size of
the request from the bio, so that the correct amount of space for the
PRPs can be allocated.
However, if this is a discard request, this size can be large, but I
think only the first entry is needed, as we use an entry from the
prp_small_pool, which holds the range.
Is there a reason why we don't just allocate a single entry for discard
operations?

I'm asking this as I am seeing an issue where we are trying to allocate
an order 3 atomic request, but the system does not have enough
contiguous atomic memory to complete the call and I believe the request
is actually a discard operation. This is not fatal, but it would be good
to remove the large allocation if it is not needed.

Thanks.
