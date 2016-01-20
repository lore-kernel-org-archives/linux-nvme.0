From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 20 Jan 2016 14:34:43 +0200
Subject: [PATH v2] NVMe: init nvme queue before enabling irq
In-Reply-To: <1453286915-18814-1-git-send-email-mail_weber_wang@163.com>
References: <1453286915-18814-1-git-send-email-mail_weber_wang@163.com>
Message-ID: <569F7EE3.1020504@dev.mellanox.co.il>


> From: Wenbo Wang <wenbo.wang at memblaze.com>
>
> During reset process, the nvme_dev->bar (ioremapped) may change,
> so nvmeq->q_db shall be also updated by nvme_init_queue().
>
> Currently nvmeq irq is enabled before queue init, so a spurious
> interrupt triggered nvme_process_cq may access nvmeq->q_db just
> before it is updated, this could cause kernel panic.
>
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>

You should add Cc: stable at vger.kernel.org here,
git-send-email will take care of the CC for you.
