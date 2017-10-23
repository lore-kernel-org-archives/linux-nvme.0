From: hch@lst.de (Christoph Hellwig)
Date: Mon, 23 Oct 2017 10:23:45 +0200
Subject: [PATCH] nvme-rdma: fix possible hang when issuing commands
 during ctrl removal
In-Reply-To: <1508697771-3552-1-git-send-email-sagi@grimberg.me>
References: <1508697771-3552-1-git-send-email-sagi@grimberg.me>
Message-ID: <20171023082345.GA19156@lst.de>

On Sun, Oct 22, 2017@09:42:51PM +0300, Sagi Grimberg wrote:
>  			/*
> +			 * deleting state means that the ctrl will never accept
> +			 * commands again, fail it permanently.
> +			 */
> +			if (queue->ctrl->ctrl.state == NVME_CTRL_DELETING) {
> +				nvme_req(rq)->status = NVME_SC_ABORT_REQ;
> +				return BLK_STS_IOERR;

What does the NVME_SC_ABORT_REQ buy us here compared to just returning
BLK_STS_IOERR as in the reconnecting case?  Why can't we just merge the
two cases?
