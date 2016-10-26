From: axboe@fb.com (Jens Axboe)
Date: Wed, 26 Oct 2016 17:28:55 -0600
Subject: [PATCH v4 0/12] Fix race conditions related to stopping block
 layer queues
In-Reply-To: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
Message-ID: <529affae-3470-b1ae-8873-35de53628e8c@fb.com>

On 10/26/2016 04:49 PM, Bart Van Assche wrote:
> Hello Jens,
>
> Multiple block drivers need the functionality to stop a request queue
> and to wait until all ongoing request_fn() / queue_rq() calls have
> finished without waiting until all outstanding requests have finished.
> Hence this patch series that introduces the blk_mq_quiesce_queue()
> function. The dm-mq, SRP and NVMe patches in this patch series are three
> examples of where these functions are useful. These patches have been
> tested on top of kernel v4.9-rc1. The following tests have been run to
> verify this patch series:
> - Mike's mptest suite that stress-tests dm-multipath.
> - My own srp-test suite that stress-tests SRP on top of dm-multipath.
> - fio on top of the NVMeOF host driver that was connected to the NVMeOF
>   target driver on the same host.
> - Laurence verified the previous version (v3) of this patch series by
>   running it through the Red Hat SRP and NVMe test suites.

This looks pretty good, I'll run some testing on it tomorrow and do a
full review, hopefully we can get it applied sooner rather than later
for the next series.

-- 
Jens Axboe
