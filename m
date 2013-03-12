From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 Mar 2013 16:51:41 -0600 (MDT)
Subject: [PATCH 3/4] NVMe: End-to-end data protection
In-Reply-To: <yq11ubkqmkx.fsf@sermon.lab.mkp.net>
References: <OF4D215762.7078BEB8-ON86257B2C.004F99F8-86257B2C.00538982@hgst.com>
 <alpine.LRH.2.03.1303121559570.17928@localhost.localdom>
 <yq11ubkqmkx.fsf@sermon.lab.mkp.net>
Message-ID: <alpine.LRH.2.03.1303121639490.17928@localhost.localdom>


On Tue, 12 Mar 2013, Martin K. Petersen wrote:

>>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:
>
> Keith> The DIF meta-data generate and verify functions don't specify the
> Keith> size meta-data per sector, so we can't handle anything that isn't
> Keith> a DIF tuple size of 8 bytes.
>
> The sector_size parameter in struct blk_interity defines the number of
> bytes in each block. The tuple_size defines the size of the metadata per
> block. I.e. 8 bytes for T10 PI.
>
> -- 
> Martin K. Petersen	Oracle Linux Engineering
>

That's true, but the generate/verify functions receive a struct
blk_integrity_exchg parameter, and there is no information there on how
large a tuple is. The existing generate and verify functions in sd_dif.c
increment through the bix->prot_buf as if the meta-data size per sector
was the size of the struct sd_dif_tuple, so I don't think it will work
if I have additional meta-data space beyond the DIF tuple.
