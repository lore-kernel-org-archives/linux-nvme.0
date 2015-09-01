From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 1 Sep 2015 17:01:54 +0300
Subject: [PATCHv4] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <1438716733-566-1-git-send-email-keith.busch@intel.com>
References: <1438716733-566-1-git-send-email-keith.busch@intel.com>
Message-ID: <55E5AFD2.6080200@dev.mellanox.co.il>

> -static int req_gap_to_prev(struct request *req, struct request *next)
> +static int req_gap_to_prev(struct request *req, struct bio *next)
>   {
>   	struct bio *prev = req->biotail;
>
> -	return bvec_gap_to_prev(&prev->bi_io_vec[prev->bi_vcnt - 1],
> -				next->bio->bi_io_vec[0].bv_offset);
> +	return bvec_gap_to_prev(req->q, &prev->bi_io_vec[prev->bi_vcnt - 1],
> +			next->bi_io_vec[1].bv_offset);

Keith,

is the index change in the bi_io_vec intentional?
