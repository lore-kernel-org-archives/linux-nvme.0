From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Wed, 19 Oct 2016 14:04:17 -0700
Subject: [PATCH v3 04/11] blk-mq: Introduce blk_mq_quiesce_queue()
In-Reply-To: <e42a952c-f245-eb39-d0a1-0336035573f9@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <e42a952c-f245-eb39-d0a1-0336035573f9@sandisk.com>
Message-ID: <0718ec72-d525-2e75-a123-3bf9ea129319@sandisk.com>

On 10/18/2016 02:50 PM, Bart Van Assche wrote:
> blk_mq_quiesce_queue() waits until ongoing .queue_rq() invocations
> have finished. This function does *not* wait until all outstanding
> requests have finished (this means invocation of request.end_io()).

(replying to my own e-mail)

The zero-day kernel test infrastructure reported to me that this patch 
causes a build failure with CONFIG_SRCU=n. Should I add "select SRCU" to 
block/Kconfig (excludes TINY_RCU) or should I rather modify this patch 
such that a mutex or rwsem is used instead of SRCU?

Thanks,

Bart.
