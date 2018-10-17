From: hch@lst.de (Christoph Hellwig)
Date: Wed, 17 Oct 2018 09:08:51 +0200
Subject: [PATCH 1/2] nvme-rdma: always have a valid trsvcid
In-Reply-To: <20181004174358.15267-1-sagi@grimberg.me>
References: <20181004174358.15267-1-sagi@grimberg.me>
Message-ID: <20181017070851.GA23187@lst.de>

On Thu, Oct 04, 2018@10:43:57AM -0700, Sagi Grimberg wrote:
> If not passed, we set the default trsvcid. We can rely
> on having trsvcid and can simplify the controller matching
> logic.

Use your 73 lines for the changelog, please.

> +	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
> +		opts->trsvcid =
> +			kstrdup(__stringify(NVME_RDMA_IP_PORT), GFP_KERNEL);

This needs error handling.

Otherwise the patch looks fine to me.
