Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97992C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 13:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rf9QNDdnrDAvxaE9Crvmms1oitRyKkwLnQLq+OetfA8=; b=JmaF2Dd+gMqgrGibumQ/RZuZbV
	IHHUtfx0DYVKK8mafYtJXqWJaNlw0uF5HX9pI8DMQGIpaPlpBRO0lgVbHIY2ay02kRxSM4+/8kC9+
	8ZrJ++2tjvo23hPrgrgYq1K2NGccZX9CeWhfnOi+gsIG6+9Y912cqD6hhg9bVLd44nAxAdXQpIxKQ
	qIdtXPybPNd87WWZdPNVhKlNyLJt6RUXrACaRhi6aZrfLCVxmHI9byRGp4JRDqv6ZJ5ZNLTGkARSp
	TJc3FEp6cbvbZ8jquewLdWBUr5liGVtEesqdW7weylom3fkKJkTxLkL4pNAJbdOAh/Eo/McYfB7XI
	cESqhAWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXUJ-00GZmq-PQ; Wed, 28 Sep 2022 13:52:35 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXUH-00GZlz-13
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 13:52:34 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id a129so12820097vsc.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Rf9QNDdnrDAvxaE9Crvmms1oitRyKkwLnQLq+OetfA8=;
        b=NcMVUImsOPfoHp/WGowopobX7m6lGBBIYaZO3RDISkgOCwoj8Admu/MZEb/QQlUley
         sLWZ1PvbXpDiktYJtgU5OC9oNI9R0d8CPe+IYVzT2sOXk+T0+MCdHcW3TjMPuoY/ngQK
         uX17iLw7O9aTK4PpFlEq6CdIyCKw6sFhbYZc/ADRPpzBhe9uzLVhvE10txXbyce6ZTYF
         gsePqzPzCUOfO0fvCGJ7EH+HKBI6GC/7oe+jAbOOPDaTUCHANnNFznkZNRuXGLwtvzqT
         tYEPpJi3q5BZtBmhHMmnNCMyA1AuJLGh/tqchgZnOL8R0xeG0aTFw1KIPMip2zw1NFOO
         Hcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Rf9QNDdnrDAvxaE9Crvmms1oitRyKkwLnQLq+OetfA8=;
        b=GQitjJvbFOiLIEV1AMr5MVIh+/Ggstya841NF6fGuiTE3SqemXIa0+RkudyjMUMbbL
         Qinaaq5pphTX9yQppAJzSV43HaxHU1Pv9kQT9e0Go3uPxNryRfTuWIXchu5+GsJwHvFU
         Zrvp32qwpC/txhZVlWZALNdJa3GTHureulA1YxXL8Rm+mMMF7lKYhjwk3R6HRJaTCf7e
         uztA/S7ckQwhVvCckkSEaLGp1Ondzwg3WjdVB1tOL2FhClWqOq+71NtLFbUrAkXbDE2o
         DDDgH4w5OxpW6+dLE3U7aOSWe1VK5FEK87jHzAaHr8XIjfnCCixgiG7/VkiSexdUnmHb
         pe+A==
X-Gm-Message-State: ACrzQf3UW8Jmf0BbU4PX3V5YAVX4VfLxcihM52Gb02CAJNkmzAapN5Em
	xLyvHX56pzauEPmM/FzDQMVx45kFnLAi+erWF+i1t8GDWqd5
X-Google-Smtp-Source: AMsMyM5J+r9ewdP1SIVEIVtlvlOIH5femBPlTML2+tz6QIfeCyELOQBWyJN/E9W04RhU9dnK4k0TfN+Ki8Fn1Uh8Y40=
X-Received: by 2002:a05:6102:21db:b0:398:28b9:5c0c with SMTP id
 r27-20020a05610221db00b0039828b95c0cmr13653710vsg.56.1664373151944; Wed, 28
 Sep 2022 06:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220927014420.71141-1-axboe@kernel.dk> <20220927014420.71141-5-axboe@kernel.dk>
In-Reply-To: <20220927014420.71141-5-axboe@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 28 Sep 2022 19:21:54 +0530
Message-ID: <CACzX3At1bziFhCyLVRYd9NJpyYeOO50Z1TwrqwkXweu4_B=ZTQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_065233_091345_836EBF79 
X-CRM114-Status: GOOD (  26.63  )
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

