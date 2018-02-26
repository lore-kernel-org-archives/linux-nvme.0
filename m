From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Feb 2018 08:58:30 -0700
Subject: [PATCH V2] nvme-pci: set cq_vector to -1 if io queue setup fails
In-Reply-To: <1518693221-2430-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518693221-2430-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180226155829.GA10832@localhost.localdomain>

On Thu, Feb 15, 2018@07:13:41PM +0800, Jianchao Wang wrote:
> nvme cq irq is freed based on queue_count. When the sq/cq creation
> fails, irq will not be setup. free_irq will warn 'Try to free
> already-free irq'.
> 
> To fix it, set the nvmeq->cq_vector to -1, then nvme_suspend_queue
> will ignore it.

Applied with updates to change log and removing the miscellaneous white
space changes.
