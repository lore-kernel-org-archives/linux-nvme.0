From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Jun 2018 00:15:35 -0700
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <c101703a-2135-3542-aa98-6362bbbadf25@kernel.dk>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <c101703a-2135-3542-aa98-6362bbbadf25@kernel.dk>
Message-ID: <20180621071535.GC21304@infradead.org>

>  	else
> -		max_hw_sectors = UINT_MAX;
> +		max_hw_sectors = NVME_MAX_KB_SZ << 1;

I think this only makes sense when using PRPs.  If we use SGLs
in Fabrics, or in PCIe controllers that support them we are
only bound by the number of SGL segments and MDTS.

This also seems to miss handling the case where MDTS is set, but
above our software limit.
