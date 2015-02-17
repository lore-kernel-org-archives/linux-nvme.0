From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 Feb 2015 16:05:42 +0000 (UTC)
Subject: [PATCH] NVMe: Metadata and PI format support
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A99979435A@NTXBOIMBX02.micron.com>
References: <1422670317-23420-1-git-send-email-keith.busch@intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A99979435A@NTXBOIMBX02.micron.com>
Message-ID: <alpine.LNX.2.00.1502171449101.32385@localhost.lm.intel.com>

On Mon, 16 Feb 2015, Sam Bradshaw (sbradshaw) wrote:
>> +	p = kmap_atomic(bip->bip_vec->bv_page);
>
> I think you want:
> p = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;

Yep, nice catch.

>> +	/* XXX: PI implementation requires metadata equal t10 pi tuple size */
>> +	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
>> +					id->dps & NVME_NS_DPS_PI_MASK : 0;
>
> If there is interest in incorporating this support, we can provide
> a patch on top of this that enables 16b/32b/64b metadata with PI and
> supports PIL={0,1}

I would also like that to work. I was hoping to reuse the
t10_pi_generate/verify functions for this. Those can work if the
iter->prot_buf is incremented by the blk_intergity's tuple_size rather
than just the 8-byte PI field.

That'd work with PIL=0, not sure what to do with PIL=1. Maybe we should
just define our own functions for nvme even though they'd mostly be the
same as the ones scsi uses.

> -Sam
