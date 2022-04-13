Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351EDC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+wOuIUOXibRl+1dVZmmIMEUBnBAgw53P0fwliE5bPVs=; b=4zluNDbgh5pWl43mrYId1a5BWK
	wfvQa/yXcPXcLSmbEcMdlrYJOvJvAeOe4dBPnpu6P+fcROnLfSsd2PvXRbe6eOP2apMP0Rmvoi2WT
	cdikdAzWKx7bAKwTL6FfQe8MN+nyKUys+HkfMtGbOtPiVrksNyzRX86ZEalQ5vGpxg9SWJBk45k51
	dBS5VKF/hLY2WLR//Bhd9BaOdYRXlLaCV8rpW9O8vRNjvRxDzVdgqH+0jppEwyBmnO58oUmW3va3z
	UdPUZXT9PYjB8JAR1Vvr9TerA6+m72MY8tZ30Ml80uY8y21kG56O0NjM8wyxHBTEAmN5uMuaNduq9
	OIllkyHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nebnN-000v3M-O6; Wed, 13 Apr 2022 12:08:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nebms-000usr-6u
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 12:07:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649851671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+wOuIUOXibRl+1dVZmmIMEUBnBAgw53P0fwliE5bPVs=;
 b=ZHrS8Fq5RLu0/0W/hGD32H1aHNYu7d/+ziAkzpWz8q4zsiInSPVetZveo2CxHB07q/MjI6
 w/8yingbOWPRngCncbK61Ta+yQJJ72+YLdtVxc2bl3AJGEqsljA8A8xzG6iQhnO977Us9u
 XB2K3JRaES2itWrnbh/qftX78bgGyz4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-YUXP8xgrPZqySvfYWFIwJg-1; Wed, 13 Apr 2022 08:07:50 -0400
X-MC-Unique: YUXP8xgrPZqySvfYWFIwJg-1
Received: by mail-pf1-f199.google.com with SMTP id
 h192-20020a6283c9000000b0050612d1c326so1252425pfe.8
 for <linux-nvme@lists.infradead.org>; Wed, 13 Apr 2022 05:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+wOuIUOXibRl+1dVZmmIMEUBnBAgw53P0fwliE5bPVs=;
 b=PVKnl6GaOZlltHP6BGYSnrL3WKVyo19qE4gbZHM5sl9Euv96kbEzFhhCQ4JuG4/1tz
 Yfw3QvqF9rxrFmbeBQH8FofGIBj4i0f8PSrVhLrmt1t84V9zCamV5HJAnyZgpDRdbg48
 64AQU7bI9vdZOnlvJtnY5csvtm1IfUsEt5O3YtZ2vTYOPEcoWYl/VnSE5WQSy8So1F5d
 /RcOa+Elttw3xLOeHsX4bevu9Cn30LP+2GxW6ojXlS6FHgwYnjXBIAh+RMKq5+hT5IM7
 7nd6Hjq3SOCv7Ee1mfouTmbzwSFZOEqJ647jMF79xgwwzAzWXrvQPoW+akB5E4IOqH9E
 DbWw==
X-Gm-Message-State: AOAM531FjcZ6RgPk9ky+TDR66hyQLdoycWbnPYUnJqB/I+9UDtuqqlzb
 AoVAonlxT3HlpAA3fHwhPL44uWHRzG+8Lr+hx3PMbvjXJxg3PUkcIyOnFQvsfsWo6vocxUdiaRM
 hLcWHK494fcn8S3RVxN2vpSzGYxErnM50w0x7/sDUdrg=
X-Received: by 2002:aa7:920b:0:b0:505:66a5:3029 with SMTP id
 11-20020aa7920b000000b0050566a53029mr9395245pfo.40.1649851668505; 
 Wed, 13 Apr 2022 05:07:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN1Zy2YteV5iwhas1TxkDc4VJtuGX3UqDaxcSNY+xeEFljpbkl//chkxR6SXzG7e/VO2rWXu+RV163ULb5OYk=
X-Received: by 2002:aa7:920b:0:b0:505:66a5:3029 with SMTP id
 11-20020aa7920b000000b0050566a53029mr9395221pfo.40.1649851668263; Wed, 13 Apr
 2022 05:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
In-Reply-To: <20220411031249.5158-4-kch@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 13 Apr 2022 20:07:36 +0800
Message-ID: <CAHj4cs8Teng17XnDc8t5bjZzL1Gv=9+hnvghvkQBqUHKWYWvUA@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_050754_384941_7AD89CA8 
X-CRM114-Status: GOOD (  17.58  )
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

Verified the issue with this patch I reported here:
https://lore.kernel.org/linux-nvme/CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com/

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Mon, Apr 11, 2022 at 11:21 AM Chaitanya Kulkarni <kch@nvidia.com> wrote:
>
> Mark internal passthru requests quiet in the submission path with
> RQF_QUIET flag added in the __nvme_submit_sync_cmd(). In the completion
> path, if nvme request is resulted in the error and request is marked
> RQF_QUIET then don't log the error with nvme_error_log().
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 449378a96a9f..12302be83a6c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -370,7 +370,7 @@ static inline void nvme_end_req(struct request *req)
>  {
>         blk_status_t status = nvme_error_status(nvme_req(req)->status);
>
> -       if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
> +       if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET)))
>                 nvme_log_error(req);
>         nvme_end_req_zoned(req);
>         nvme_trace_bio_complete(req);
> @@ -1100,6 +1100,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>                         goto out;
>         }
>
> +       req->rq_flags |= RQF_QUIET;
>         ret = nvme_execute_rq(req, at_head);
>         if (result && ret >= 0)
>                 *result = nvme_req(req)->result;
> --
> 2.29.0
>
>


-- 
Best Regards,
  Yi Zhang


