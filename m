From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Jun 2019 09:06:57 +0200
Subject: [PATCH v4 3/3] nvme: Set physical block size and optimal I/O
 size according to NVMe 1.4
In-Reply-To: <20190627143215.27443-4-bvanassche@acm.org>
References: <20190627143215.27443-1-bvanassche@acm.org>
 <20190627143215.27443-4-bvanassche@acm.org>
Message-ID: <20190628070657.GC28268@lst.de>

Hi Bart,

> +	/*
> +	 * Bit 1 indicates whether NAWUPF is defined for this namespace
> +	 * and whether it should be used instead of AWUPF. If NAWUPF == 0
> +	 * then AWUPF must be used instead.
> +	 */
> +	if (id->nsfeat & (1 << 1) && id->nawupf)
> +		atomic_bs = (1 + id->nawupf) * bs;

I think we also need to take the NABO value into account here.  Probably
just in that we only set a physical sector size = LBA size, as dealing
with the offsets would be a royal pain (and I've never actually seen
an NVMe device setting the offset either).

Otherwise this looks great to me.
