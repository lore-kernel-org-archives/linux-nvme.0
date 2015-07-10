From: kallolbiswas@yahoo.com (Kallol Biswas)
Date: Fri, 10 Jul 2015 15:49:29 -0700
Subject: BIOVEC_NOT_VIRT_MERGEABLE macro
Message-ID: <1436568569.73411.YahooMailBasic@web185006.mail.gq1.yahoo.com>

I am trying to understand why we need to split IO if BIOVEC_NOT_VIRT_MERGEABLE is true. Rather why we need to check if vecs are virtually mergeable. Can someone explain?


/* NVMe scatterlists require no holes in the virtual address */
#define BIOVEC_NOT_VIRT_MERGEABLE(vec1, vec2)   ((vec2)->bv_offset || \
                        (((vec1)->bv_offset + (vec1)->bv_len) % PAGE_SIZE))

static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
                struct bio *bio, enum dma_data_direction dma_dir, int psegs)
{
        struct bio_vec *bvec, *bvprv = NULL;
        struct scatterlist *sg = NULL;
        int i, length = 0, nsegs = 0, split_len = bio->bi_size;

        if (nvmeq->dev->stripe_size)
                split_len = nvmeq->dev->stripe_size -
                        ((bio->bi_sector << 9) & (nvmeq->dev->stripe_size - 1));

        sg_init_table(iod->sg, psegs);
        bio_for_each_segment(bvec, bio, i) {
                if (bvprv && BIOVEC_PHYS_MERGEABLE(bvprv, bvec)) {
                        sg->length += bvec->bv_len;
                } else {
                        if (bvprv && BIOVEC_NOT_VIRT_MERGEABLE(bvprv, bvec))
                                return nvme_split_and_submit(bio, nvmeq, i,
                                                                length, 0);

                        sg = sg ? sg + 1 : iod->sg;
                        sg_set_page(sg, bvec->bv_page, bvec->bv_len,
                                                        bvec->bv_offset);
                        nsegs++;
                }

                if (split_len - length < bvec->bv_len)
                        return nvme_split_and_submit(bio, nvmeq, i, split_len,
                                                        split_len - length);
                length += bvec->bv_len;
                bvprv = bvec;
        }
        iod->nents = nsegs;
        sg_mark_end(sg);
        if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
                return -ENOMEM;

        BUG_ON(length != bio->bi_size);
        return length;
}
