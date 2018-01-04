From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Jan 2018 11:35:46 +0100
Subject: [PATCH] nvme-pci: fix the timeout case when reset is ongoing
In-Reply-To: <1514932304-29936-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1514932304-29936-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180104103546.GA5109@lst.de>

On Wed, Jan 03, 2018@06:31:44AM +0800, Jianchao Wang wrote:
> NVME_CTRL_RESETTING used to indicate the range of nvme initializing
> strictly in fd634f41(nvme: merge probe_work and reset_work), but it
> is not now. The NVME_CTRL_RESETTING is set before queue the
> reset_work, there could be a big gap before the reset work handles
> the outstanding requests. So when the NVME_CTRL_RESETTING is set,
> nvme_timeout will not only meet the admin requests from the
> initializing procedure, but also the IO and admin requests from
> previous work before nvme_dev_disable is invoked.
> 
> To fix it, introduce a flag NVME_DEV_FLAG_INITIALIZING to mark the
> range of initializing. When this flag is not set, handle the expried
> requests as nvme_cancel_request. Otherwise, the requests should be
> from the initializing procedure. Handle them as before. Because the
> nvme_reset_work will see the error and disable the dev itself, so
> discard the nvme_dev_disable here.

Instead of a parallel set of states we'll need to split
NVME_CTRL_RESET into NVME_CTRL_RESET_SCHEDULED and NVME_CTRL_RESETTING.

And if my memory doesn't fail me we were already considering that a while
ago.
