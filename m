From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 16 Jul 2015 21:39:38 -0400
Subject: [PATCH 0/3] Fixes for gapped scatters
In-Reply-To: <1436966356-8979-1-git-send-email-sagig@mellanox.com> (Sagi
 Grimberg's message of "Wed, 15 Jul 2015 16:19:13 +0300")
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
Message-ID: <yq1bnfbo945.fsf@sermon.lab.mkp.net>

>>>>> "Sagi" == Sagi Grimberg <sagig at mellanox.com> writes:

Sagi> This small set addresses some issues with gapped scattered
Sagi> IOs. The motivation of this is to have the iser driver take
Sagi> advantage of it too.

Sagi> Patch 1 prevent gapped SG_IO if the driver can't handle gaps.
Sagi> Patches 2,3 prevent gapped integrity payloads (for drivers that
Sagi> support data integrity).

Back in the prototyping days of DIX we dealt with several controllers
that had various oddball scatterlist requirements for PI. The only
workaround we found that performed acceptably was to grab a page and
bounce the PI to that. In the end none of these controllers ended up
shipping, and DIX explicitly requires a controller to be able to handle
a separate scatterlist element per PI interval.

I know that for NVMe latency is king and so on. But I do question the
sanity of having to issue a flurry 512+8 I/Os instead of quarter of a
meg and a page of PI. You're at the whim of the kernel memory allocator
and for a long time slab or slub was allocating backwards so you never
ended up being able to merge PI scatterlist entries.

Also, if you were to go down this path you'd have to handle cases where
a bio itself would need to get split. The PI for two contiguous 512-byte
data blocks in a bio_vec entry could reside in separate integrity pages
at offsets that would make them "gappy".

-- 
Martin K. Petersen	Oracle Linux Engineering
