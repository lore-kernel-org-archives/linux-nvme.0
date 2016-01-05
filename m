From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 5 Jan 2016 12:54:53 +0800
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
Message-ID: <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>

On Tue, Jan 5, 2016@2:24 AM, Keith Busch <keith.busch@intel.com> wrote:
> This allows bio splits in the middle of a vector to form the largest

Wrt. the current block stack, one segment always hold one or more bvec,
instead of part of bvec, so better to be careful about this handling.

> possible bio at the h/w's desired alignment, and guarantees the bio being
> split will have some data. Previously, if the first vector's length was
> greater than the allowable amount, the bio would split at a zero length
> and hit a kernel BUG.

That is introduced by d3805611130a, and zero length can't be splitted
previously because queue_max_sectors() is at least one PAGE_SIZE.

>
> The length check is moved after the SG_GAPS check so that check doesn't
> need to be duplicated in the split case.
>
> Fixes: d3805611130af9b911e908af9f67a3f64f4f0914
> bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=110231
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  block/blk-merge.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index e73846a..e886a7d 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -81,9 +81,6 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>         struct bio *new = NULL;
>
>         bio_for_each_segment(bv, bio, iter) {
> -               if (sectors + (bv.bv_len >> 9) > blk_max_size_offset(q, bio->bi_iter.bi_sector))
> -                       goto split;
> -
>                 /*
>                  * If the queue doesn't support SG gaps and adding this
>                  * offset would create a gap, disallow it.
> @@ -91,6 +88,17 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>                 if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
>                         goto split;
>
> +               if (sectors + (bv.bv_len >> 9) > blk_max_size_offset(q, bio->bi_iter.bi_sector)) {
> +                       /*
> +                        * Consider this a new segment if we're taking any part
> +                        * of this vector.
> +                        */
> +                       if (sectors < blk_max_size_offset(q, bio->bi_iter.bi_sector))
> +                               ++nsegs;

If segment count is increased, 'goto new_segment' should have been
run to update other variables(seg_size, bvprvp, ...).

> +                       sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector);
> +                       goto split;
> +               }
> +
>                 if (bvprvp && blk_queue_cluster(q)) {
>                         if (seg_size + bv.bv_len > queue_max_segment_size(q))
>                                 goto new_segment;
> --
> 2.6.2.307.g37023ba
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Ming Lei
