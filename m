From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 17 Jan 2018 18:17:32 +0800
Subject: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
In-Reply-To: <cd8ebf2d-3215-d1a2-7fce-54f1590e41e3@de.ibm.com>
References: <20180116121010.GA26429@ming.t460p>
 <7c24e321-2d3b-cdec-699a-f58c34300aa9@oracle.com>
 <20180116153248.GA3018@ming.t460p>
 <7f5bad86-febc-06fc-67c0-393777d172e4@oracle.com>
 <20180117035159.GA9487@ming.t460p>
 <8c8efce8-ea02-0a9e-8369-44c885f4731d@oracle.com>
 <20180117062251.GC9487@ming.t460p>
 <977e9c62-c7f2-d1df-7d6b-5903f3b21cb6@oracle.com>
 <20180117095744.GF9487@ming.t460p>
 <cd8ebf2d-3215-d1a2-7fce-54f1590e41e3@de.ibm.com>
Message-ID: <20180117101731.GG9487@ming.t460p>

On Wed, Jan 17, 2018@11:07:48AM +0100, Christian Borntraeger wrote:
> 
> 
> On 01/17/2018 10:57 AM, Ming Lei wrote:
> > Hi Jianchao,
> > 
> > On Wed, Jan 17, 2018@04:09:11PM +0800, jianchao.wang wrote:
> >> Hi ming 
> >>
> >> Thanks for your kindly response.
> >>
> >> On 01/17/2018 02:22 PM, Ming Lei wrote:
> >>> This warning can't be removed completely, for example, the CPU figured
> >>> in blk_mq_hctx_next_cpu(hctx) can be put on again just after the
> >>> following call returns and before __blk_mq_run_hw_queue() is scheduled
> >>> to run.
> >>>
> >>> 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work, msecs_to_jiffies(msecs))
> >> We could use cpu_active in __blk_mq_run_hw_queue() to narrow the window.
> >> There is a big gap between cpu_online and cpu_active. rebind_workers is also between them.
> > 
> > This warning is harmless, also you can't reproduce it without help of your
> > special patch, I guess, :-) So the window shouldn't be a big deal. 
> 
> FWIW, every WARN_ON is problematic since there are people running with panic_on_warn.
> If a condition can happen we should not use WARN_ON but something else.

Agree, printk() should be fine, IMO.


-- 
Ming
