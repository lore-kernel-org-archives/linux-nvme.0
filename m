From: marc@merlins.org (Marc MERLIN)
Date: Wed, 15 Feb 2017 08:04:48 -0800
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170215154649.GA30251@localhost.localdomain>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <c42e8e1e-f96f-9b2d-f3e6-72599430a327@grimberg.me>
 <20170215154649.GA30251@localhost.localdomain>
Message-ID: <20170215160448.fk3igep336tj5f3k@merlins.org>

On Wed, Feb 15, 2017@10:46:49AM -0500, Keith Busch wrote:
> On Wed, Feb 15, 2017@11:50:15AM +0200, Sagi Grimberg wrote:
> > How is this is something specific to nvme? What prevents this
> > for other multi-queue devices that shutdown during live IO?
> > 
> > Can you please describe the race in specific? Is it stuck on
> > nvme_ns_remove (blk_cleanup_queue)? If so, then I think we
> > might want to fix blk_cleanup_queue to start/drain/wait
> > instead?
> > 
> > I think it's acceptable to have drivers make their own use
> > of freeze_start and freeze_wait, but if this is not
> > nvme specific perhaps we want to move it to block instead?
> 
> There are many sequences that can get a request queue stuck forever, but
> the one that was initially raised is on a system suspend. It could look
> something like this:
> 
>   CPU A                       CPU B
>   -----                       -----
>   nvme_suspend
>    nvme_dev_disable           generic_make_request
>     nvme_stop_queues           blk_queue_enter
>      blk_queue_quiesce_queue    blk_mq_alloc_request
>                                  blk_mq_map_request
>                                   blk_mq_enter_live
>                                  blk_mq_run_hw_queue <-- the hctx is stopped,
>                                                          request is stuck until
>                                                          restarted.

Howdy,

Let me chime in here about how the stuck request thing is not just
theory, or made up :)

I first reported this in Aug 2016: https://patchwork.kernel.org/patch/9265695/

Long story short, I have been unable to upgrade to any kernel past 4.4
due to my M2 NVME drive. No matter what I did, S3 suspend would not
succeed or resume (as in ever, not just sometimes).

It's only until the last patch I got from Keith applied to 4.10
linux-block/for-next that I can _finally_ upgrade to a kernel past 4.4
and that suspend/resume works.

So while I don't have the knowledge to say whether Keith's patch is the
best way to fix my problem, it is the only thing I've seen that works in
the last 9 months, and has taken me from 100% failure to 0% failure so
far.

As a result, a big thanks to Keith again and thumbs up from me.

Hope this helps.
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                         | PGP 1024R/763BE901
