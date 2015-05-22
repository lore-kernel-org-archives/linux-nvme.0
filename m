From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 May 2015 17:36:12 +0000 (UTC)
Subject: [PATCH 9/9] nvme: submit internal commands through the block layer
In-Reply-To: <1432285966-31770-10-git-send-email-hch@lst.de>
References: <1432285966-31770-1-git-send-email-hch@lst.de>
 <1432285966-31770-10-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1505221731500.15930@localhost.lm.intel.com>

On Fri, 22 May 2015, Christoph Hellwig wrote:
> -		req->errors = nvme_error_status(status);
> +		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
> +			req->sense_len = le32_to_cpup(&cqe->result);
> +			req->errors = status;
> +		} else {
> +			req->errors = nvme_error_status(status);
> +		}

The "sense_len" is now the command result, but it's getting set only in
the error case, so the initial set features for number of queues gets
the wrong result; the driver creates only one IO queue when I wanted a
lot more.
