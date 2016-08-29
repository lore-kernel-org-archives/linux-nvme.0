From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Aug 2016 12:27:35 -0400
Subject: [PATCH 2/3] nvme: Pass pointers, not dma addresses, to
 nvme_get/set_features()
In-Reply-To: <2756c572e066ed91a41e35568a4d9346e47d6b42.1472462539.git.luto@kernel.org>
References: <cover.1472462539.git.luto@kernel.org>
 <2756c572e066ed91a41e35568a4d9346e47d6b42.1472462539.git.luto@kernel.org>
Message-ID: <20160829162735.GD19986@localhost.localdomain>

On Mon, Aug 29, 2016@02:25:45AM -0700, Andy Lutomirski wrote:
> +	/*
> +	 * A controller "page" may be bigger than a Linux page, but we can
> +	 * be conservative here.
> +	 */

It is the actually other way around: the Linux page may be larger than the
controller's. We currently use the smallest possible controller page (4k)
regardless of the host's size due to limitations discovering the CPU's
DMA alignment. PPC was the first to encounter this problem with NVMe.

Otherwise, looks good.
