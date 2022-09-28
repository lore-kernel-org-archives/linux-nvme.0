Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE3AC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ma+WfyDUOu65BUCzRZHjxnobNoWTb8YtsVUPTmbAysk=; b=s+EAOl9lGSuwZvpMbYISq4Zmm/
	h5EmFDIZzzfI3hLpm+59n+3q+ira5eynCbBGaQzXHbVjzKCiJGSD9uA3iM2chr6uneoNVDZAhzAP4
	pkjWp2YZPHLa+bX4GGRMxOkORa0qzqmcXrfGUu1GHP0SeLXbDNgmCURcFnQE8wI+sU0D725OJUexL
	0PQxRqOf+xsm8zp6UX7cRkkTFgrUdyoM3P/hPN/q0tIr4ocS60IV32alFsCvjIoqwPtLF23TuYtzD
	6IqvIvaVCi/xhSEOJ5i8SGzlxl8iC4uSp1rGC1EOFJbi9UMts1yH78a/HaECu8Hwdt5vgGQZ2o2Sj
	BUfQ8fcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXHR-00GVzQ-T0; Wed, 28 Sep 2022 13:39:17 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXH9-00GVrn-G2
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 13:39:01 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id u189so12742768vsb.4
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ma+WfyDUOu65BUCzRZHjxnobNoWTb8YtsVUPTmbAysk=;
        b=FgAFPI/223pVOPaxxHEM/Zd1ZfWpjbG7PQ4A8Vy77PUd6ZD434RmmJ1INOCc5HuLI/
         DDjwTlHMTPSUWy72Sn7I7Y/cMdoOuZY4n95h3fNy5P9s1MMYWfc7Qvcg7MdN2iSSIVBi
         f07+FTLNkST49A/Fp8p7snt8SfPl7G/k7MaK4MWBrXoXPlxdxzczgNCG0g8zInW37Yfd
         nUfCHF0yYXQaGwsm0bXjBt1WZRjcW2jY310MpvQZ+hQ6ZFjfLiYX7fvCFDjm9bOpKPiD
         aHYOfdf5BSuxoQqqCjS9+ZrGJxmk2s6T/RWXAFlyff7/+TA7q2pRyQMZv+AvPFxvShhu
         z+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ma+WfyDUOu65BUCzRZHjxnobNoWTb8YtsVUPTmbAysk=;
        b=4UUYsOVHq41be18A9MOfWHlot5HUcMg/dgA8Z9d29i/NQa+tmMXLJd6DOI6b5kxX8Q
         31wxLT9x9dDHhAoWUGmmj6n7tDgtxsW1MubsYPeJFioMYLolyN4+b6x6Tgdnpv4RixSK
         WYfrcraZ883QXpCQQBX26YsU4VeZAozTiu/hgsTzMy8Qqw00pBbsKwblVZG1mbN3ehGf
         zlw3Fdc6WdeRWQDbOyrNfwfH+aMIpEcaqcwlkvaCx2BrOnz2IiKnMtrGg3FcUkj3OqVr
         Xana8e5tLJtDnXwyLG84V5lRek0u9YMday56UzOHaJMW9cyU7y8TSjUILWh7ZTaZlheu
         OenQ==
X-Gm-Message-State: ACrzQf3kT3cp8rRxYTgc5zaNSQS5557tqVXpijiI17jOGYMQHqa4V8YX
	PW/PlTVEeUigfQlOtIoLpRHxkOkWuxwBmmQRdw==
X-Google-Smtp-Source: AMsMyM5ZevjLPsHqYmkPkCeAItjJmrYLdDuwbEfDYF6XpvVDBajf5Yr1pIp2lc+jss4yCDtssVMxPfR5iMihBbL16Ps=
X-Received: by 2002:a67:bd14:0:b0:398:81fb:3d04 with SMTP id
 y20-20020a67bd14000000b0039881fb3d04mr14683646vsq.4.1664372336277; Wed, 28
 Sep 2022 06:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220927014420.71141-1-axboe@kernel.dk> <20220927014420.71141-2-axboe@kernel.dk>
