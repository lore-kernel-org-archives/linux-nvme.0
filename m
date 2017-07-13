From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Jul 2017 15:57:03 -0400
Subject: [PATCH v2] nvme: Add support for NVMe 1.3 Timestamp Feature
In-Reply-To: <20170713181651.1887-1-jonathan.derrick@intel.com>
References: <20170713181651.1887-1-jonathan.derrick@intel.com>
Message-ID: <20170713195703.GC14716@localhost.localdomain>

On Thu, Jul 13, 2017@12:16:51PM -0600, Jon Derrick wrote:
> +	status = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP,
> +				   0, &ts, 8, NULL);

Minor nit: instead of hardcoded '8', sizeof(ts) makes it obvious what
that parameter means.
