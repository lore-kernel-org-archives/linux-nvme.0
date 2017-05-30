From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 17:35:41 +0300
Subject: [PATCH 4/4] nvme-pci: implement host memory buffer support
In-Reply-To: <20170520131357.15929-5-hch@lst.de>
References: <20170520131357.15929-1-hch@lst.de>
 <20170520131357.15929-5-hch@lst.de>
Message-ID: <5fbaa522-8d21-ad4b-8142-87bf3a2f544a@grimberg.me>


> +	dev_info(dev->ctrl.device,
> +		"allocated %lld MiB host memory buffer.\n", size / 1024 / 1024);

super-nit: SZ_1M

Looks good,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
