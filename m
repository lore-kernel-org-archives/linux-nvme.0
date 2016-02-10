From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 15:12:53 +0000
Subject: [PATCH 4/4] nvme: split pci module out of core module
In-Reply-To: <1454970284-29543-5-git-send-email-mlin@kernel.org>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-5-git-send-email-mlin@kernel.org>
Message-ID: <20160210151253.GB32064@localhost.localdomain>

On Mon, Feb 08, 2016@02:24:44PM -0800, Ming Lin wrote:
> This splits nvme.ko into 2 modules:
> nvme-core.ko: the core part
> nvme.ko: the PCI driver

Do we want to let PCI take the generic "nvme.ko" name? What will the
other nvme transport modules be called?

Otherwise, looks good to me.
