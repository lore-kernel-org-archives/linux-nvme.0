From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Nov 2015 18:57:31 +0000
Subject: [PATCH 09/12] nvme: properly free resources for cancelled command
In-Reply-To: <1446885906-20967-10-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-10-git-send-email-hch@lst.de>
Message-ID: <20151109185731.GB5386@localhost.localdomain>

On Sat, Nov 07, 2015@09:45:03AM +0100, Christoph Hellwig wrote:
> +	if (unlikely(req->errors)) {
> +		/*
> +		 * Some silly Intel userspace code breaks if it doesn't get a
> +		 * negative errno back for driver returns values.
> +		 */

Whoa now, it's neither Intel nor userpace that needs this. It's to know
if the controller is unresponsive or returned an error. The difference
matters to the driver for initialization.

> +		if (req->errors < 0) {
> +			error = req->errors;
> +		} else {
> +			if (nvme_req_needs_retry(req, req->errors)) {
> +				nvme_requeue_req(req);
> +				return;
> +			}
> +
> +			if (req->cmd_type == REQ_TYPE_DRV_PRIV)
> +				error = req->errors;
> +			else
> +				error = nvme_error_status(req->errors);
> +		}
