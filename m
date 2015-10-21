From: mlin@kernel.org (Ming Lin)
Date: Wed, 21 Oct 2015 10:33:26 -0700
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard,write_same}
In-Reply-To: <20151021161947.GA5212@redhat.com>
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
 <20151014132700.GA19401@infradead.org> <20151021160232.GA5089@redhat.com>
 <20151021161947.GA5212@redhat.com>
Message-ID: <1445448806.26847.6.camel@ssi>

On Wed, 2015-10-21@12:19 -0400, Mike Snitzer wrote:
> On Wed, Oct 21 2015 at 12:02pm -0400,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > On Wed, Oct 14 2015 at  9:27am -0400,
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > On Tue, Oct 13, 2015@10:44:11AM -0700, Ming Lin wrote:
> > > > I just did a quick test with a Samsung 900G NVMe device.
> > > > mkfs.xfs is OK on 4.3-rc5.
> > > > 
> > > > What's your device model? I may find a similar one to try.
> > > 
> > > This is a HGST Ultrastar SN100
> > > 
> > > Analsys and tentativ fix below:
> > > 
> > > blktrace for before the commit:
> > > 
> > > 259,0    1        2     0.000002543  2394  G   D 0 + 8388607 [mkfs.xfs]
> > > 259,0    1        3     0.000008230  2394  I   D 0 + 8388607 [mkfs.xfs]
> > > 259,0    1        4     0.000031090   207  D   D 0 + 8388607 [kworker/1:1H]
> > > 259,0    1        5     0.000044869  2394  Q   D 8388607 + 8388607 [mkfs.xfs]
> > > 259,0    1        6     0.000045992  2394  G   D 8388607 + 8388607 [mkfs.xfs]
> > > 259,0    1        7     0.000049559  2394  I   D 8388607 + 8388607 [mkfs.xfs]
> > > 259,0    1        8     0.000061551   207  D   D 8388607 + 8388607 [kworker/1:1H]
> > > 
> > > .. and so on.
> > > 
> > > blktrace with the commit:
> > > 
> > > 259,0    2        1     0.000000000  1228  Q   D 0 + 4194304 [mkfs.xfs]
> > > 259,0    2        2     0.000002543  1228  G   D 0 + 4194304 [mkfs.xfs]
> > > 259,0    2        3     0.000010080  1228  I   D 0 + 4194304 [mkfs.xfs]
> > > 259,0    2        4     0.000082187   267  D   D 0 + 4194304 [kworker/2:1H]
> > > 259,0    2        5     0.000224869  1228  Q   D 4194304 + 4194304 [mkfs.xfs]
> > > 259,0    2        6     0.000225835  1228  G   D 4194304 + 4194304 [mkfs.xfs]
> > > 259,0    2        7     0.000229457  1228  I   D 4194304 + 4194304 [mkfs.xfs]
> > > 259,0    2        8     0.000238507   267  D   D 4194304 + 4194304 [kworker/2:1H]
> > > 
> > > So discards are smaller, but better aligned.  Now if I tweak a single
> > > line in blk-lib.c to be able to use all of bi_size I get the old I/O
> > > pattern back and everything works fine again:
> > > 
> > > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > > index bd40292..65b61dc 100644
> > > --- a/block/blk-lib.c
> > > +++ b/block/blk-lib.c
> > > @@ -82,7 +82,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> > >  			break;
> > >  		}
> > >  
> > > -		req_sects = min_t(sector_t, nr_sects, MAX_BIO_SECTORS);
> > > +		req_sects = min_t(sector_t, nr_sects, UINT_MAX >> 9);
> > >  		end_sect = sector + req_sects;
> > >  
> > >  		bio->bi_iter.bi_sector = sector;
> > 
> > Can we change UINT_MAX >> 9 to rounddown to the first factor of
> > minimum_io_size?
> > 
> > That should work for all devices and for dm-thinp (and dm-cache) in
> > particular will ensure that all discards that are issued will be a
> > multiple of the underlying device's blocksize.
> 
> Jeff Moyer pointed out having req_sects be a factor of
> discard_granularity makes more sense.  And I agree.  Same difference in
> the end (since dm-thinp sets discard_granularity to the thinp
> blocksize).

An old version of this patch did use discard_granularity
https://www.redhat.com/archives/dm-devel/2015-August/msg00000.html

But you didn't agree.
https://www.redhat.com/archives/dm-devel/2015-August/msg00001.html

Maybe we can re-add discard_granularity now?
