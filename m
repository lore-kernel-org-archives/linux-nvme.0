Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6937ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 23:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UFQxPx2xZ7SXz5if609vWhS7JAKW1EBJUBE4vqHgcYo=; b=aFe+YQH4BC4AqAIaSGPklkANDN
	d3Sdb0t/BMQj4W0T2kazckWBKR0u3fIMwpSQ9cwC4oqVJMI+tEY27l02hpEltRXBaUlvNn0Hob47p
	VnuGbRnK3cT+QnCKP4DnV3TgWAMZODSwpQUBS3mcsElG9Od8DDsh6AgSpkPJdil1VZECzgURj+h4M
	mbzMlFvM7xAu/CSOPB2dPYH0Jp5X+xiYatpMhVxfLLd+cIyJ8URtwuL63aA27frIWZQN880Ne2yJt
	yIrLFEKPohQBwclYF74MQaG+MFAQiUBmy9wcY5EwpJ0wYy+/Vk7dXILsclwMr29X5c32KFWUpgDyH
	RknLy2WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUFs6-00Cswf-9J; Fri, 02 Sep 2022 23:14:46 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUFs3-00Cstl-OS
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 23:14:45 +0000
Received: by mail-pf1-x430.google.com with SMTP id x19so3316343pfr.1
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 16:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UFQxPx2xZ7SXz5if609vWhS7JAKW1EBJUBE4vqHgcYo=;
        b=3rE8sIFgVoYlIoaBXABmjU6tjq4EohsT0ycO+fLTxJFGNlX/oKMrXTP+6WR5tjZy8X
         /MF5F9Ju6ghbTffyPkolxge0v59URbVMmCjeJLIZ7HEbmUAdiDzDFi8wdrD973WJSEG0
         oOoRb9Qlonr8e92FvDSjK9Io2CxV3amzIuafFIyK2KCOfylff6DUDi2DzFmvnLJikMKe
         Oc8hRcmNjKR1LSOyH8Kt0o3TaRx+g50Y2chsi55QS4fBCZvUNCxEtDUw1vX07KDvzRg/
         SpYedok1hrGQmG6d0dBd8H9PvIBOUOPJqQUecofNgxIxD+2uohFyLQUGnEvvVBUVylcw
         FHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UFQxPx2xZ7SXz5if609vWhS7JAKW1EBJUBE4vqHgcYo=;
        b=7/OGAHwlSnvQ1Ti0OwDZNLrUBHYQokLw5QCUor9RgXc+lAwGeBCW7WaeC6OSd2bRMB
         CYYi4G5WiNN5bhBhwdgVRj4Q5PDDp7b8zUflGxpGRudvILAmcDbEvNkNAcG1JGd8lyFa
         tKxaRAtNH1EqZJxElXpjTCa2tIDGPD3qKzUyfv5P1snDP7ek+b+NGStVvkkAfOc8HvuV
         4l8Hgl3+w5o37I/qP+waVHue8OSNZX2c+QlsKa1LK2VftCwoMjq3M9A+bpFuVMHx+0ps
         F9I7wC4TtUt0woiC5vYubCkWTeLBIpc1r0sYofthOKV2nh4qzLXXx/37y1vu7wwDmyVs
         6G1A==
X-Gm-Message-State: ACgBeo2unU3OzCGQGygmt1wEHTx+IsOJNrVLU7lE1lxRZkybHesVSENz
	7WDYEKMBYHczRJa68I/y36ylKQ==
X-Google-Smtp-Source: AA6agR6msLTQtYJkA01Mz762Y9DQHJpPHWp4VEazkW9MBddlGM8sf2+lRipwmx+LQoxu8fKprf1NXQ==
X-Received: by 2002:a63:e845:0:b0:42a:610a:77a9 with SMTP id a5-20020a63e845000000b0042a610a77a9mr33695479pgk.96.1662160482720;
        Fri, 02 Sep 2022 16:14:42 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d33-20020a634f21000000b004215af667cdsm1969982pgb.41.2022.09.02.16.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 16:14:42 -0700 (PDT)
Message-ID: <5dfa132d-de5a-effa-d1bd-a4f948e36cdf@kernel.dk>
Date: Fri, 2 Sep 2022 17:14:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v3 3/4] block: add helper to map bvec iterator
 for passthrough
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20220902151657.10766-1-joshi.k@samsung.com>
 <CGME20220902152712epcas5p2622e861ac4a5ae9820a9af9442d556b4@epcas5p2.samsung.com>
 <20220902151657.10766-4-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220902151657.10766-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_161443_821338_C7969C64 
X-CRM114-Status: GOOD (  23.08  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/2/22 9:16 AM, Kanchan Joshi wrote:
> Add blk_rq_map_user_bvec which maps the bvec iterator into a bio and
> places that into the request.
> This helper is to be used in nvme for uring-passthrough with
> fixed-buffer.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  block/blk-map.c        | 71 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 72 insertions(+)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index f3768876d618..0f7dc568e34b 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -612,6 +612,77 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
>  }
>  EXPORT_SYMBOL(blk_rq_map_user);
>  
> +/* Prepare bio for passthrough IO given an existing bvec iter */
> +int blk_rq_map_user_bvec(struct request *rq, struct iov_iter *iter)
> +{
> +	struct request_queue *q = rq->q;
> +	size_t iter_count, nr_segs;
> +	struct bio *bio;
> +	struct bio_vec *bv, *bvec_arr, *bvprvp = NULL;
> +	struct queue_limits *lim = &q->limits;
> +	unsigned int nsegs = 0, bytes = 0;
> +	int ret, i;
> +
> +	iter_count = iov_iter_count(iter);
> +	nr_segs = iter->nr_segs;
> +
> +	if (!iter_count || (iter_count >> 9) > queue_max_hw_sectors(q))
> +		return -EINVAL;
> +	if (nr_segs > queue_max_segments(q))
> +		return -EINVAL;
> +	if (rq->cmd_flags & REQ_POLLED) {
> +		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
> +
> +		/* no iovecs to alloc, as we already have a BVEC iterator */
> +		bio = bio_alloc_bioset(NULL, 0, opf, GFP_KERNEL,
> +					&fs_bio_set);
> +		if (!bio)
> +			return -ENOMEM;
> +	} else {
> +		bio = bio_kmalloc(0, GFP_KERNEL);
> +		if (!bio)
> +			return -ENOMEM;
> +		bio_init(bio, NULL, bio->bi_inline_vecs, 0, req_op(rq));
> +	}

I think this should be a helper at this point, as it's the same
duplicated code we have in the normal map path.

-- 
Jens Axboe

