Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E421C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Dec 2022 01:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q6O+8sIbmtUdK3kcKARbRA3cqR3wjrxcdpxb5NGJwyQ=; b=OsbH0DH02cv6mSi+pGyQzum8Za
	8AQPQF22twVxr6VHmfSipQSXI9X5Hy94pWYCLqUKkcrveb+zdX3c7QXiBPi3jLbwN2iFwUvMp3Ir3
	hKyfcJm9Fy8DmEmg4v5zQyI3KD7y5QgtGfqMqBLBR3U0FUncypZyi5OwPAJt6+N/cqf3jCypc2Suy
	8rVClPtIhoInNsr5VDB/Hi8VVZRzdQrFsdv/hmo+R+lzivbu2cn4uk2OfDN5tCUfLsuWcabEc7VFL
	YnZqfF9GqwLspsnayoU1r8z2R8HXRIKrtG6PTt/D7o8snmNKVjgJrwk/7rWPreDvO/1VjtIvG0HRq
	DDbl5/GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9c75-0008Oz-1Y; Mon, 26 Dec 2022 01:17:11 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9YLb-00FXfZ-UR
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 21:16:01 +0000
Received: by mail-qv1-xf36.google.com with SMTP id d2so6525030qvp.12
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 13:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6O+8sIbmtUdK3kcKARbRA3cqR3wjrxcdpxb5NGJwyQ=;
        b=bgILBOyQ+nAgN/36JeRi/pwK+aZyD8DLrxcX8qsZHenA6C3P2FiylI5gpg4cYPaiOL
         6ceufmhMGZDUm2FEyO44cWWT2HlIl7K/EMA0jNjkYOkothsdna5r2ewxRhl/iyhj8ZTz
         6yCChSU7VjmUqkmIbg9BXSpo7mJWoXM96/aB+igvD5K0bKv99aXBHRVPrDjON7d0j3BN
         OwqDaY9V+dQXlqFH61A1fqCS0q+PW04fLXtZDbkCswEdOBoOtNCLCcNBFRCkY3YyEUwi
         xKMSGJJnNwWA3EEC8zAf0V9mnG/4dvYKMxCtNMn6U6kVarMfNwwpt4If/v8g5jWGRrGg
         OPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6O+8sIbmtUdK3kcKARbRA3cqR3wjrxcdpxb5NGJwyQ=;
        b=f0oaguBZKTgk6mCVWwhIYQ1Od1MRjR3ls2qCTCMbcLGqkmtqTHYWmVfi2mVydNAQ7Y
         ENFwTfuUS1K9RnOxCjmersnlukS4pmtAgQ7y9UWJTzRsBSs8zh4yHTC6xd4GU3y/vS8q
         8S/bwR62h2jPwhO7KeLPMuKuCTRj5DDkYbh+3ghSU7Mm+01pVNpBd389M3da+AQnzvsx
         LuYLaoY3UBqqgGv6kLO03FpYy7zoB6PZ/rJIvskqFsvLmgcudBng2GKomOzHFWDJx8XM
         wp4LpdKpLDZOhDjvuWfMsLfLUgPWoJrGoFh705DGCaBWKnr55IStHcyQ/TI0y/mhobpQ
         FZgw==
X-Gm-Message-State: AFqh2kpi52QNg+U9Q4WdTYp+u/GPJu4rSg4NMKL3VUpJC+Eb6D6sbwMe
	BXOgQmBjMr/JmaAa9IQFt6Mfxw==
X-Google-Smtp-Source: AMrXdXtK3iWRxzebJHJRjID2JBAyp/nJlSZ06OMVwql34/8+9sHz4fu5WQW6HjcP3/OEZZdVK8G6Ug==
X-Received: by 2002:ad4:4e8a:0:b0:4c6:f5bd:2cb9 with SMTP id dy10-20020ad44e8a000000b004c6f5bd2cb9mr24201938qvb.33.1672002951918;
        Sun, 25 Dec 2022 13:15:51 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m20-20020a05620a24d400b006fc9fe67e34sm6679888qkn.81.2022.12.25.13.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 13:15:51 -0800 (PST)
Date: Sun, 25 Dec 2022 13:15:40 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Christoph Hellwig <hch@lst.de>
cc: Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@fb.com>, 
    Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
    Hugh Dickins <hughd@google.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvme: fix setting the queue depth in
 nvme_alloc_io_tag_set
In-Reply-To: <20221225103234.226794-2-hch@lst.de>
Message-ID: <c693b16b-8233-c698-c710-e7a232686c61@google.com>
References: <20221225103234.226794-1-hch@lst.de> <20221225103234.226794-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_131559_383117_1DCBEC87 
X-CRM114-Status: GOOD (  21.72  )
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

On Sun, 25 Dec 2022, Christoph Hellwig wrote:

> While the CAP.MQES field in NVMe is a 0s based filed with a natural one
> off, we also need to account for the queue wrap condition and fix undo
> the one off again in nvme_alloc_io_tag_set.  This was never properly
> done by the fabrics drivers, but they don't seem to care because there
> is no actual physical queue that can wrap around, but it became a
> problem when converting over the PCIe driver.  Also add back the
> BLK_MQ_MAX_DEPTH check that was lost in the same commit.
> 
> Fixes: 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Hugh Dickins <hughd@google.com>

> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e26b085a007aea..cda1361e6d4fbb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4897,7 +4897,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  
>  	memset(set, 0, sizeof(*set));
>  	set->ops = ops;
> -	set->queue_depth = ctrl->sqsize + 1;
> +	set->queue_depth = min_t(unsigned, ctrl->sqsize, BLK_MQ_MAX_DEPTH - 1);
>  	/*
>  	 * Some Apple controllers requires tags to be unique across admin and
>  	 * the (only) I/O queue, so reserve the first 32 tags of the I/O queue.
> -- 
> 2.35.1
> 
> 

