From: hch@lst.de (Christoph Hellwig)
Date: Fri, 4 Nov 2016 01:01:11 +0100
Subject: [PATCH] nvmet: Don't queue fatal error work if csts.cfs is set
In-Reply-To: <1478207842-27774-1-git-send-email-sagi@grimberg.me>
References: <1478207842-27774-1-git-send-email-sagi@grimberg.me>
Message-ID: <20161104000111.GA14022@lst.de>

>  {
> -	ctrl->csts |= NVME_CSTS_CFS;
> +	if (test_and_set_bit(NVME_CSTS_CFS, (unsigned long *)&ctrl->csts))
> +		return;
> +

This can't work - test_and_set_bit takes a bit index and NVME_CSTS_CFS
is the actual value.  I think we'll need a lock to protect ->csts
instead.
