From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Feb 2015 22:15:55 +0000 (UTC)
Subject: NVMe: Metadata format support
In-Reply-To: <20150225111035.GA27796@mwanda>
References: <20150225111035.GA27796@mwanda>
Message-ID: <alpine.LNX.2.00.1502262209060.32385@localhost.lm.intel.com>

On Wed, 25 Feb 2015, Dan Carpenter wrote:
> The patch e1e5e5641e6f: "NVMe: Metadata format support" from Feb 19,
> 2015, leads to the following static checker warning:
>
> 	drivers/block/nvme-core.c:524 nvme_dif_remap()
> 	warn: 'pmap' can't be NULL.
>
> drivers/block/nvme-core.c
>   519          bip = bio_integrity(req->bio);
>   520          if (!bip)
>   521                  return;
>   522
>   523          pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;
>   524          if (!pmap)
>   525                  return;
>
> The static check here really means that we should check the return from
> kmap_atomic() before adding "bip->bip_vec->bv_offset".  Can
> kmap_atomic() fail here anyway?  I don't know.

I didn't find a single kmap_atomic caller in the kernel checking for NULL.
I'll remove it.
