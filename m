From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 12 Mar 2013 18:29:02 -0400
Subject: [PATCH 3/4] NVMe: End-to-end data protection
In-Reply-To: <alpine.LRH.2.03.1303121559570.17928@localhost.localdom> (Keith
 Busch's message of "Tue, 12 Mar 2013 16:13:54 -0600 (MDT)")
References: <OF4D215762.7078BEB8-ON86257B2C.004F99F8-86257B2C.00538982@hgst.com>
 <alpine.LRH.2.03.1303121559570.17928@localhost.localdom>
Message-ID: <yq11ubkqmkx.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> The DIF meta-data generate and verify functions don't specify the
Keith> size meta-data per sector, so we can't handle anything that isn't
Keith> a DIF tuple size of 8 bytes.

The sector_size parameter in struct blk_interity defines the number of
bytes in each block. The tuple_size defines the size of the metadata per
block. I.e. 8 bytes for T10 PI.

-- 
Martin K. Petersen	Oracle Linux Engineering
