From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 21 Jan 2016 16:55:42 +0200
Subject: [PATCH v3] NVMe: init nvme queue before enabling irq
In-Reply-To: <1453376445-23391-1-git-send-email-mail_weber_wang@163.com>
References: <1453376445-23391-1-git-send-email-mail_weber_wang@163.com>
Message-ID: <56A0F16E.20101@dev.mellanox.co.il>

Hi Wenbo,

> From: Wenbo Wang <wenbo.wang at memblaze.com>
>
> [v3] Do request irq in nvme_init_queue() to handle request irq failures
>
> There is one problem with the original patch. Since init queue happens
> before request irq, online_queue might be left increased if request irq
> fails. This version merges request irq into nvme_init_queue() because:
> 1. It solves the online_queue counting issue if request irq fails.
> 2. nvme_init_queue() is always followed by request irq, this change
>     simplifies code.
>
> This version also solves another possible race condition by moving
> adminq free irq before iounmap.
>
> [v2] Remove duplicate init code in nvme_alloc_queue()
>
> During reset process, the nvme_dev->bar (ioremapped) may change,
> so nvmeq->q_db shall be also updated by nvme_init_queue().
>
> [v1]
>
> Currently nvmeq irq is enabled before queue init, so a spurious
> interrupt triggered nvme_process_cq may access nvmeq->q_db just
> before it is updated, this could cause kernel panic.

So the patch changes should not appear in the change-log itself, its
meant for the reviewers. The change log should document the fix.

>
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>
> CC: stable at vger.kernel.org
> ---

Here (under the '---' separator) the patch vX changes should be
documented in the form:

Changes from v1:
- A2
- B2
- C2

Changes from v0:
- A1
- B1
- C1

This way git-am won't include it in the commit log message.

Other then that the patch itself looks fine,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
