From: hch@lst.de (Christoph Hellwig)
Date: Fri, 19 Oct 2018 08:32:36 +0200
Subject: [PATCH v2 1/2] nvme-rdma: always have a valid trsvcid
In-Reply-To: <20181019004040.28527-1-sagi@grimberg.me>
References: <20181019004040.28527-1-sagi@grimberg.me>
Message-ID: <20181019063236.GB28667@lst.de>

> +	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
> +		opts->trsvcid =
> +			kstrdup(__stringify(NVME_RDMA_IP_PORT), GFP_KERNEL);

This still locks error handling.
