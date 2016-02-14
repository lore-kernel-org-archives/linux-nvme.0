From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 15 Feb 2016 00:20:58 +0800
Subject: 4.5-rc iser issues
In-Reply-To: <20160214152223.GA5323@infradead.org>
References: <20160214074119.GA24558@infradead.org>
 <56C04294.3090701@dev.mellanox.co.il>
 <56C05000.1040001@dev.mellanox.co.il>
 <56C066AF.6050901@dev.mellanox.co.il>
 <56C088EA.1050901@dev.mellanox.co.il>
 <20160214152223.GA5323@infradead.org>
Message-ID: <CACVXFVNAkf5+XFyf2JkcfeEPO2sv9bqHMR+N+=kKFzrtXpFEnA@mail.gmail.com>

Hi Sagi,

On Sun, Feb 14, 2016@11:22 PM, Christoph Hellwig <hch@infradead.org> wrote:
> Adding Ming to Cc.
>
> But I don't think simply not cloning the biovecs is the right thing
> to do in the end.  This must be something with the bvec iterators.

I agree with Christoph, and there might be issues somewhere.

> From the log:
> iser: sg[0] dma_addr:0x85FC06000 off:0x0 sz:0x200 dma_len:0x200
> iser: sg[1] dma_addr:0x860334000 off:0x0 sz:0x200 dma_len:0x200 <-- gap
> iser: sg[2] dma_addr:0x860335000 off:0x0 sz:0x200 dma_len:0x200 <-- gap

The above gap shouldn't have come since blk_bio_segment_split() splits
out one new bio if gap is detected.

Sort of the following code can be added in driver or prep_fn to check if
bvec of  the rq is correct:

rq_for_each_segment(bvec, sc->request, iter) {
     //check if there is gap between bvec
}

I don't know how to use iser, and looks everything works fine after
I setup virt boundary as 4095 for null_blk by the attachment
patch.

> Full quote for Ming:
>
> On Sun, Feb 14, 2016@04:02:18PM +0200, Sagi Grimberg wrote:
>>
>> >>I'm bisecting now, there are a couple of patches from Ming in
>> >>the area of the bio splitting code...
>> >>
>> >>CC'ing Ming, Linux-block and Linux-nvme as iser is identical to nvme
>> >>wrt the virtual boundary so I think nvme will break as well.

The bisected commit is merged to v4.3, and looks no such kind of
report from nvme.

>> >
>> >Bisection reveals that this one is the culprit:
>> >
>> >commit 52cc6eead9095e2faf2ec7afc013aa3af1f01ac5
>> >Author: Ming Lei <ming.lei at canonical.com>
>> >Date:   Thu Sep 17 09:58:38 2015 -0600
>> >
>> >     block: blk-merge: fast-clone bio when splitting rw bios
>> >
>> >     biovecs has become immutable since v3.13, so it isn't necessary
>> >     to allocate biovecs for the new cloned bios, then we can save
>> >     one extra biovecs allocation/copy, and the allocation is often
>> >     not fixed-length and a bit more expensive.
>> >
>> >     For example, if the 'max_sectors_kb' of null blk's queue is set
>> >     as 16(32 sectors) via sysfs just for making more splits, this patch
>> >     can increase throught about ~70% in the sequential read test over
>> >     null_blk(direct io, bs: 1M).
>> >
>> >     Cc: Christoph Hellwig <hch at infradead.org>
>> >     Cc: Kent Overstreet <kent.overstreet at gmail.com>
>> >     Cc: Ming Lin <ming.l at ssi.samsung.com>
>> >     Cc: Dongsu Park <dpark at posteo.net>
>> >     Signed-off-by: Ming Lei <ming.lei at canonical.com>
>> >
>> >     This fixes a performance regression introduced by commit 54efd50bfd,
>> >     and allows us to take full advantage of the fact that we have
>> >immutable
>> >     bio_vecs. Hand applied, as it rejected violently with commit
>> >     5014c311baa2.
>> >
>> >     Signed-off-by: Jens Axboe <axboe at fb.com>
>> >--
>>
>> Looks like there is a problem with bio_clone_fast()
>>
>> This change makes the problem go away:
>> --
>> diff --git a/block/bio.c b/block/bio.c
>> index dbabd48..5e93733 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -1791,7 +1791,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
>>          * Discards need a mutable bio_vec to accommodate the payload
>>          * required by the DSM TRIM and UNMAP commands.
>>          */
>> -       if (bio->bi_rw & REQ_DISCARD)
>> +       if (1 || bio->bi_rw & REQ_DISCARD)
>>                 split = bio_clone_bioset(bio, gfp, bs);
>>         else
>>                 split = bio_clone_fast(bio, gfp, bs);
>> --
>>
>> Any thoughts?

I don't think bio_clone_fast() is wrong, which use bvec table from
the original bio, and drivers are not allowed to change the table, and
should just call the standard iterator helpers to access bvec.

Also bio_for_each_segment_all() can't be used to iterate over one
cloned bio.

Thanks,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: null_blk_sg_virt_boundary.patch
Type: text/x-patch
Size: 1621 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160215/26a7157b/attachment.bin>
