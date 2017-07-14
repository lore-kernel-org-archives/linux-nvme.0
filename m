From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 09:12:11 +0200
Subject: [PATCH v3] nvme: Add support for NVMe 1.3 Timestamp Feature
In-Reply-To: <20170713230350.2255-1-jonathan.derrick@intel.com>
References: <20170713230350.2255-1-jonathan.derrick@intel.com>
Message-ID: <20170714071211.GA17046@lst.de>

> +	status = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP,
> +				   0, &ts, sizeof(ts), NULL);
> +	if (status != 0)

If I'd want to nitpick, I'd say move as many as possible arguments to
the first line, and remove the superflous "!= 0":

	status = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP, 0, &ts,
				   sizeof(ts), NULL);
	if (status)

but that's something we can fix up when applying the patch.

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
