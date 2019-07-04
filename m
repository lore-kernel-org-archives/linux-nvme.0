From: wolfgang@rohdewald.de (Wolfgang Rohdewald)
Date: Thu, 04 Jul 2019 14:09:24 +0200
Subject: [nvme] Invalid SGL for payload:91648 nents:3
In-Reply-To: <20190626012654.GA23698@ming.t460p>
References: <92778741dff3723fc94cd75df3043adc9c8bf21a.camel@rohdewald.de>
 <20190625091704.GA30606@ming.t460p>
 <CAOSXXT5PgPJqouD0G7qJjar5tmy-9z+wWdFMqpD2K1=5vQZ+HA@mail.gmail.com>
 <20190625094532.GA11214@ming.t460p> <20190625095013.GA1353@lst.de>
 <336692273232ee2441e30e7e2a1c542201854010.camel@rohdewald.de>
 <20190625132900.GA22428@ming.t460p>
 <6e23e6656188778c22e4aef04b6572c247103972.camel@rohdewald.de>
 <20190626012654.GA23698@ming.t460p>
Message-ID: <10ac1082dc1c5061628a62f9bf2692886f8fbbb0.camel@rohdewald.de>

On Mi, 2019-06-26@09:26 +0800, Ming Lei wrote:
> I can understand the issue now, and the issue isn't related with bio
> split, and it is in the normal bio merge code: biovec_phys_mergeable()
> which merges two bios if their bvecs are physically continuous, and not consider
> max segment size limit, which is still applied in blk_bvec_map_sg(),
> then sg with unaligned virt boundary is made.
> 
> Christoph's patch 09324d32d2a08 ("block: force an unlimited segment size on queues
> with a virt boundary") can fix the issue, but another regression might be
> caused because of too big segment size from view of IOMMU.
> 
> And the following patch should fix the 5.1 issue too:
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 1c9d4f0f96ea..ff69b7dd2179 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -60,7 +60,8 @@ static inline bool bio_will_gap(struct request_queue *q,
>          */
>         bio_get_last_bvec(prev, &pb);
>         bio_get_first_bvec(next, &nb);
> -       if (bios_segs_mergeable(q, prev, &pb, &nb))
> +       if (bios_segs_mergeable(q, prev, &pb, &nb) && prev->bi_seg_back_size +
> +                       next->bi_seg_front_size < queue_max_segment_size(q))
>                 return false;
>         return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
>  }

I wonder why this is not in 5.1.16

-- 
mit freundlichen Gr?ssen

Wolfgang Rohdewald
