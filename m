From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 14 Dec 2016 09:16:37 +0800
Subject: extend bi_size to unsigned long ?
In-Reply-To: <82fdc4e9-3573-f5a5-6d27-34ea49d5f047@coly.li>
References: <82fdc4e9-3573-f5a5-6d27-34ea49d5f047@coly.li>
Message-ID: <CACVXFVO=QTnJKUGB_zaofSSG_FJoT5C7fZ3-bthekG0W10eqaw@mail.gmail.com>

Hi Coly,

On Tue, Dec 13, 2016@10:53 PM, Coly Li <i@coly.li> wrote:
> Hi linux-block and linux-nvme lists,
>
> Recently when I work on md-raid0 DISCARD optimization, I found the
> maximum DISCARD bio length that raid0_make_request() receives is 8388608
> sectors. I find it is because of the limitation of bi_size, which is
> unsigned int and 32 bits length.
>
> A 32 bits bi_size means a DISCARD bio can only cover UINT_MAX>>9
> sectors, see commit a22c4d7e3440 ("block: re-add discard_granularity and
> alignment checks"). To format a xfs volume on 4x4TB NVMe SSDs, the
> original DISCARD bio has to be split for 4x1024 times. If bi_size is a
> 64 bits unsigned long, in ideal condition the original DISCARD bio can
> only be split for 4 times, that is one split bio for each device.

I guess it still need 4*2 times even bi_size becomes 64bits because
limit.max_discard_sectors is 32bit.

On the other hand, it depends on the actual max discard sectors limit
from the hardware, now NVMe just sets it as UINT_MAX(2TB).

>
> Now days it won't be a big issue since block layer may merge the split
> bios (or may not if its block-mq and NVMe). When the underlying device

In your case, block can't merge, because request.__data_len is still 32bit,
and the worse thing is that looks block does not consider overflow yet when
dealing with merge.

> becomes larger and larger, maybe a 32 bits bi_size will hurt DISCARD
> performance.

I guess this change only makes sense for DISCARD/WRITE_SAME,
and in blkdev_issue_discard(), the splitted bios(each one can be 4GB)
are always sent to device concurrently, so did you obseve obvious
performance loss on your 4TB NVMe(leave raid alone first) when doing
mkfs?

>
> I know this is not simple, it changes a very important KABI. But this is
> really an interesting question to ask: do we have any idea to extend
> bi_size from unsigned int to unsigned long ?

The concern should be bio size's increasemnt, but looks sizeof(struct bvec_iter)
won't change after .bi_size becomes 64bit if we won't define 'bvec_iter' as
compact.

But I remembered that sizeof(bio) can be decreased to 128 bytes if
'struct bvec_iter' is defined as compact and 'bi_phys_segments' is changed
to 'unsigned short'.

Thanks,
Ming

>
> Thanks in advance.
>
> --
> Coly Li
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Ming Lei
