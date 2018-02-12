From: ctuffli@gmail.com (Chuck Tuffli)
Date: Mon, 12 Feb 2018 13:47:10 -0800
Subject: nvmf mapping bio data question
Message-ID: <CAKAYmMK6j6Tw3ur-ePWsF60wBkBkpbnc-nCN8TaFHbtTo4yJGg@mail.gmail.com>

Hi

I'm experimenting with a software based NVMe controller which plugs
into the NVMf transport interface and could use some advice regarding
mapping the pages from a struct bio into a kernel virtual address. For
a concrete example, consider the Get Discovery Log Page request. The
driver will create a set of entries and then needs to write these back
to the bio. Currently, it does this by looping through the pages with
bio_for_each_segment(), using kmap_atomic/kunmap_atomic to get a KVA,
and copying the Discovery Entries to the bio one page at a time.

This "works" in that the intended data gets back to user space (i.e.
nvme-cli), but is clearly wrong as the system panics (bugon,
segfaults, ...) later in unrelated code. Is this even the right
approach? If so, what dumb thing am I doing (or not doing)? Below, d
is a void * allocated via kmalloc(bio->bi_size, GFP_ATOMIC) and the
bio pointer is from rq->bio (i.e. blk_mq_queue_data->rq->bio). If it
matters, this runs from the driver's .queue_rq function.

    /*
     * If this is a read operation, copy data back to the struct bio
     * one vector at a time from the driver's softcopy
     */
    if (rd_op) {
        bio_for_each_segment(bvec, bio, i) {
            bdata = kmap_atomic(bvec->bv_page);
            memcpy(bdata + bvec->bv_offset, d, bvec->bv_len);
            d += bvec->bv_len;
            kunmap_atomic(bdata);
        }
    }

Thanks in advance.

--chuck
