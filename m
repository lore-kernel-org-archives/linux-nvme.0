From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 19 Sep 2017 15:52:37 +0000
Subject: [PATCH 1/5] block: don't call blk_mq_delay_run_hw_queue() in case
 of BLK_STS_RESOURCE
In-Reply-To: <20170919154823.GA22809@redhat.com>
References: <20170915164456.9803-1-ming.lei@redhat.com>
 <20170915164456.9803-2-ming.lei@redhat.com>
 <1505498249.3420.15.camel@wdc.com> <20170917124000.GB6289@ming.t460p>
 <1505747894.2685.6.camel@wdc.com> <20170919054308.GA2517@ming.t460p>
 <20170919154823.GA22809@redhat.com>
Message-ID: <1505836356.2671.21.camel@wdc.com>

On Tue, 2017-09-19@11:48 -0400, Mike Snitzer wrote:
> This thread proves that it is definitely brittle to be relying on fixed
> delays like this:
> https://patchwork.kernel.org/patch/9703249/

Hello Mike,

Sorry but I think that's a misinterpretation of my patch. I came up with that
patch before I had found and fixed the root cause of the high system load.
These fixes are upstream (kernel v4.13) which means that that patch is now
obsolete.

Bart.
