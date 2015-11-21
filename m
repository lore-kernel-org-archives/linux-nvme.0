From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 21 Nov 2015 00:20:41 -0800
Subject: [PATCH 1/1] nvme: temporary fix for Apple NVMe controller reset
In-Reply-To: <6ed9ad799884d9d4bdbfbdf94185c3f2@localhost>
References: <6ed9ad799884d9d4bdbfbdf94185c3f2@localhost>
Message-ID: <20151121082041.GA17935@infradead.org>

Hi Stephan,

> +	/*
> +	 * Temporary fix for the Apple controller found in the MacBook8,1 and
> +	 * some MacBook7,1 to avoid controller resets and data loss.
> +	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001)
> +		dev->q_depth = 2;

Can you add a dev_warn() here?  A NVMe device with queue depth is going
to perform bady, and we should tell people that we're applying a crude
workaround.

Otherwise this looks fine to me to get you guys going, but I really hope
we'll find the root cause soon.
