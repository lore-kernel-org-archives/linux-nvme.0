From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 14 Feb 2016 16:02:18 +0200
Subject: 4.5-rc iser issues
In-Reply-To: <56C066AF.6050901@dev.mellanox.co.il>
References: <20160214074119.GA24558@infradead.org>
 <56C04294.3090701@dev.mellanox.co.il> <56C05000.1040001@dev.mellanox.co.il>
 <56C066AF.6050901@dev.mellanox.co.il>
Message-ID: <56C088EA.1050901@dev.mellanox.co.il>


>> I'm bisecting now, there are a couple of patches from Ming in
>> the area of the bio splitting code...
>>
>> CC'ing Ming, Linux-block and Linux-nvme as iser is identical to nvme
>> wrt the virtual boundary so I think nvme will break as well.
>
> Bisection reveals that this one is the culprit:
>
> commit 52cc6eead9095e2faf2ec7afc013aa3af1f01ac5
> Author: Ming Lei <ming.lei at canonical.com>
> Date:   Thu Sep 17 09:58:38 2015 -0600
>
>      block: blk-merge: fast-clone bio when splitting rw bios
>
>      biovecs has become immutable since v3.13, so it isn't necessary
>      to allocate biovecs for the new cloned bios, then we can save
>      one extra biovecs allocation/copy, and the allocation is often
>      not fixed-length and a bit more expensive.
>
>      For example, if the 'max_sectors_kb' of null blk's queue is set
>      as 16(32 sectors) via sysfs just for making more splits, this patch
>      can increase throught about ~70% in the sequential read test over
>      null_blk(direct io, bs: 1M).
>
>      Cc: Christoph Hellwig <hch at infradead.org>
>      Cc: Kent Overstreet <kent.overstreet at gmail.com>
>      Cc: Ming Lin <ming.l at ssi.samsung.com>
>      Cc: Dongsu Park <dpark at posteo.net>
>      Signed-off-by: Ming Lei <ming.lei at canonical.com>
>
>      This fixes a performance regression introduced by commit 54efd50bfd,
>      and allows us to take full advantage of the fact that we have
> immutable
>      bio_vecs. Hand applied, as it rejected violently with commit
>      5014c311baa2.
>
>      Signed-off-by: Jens Axboe <axboe at fb.com>
> --

Looks like there is a problem with bio_clone_fast()

This change makes the problem go away:
--
diff --git a/block/bio.c b/block/bio.c
index dbabd48..5e93733 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1791,7 +1791,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
          * Discards need a mutable bio_vec to accommodate the payload
          * required by the DSM TRIM and UNMAP commands.
          */
-       if (bio->bi_rw & REQ_DISCARD)
+       if (1 || bio->bi_rw & REQ_DISCARD)
                 split = bio_clone_bioset(bio, gfp, bs);
         else
                 split = bio_clone_fast(bio, gfp, bs);
--

Any thoughts?
