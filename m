From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Jan 2018 10:57:07 +0100
Subject: [PATCH 2/5] nvme/multipath: Consult blk_status_t for failover
In-Reply-To: <20180104224623.8944-3-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-3-keith.busch@intel.com>
Message-ID: <20180108095707.GD4673@lst.de>

> -	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
> -		if (nvme_req_needs_failover(req)) {
> +	blk_status_t status = nvme_error_status(req);
> +
> +	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
> +		if (nvme_req_needs_failover(req, status)) {

We don't really need to call nvme_error_status if nvme_req(req)->status
is zero.

> -static inline bool nvme_req_needs_failover(struct request *req)
> +static inline bool nvme_req_needs_failover(struct request *req, blk_status_t error)

line break after 80 characters, please.
