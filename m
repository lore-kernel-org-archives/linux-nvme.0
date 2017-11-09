From: keith.busch@intel.com (Keith Busch)
Date: Thu, 9 Nov 2017 11:17:47 -0700
Subject: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20171109174450.17142-5-hch@lst.de>
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-5-hch@lst.de>
Message-ID: <20171109181747.GA8365@localhost.localdomain>

On Thu, Nov 09, 2017@06:44:47PM +0100, Christoph Hellwig wrote:
> +config NVME_MULTIPATH
> +	bool "NVMe multipath support"
> +	depends on NVME_CORE
> +	---help---
> +	   This option enables support for multipath access to NVMe
> +	   subsystems.  If this option is enabled only a single
> +	   /dev/nvneXnY device will show up for each NVMe namespaces,

Minor typo: should be /dev/nvmeXnY.

Otherwise, everything in the series looks good to me and testing on my
dual port devices hasn't found any problems.

For the whole series:

Reviewed-by: Keith Busch <keith.busch at intel.com>