On Tue, Sep 27, 2022 at 7:22 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> By splitting up the metadata and non-metadata end_io handling, we can
> remove any request dependencies on the normal non-metadata IO path. This
> is in preparation for enabling the normal IO passthrough path to pass
> the ownership of the request back to the block layer.
>
> Co-developed-by: Stefan Roesch <shr@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/nvme/host/ioctl.c | 79 ++++++++++++++++++++++++++++++---------
>  1 file changed, 61 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index c80b3ecca5c8..9e356a6c96c2 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -349,9 +349,15 @@ struct nvme_uring_cmd_pdu {
>                 struct bio *bio;
>                 struct request *req;
>         };
> -       void *meta; /* kernel-resident buffer */
> -       void __user *meta_buffer;
>         u32 meta_len;
> +       u32 nvme_status;
> +       union {
> +               struct {
> +                       void *meta; /* kernel-resident buffer */
> +                       void __user *meta_buffer;
> +               };
> +               u64 result;
> +       } u;
>  };
>
>  static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
> @@ -360,11 +366,10 @@ static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
>         return (struct nvme_uring_cmd_pdu *)&ioucmd->pdu;
>  }
>
> -static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
> +static void nvme_uring_task_meta_cb(struct io_uring_cmd *ioucmd)
>  {
>         struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>         struct request *req = pdu->req;
> -       struct bio *bio = req->bio;
>         int status;
>         u64 result;
>
> @@ -375,27 +380,39 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
>
>         result = le64_to_cpu(nvme_req(req)->result.u64);
>
> -       if (pdu->meta)
> -               status = nvme_finish_user_metadata(req, pdu->meta_buffer,
> -                                       pdu->meta, pdu->meta_len, status);
> -       if (bio)
> -               blk_rq_unmap_user(bio);
> +       if (pdu->meta_len)
> +               status = nvme_finish_user_metadata(req, pdu->u.meta_buffer,
> +                                       pdu->u.meta, pdu->meta_len, status);
> +       if (req->bio)
> +               blk_rq_unmap_user(req->bio);
>         blk_mq_free_request(req);
>
>         io_uring_cmd_done(ioucmd, status, result);
>  }
>
> +static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
> +{
> +       struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> +
> +       if (pdu->bio)
> +               blk_rq_unmap_user(pdu->bio);
> +
> +       io_uring_cmd_done(ioucmd, pdu->nvme_status, pdu->u.result);
> +}
> +
>  static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>                                                 blk_status_t err)
>  {
>         struct io_uring_cmd *ioucmd = req->end_io_data;
>         struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> -       /* extract bio before reusing the same field for request */
> -       struct bio *bio = pdu->bio;
>         void *cookie = READ_ONCE(ioucmd->cookie);
>
> -       pdu->req = req;
> -       req->bio = bio;
> +       req->bio = pdu->bio;
> +       if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> +               pdu->nvme_status = -EINTR;
> +       else
> +               pdu->nvme_status = nvme_req(req)->status;
> +       pdu->u.result = le64_to_cpu(nvme_req(req)->result.u64);
>
>         /*
>          * For iopoll, complete it directly.
> @@ -406,6 +423,29 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>         else
>                 io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
>
> +       blk_mq_free_request(req);
> +       return RQ_END_IO_NONE;
> +}
> +
> +static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
> +                                                    blk_status_t err)
> +{
> +       struct io_uring_cmd *ioucmd = req->end_io_data;
> +       struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> +       void *cookie = READ_ONCE(ioucmd->cookie);
> +
> +       req->bio = pdu->bio;
> +       pdu->req = req;
> +
> +       /*
> +        * For iopoll, complete it directly.
> +        * Otherwise, move the completion to task work.
> +        */
> +       if (cookie != NULL && blk_rq_is_poll(req))
> +               nvme_uring_task_meta_cb(ioucmd);
> +       else
> +               io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_meta_cb);
> +
>         return RQ_END_IO_NONE;
>  }
>
> @@ -467,8 +507,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>                         blk_flags);
>         if (IS_ERR(req))
>                 return PTR_ERR(req);
> -       req->end_io = nvme_uring_cmd_end_io;
> -       req->end_io_data = ioucmd;
>
>         if (issue_flags & IO_URING_F_IOPOLL && rq_flags & REQ_POLLED) {
>                 if (unlikely(!req->bio)) {
> @@ -483,10 +521,15 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>         }
>         /* to free bio on completion, as req->bio will be null at that time */
>         pdu->bio = req->bio;
> -       pdu->meta = meta;
> -       pdu->meta_buffer = nvme_to_user_ptr(d.metadata);
>         pdu->meta_len = d.metadata_len;
> -
> +       req->end_io_data = ioucmd;
> +       if (pdu->meta_len) {
> +               pdu->u.meta = meta;
> +               pdu->u.meta_buffer = nvme_to_user_ptr(d.metadata);
> +               req->end_io = nvme_uring_cmd_end_io_meta;
> +       } else {
> +               req->end_io = nvme_uring_cmd_end_io;
> +       }
>         blk_execute_rq_nowait(req, false);
>         return -EIOCBQUEUED;
>  }
> --
> 2.35.1
>
Looks good.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

--
Anuj Gupta

