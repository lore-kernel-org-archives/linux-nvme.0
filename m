From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 12 Feb 2018 20:37:48 +0200
Subject: [PATCH RESENT] nvme-pci: suspend queues based on online_queues
In-Reply-To: <1518440713-1031-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518440713-1031-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <5011398b-8797-ece6-9df0-436c32aed33e@grimberg.me>


> nvme cq irq is freed based on queue_count. When the sq/cq creation
> fails, irq will not be setup. free_irq will warn 'Try to free
> already-free irq'.
> 
> To fix it, we only increase online_queues when adminq/sq/cq are
> created and associated irq is setup. Then suspend queues based
> on online_queues.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>

Can I get a review for this?