In-Reply-To: <20220927014420.71141-2-axboe@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 28 Sep 2022 19:08:19 +0530
Message-ID: <CACzX3AsD6YwUTD7o+o1tan-Eva2BshffYRr2t4zp4+dgZ1AkLA@mail.gmail.com>
Subject: Re: [PATCH 1/5] block: enable batched allocation for blk_mq_alloc_request()
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_063859_558592_ED4A0B39 
X-CRM114-Status: GOOD (  23.97  )
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

On Tue, Sep 27, 2022 at 7:19 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> The filesystem IO path can take advantage of allocating batches of
> requests, if the underlying submitter tells the block layer about it
> through the blk_plug. For passthrough IO, the exported API is the
> blk_mq_alloc_request() helper, and that one does not allow for
> request caching.
>
> Wire up request caching for blk_mq_alloc_request(), which is generally
> done without having a bio available upfront.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 9 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c11949d66163..d3a9f8b9c7ee 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -510,25 +510,87 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>                                         alloc_time_ns);
>  }
>
> -struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
> -               blk_mq_req_flags_t flags)
> +static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
> +                                           struct blk_plug *plug,
> +                                           blk_opf_t opf,
> +                                           blk_mq_req_flags_t flags)
>  {
>         struct blk_mq_alloc_data data = {
>                 .q              = q,
>                 .flags          = flags,
>                 .cmd_flags      = opf,
> -               .nr_tags        = 1,
> +               .nr_tags        = plug->nr_ios,
> +               .cached_rq      = &plug->cached_rq,
>         };
>         struct request *rq;
> -       int ret;
>
> -       ret = blk_queue_enter(q, flags);
> -       if (ret)
> -               return ERR_PTR(ret);
> +       if (blk_queue_enter(q, flags))
> +               return NULL;
> +
> +       plug->nr_ios = 1;
>
>         rq = __blk_mq_alloc_requests(&data);
> -       if (!rq)
> -               goto out_queue_exit;
> +       if (unlikely(!rq))
> +               blk_queue_exit(q);
> +       return rq;
> +}
> +
> +static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
> +                                                  blk_opf_t opf,
> +                                                  blk_mq_req_flags_t flags)
> +{
> +       struct blk_plug *plug = current->plug;
> +       struct request *rq;
> +
> +       if (!plug)
> +               return NULL;
> +       if (rq_list_empty(plug->cached_rq)) {
> +               if (plug->nr_ios == 1)
> +                       return NULL;
> +               rq = blk_mq_rq_cache_fill(q, plug, opf, flags);
> +               if (rq)
> +                       goto got_it;
> +               return NULL;
> +       }
> +       rq = rq_list_peek(&plug->cached_rq);
> +       if (!rq || rq->q != q)
> +               return NULL;
> +
> +       if (blk_mq_get_hctx_type(opf) != rq->mq_hctx->type)
> +               return NULL;
> +       if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
> +               return NULL;
> +
> +       plug->cached_rq = rq_list_next(rq);
> +got_it:
> +       rq->cmd_flags = opf;
> +       INIT_LIST_HEAD(&rq->queuelist);
> +       return rq;
> +}
> +
> +struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
> +               blk_mq_req_flags_t flags)
> +{
> +       struct request *rq;
> +
> +       rq = blk_mq_alloc_cached_request(q, opf, flags);
> +       if (!rq) {
> +               struct blk_mq_alloc_data data = {
> +                       .q              = q,
> +                       .flags          = flags,
> +                       .cmd_flags      = opf,
> +                       .nr_tags        = 1,
> +               };
> +               int ret;
> +
> +               ret = blk_queue_enter(q, flags);
> +               if (ret)
> +                       return ERR_PTR(ret);
> +
> +               rq = __blk_mq_alloc_requests(&data);
> +               if (!rq)
> +                       goto out_queue_exit;
> +       }
>         rq->__data_len = 0;
>         rq->__sector = (sector_t) -1;
>         rq->bio = rq->biotail = NULL;
> --
> 2.35.1
>

A large chunk of this improvement in passthrough performance is coming by
enabling request caching. On my setup, the performance improves from
2.34 to 2.54 MIOPS. I have tested this using the t/io_uring utility (in fio) and
I am using an Intel Optane Gen2 device.

Tested-by: Anuj Gupta <anuj20.g@samsung.com>

--
Anuj Gupta

