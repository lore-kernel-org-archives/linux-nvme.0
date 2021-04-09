Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD43C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:19:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D07360FD7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D07360FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vdeKE01UijvNkYg4QcnA/bpg7HzF+osiOS5IJ3Qwqgs=; b=hwpAf9fbkn/L1alrwg6vjcMwy
	izuzwVSVPEnXoWarF3nosm8zz4rfhCpCOWrZjGXSPm5CKADeLhppP2TP/UTB76sGW1B/80yfN6WG5
	Vg7zY40AL627kJBuHQKmGgWm2Qn7exlMOn+8n2AmEC7JK9QEQ95BEGVbC0e+sTX3mmLlFo6EV+1Oz
	43TBDK8FXBlzqX1vx7FllA7t33EVXCijy/8hYx6D0xhf88k1+bUN2WqPe93XiQki6+upMEjTLltlG
	99s8jDiJ1KOZmZrS6lHx4gl6+exiVwnHkXtC+tqXRTeo79zjXQ4oyRprVDwg0mVBqooywY58c1Tns
	zMZ9i2qCA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUnHz-000DA6-UY; Fri, 09 Apr 2021 09:18:56 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUnHt-000D8u-C5
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 09:18:51 +0000
Received: by mail-wr1-x432.google.com with SMTP id a4so4910807wrr.2
 for <linux-nvme@lists.infradead.org>; Fri, 09 Apr 2021 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G3rY1cxOAvOfelsF+S9vVGGwqBajVxF5jXYNWGDHInE=;
 b=geWyREMMdh+oLD6aulH4ejoO8SXzY9fswzws5BAZgNoPvGJNpwN2XagZvpncCN8QPY
 WLNj+zPxV2sP3gANaR3ywB26qfbfC0KV0iOIE5mMjDvPh44Rr6+SiIVtEYnggFsYUNeo
 FPvI112wa+DwiNhINslpPWtg/4EdYbOYH3W3PYVcvdtJS0eoG4OjSVORIbSc1I9JHxZJ
 GAxR5csr5vUcuVBGnBzT0+DRxhQgnHaRuMyqq7vQyh0/9+KCnToBIK43yIXjlGzTmV63
 k91juCRZk2YDlrysfs9EC1nVlWQmcLRw4Ct/Nqmi9py5EzOBjNIeryKHJ4VmQdtKJX2/
 qPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G3rY1cxOAvOfelsF+S9vVGGwqBajVxF5jXYNWGDHInE=;
 b=jH2x7aZn880myTwaAJ+aeO5eiEPvHu3xhYjE1x6Sf5e6gC5flFviFU9mz51R9bSN0t
 mQBrJ1XBKiEpwXYxNxPxiqKBz5Rg4dNoF2CiOIsUc8WKUuIJA9PB6jsoXGWJEPqnkT/j
 yhJwnA9sqDZpiW8nN5pc2xLScESLG7ksfjseqB2Mc0fCe1B/PPr60fIgCPBlL0dxbeV5
 JDzX4Ve0aZKTupIfqbAu0I1uMvVUft7z9pDwxvPRwdyfNhUIw4m+2Kpxn+nnGn95jWOV
 kCJ3uyVUOepghrIiUqRyhGnmy/oKDrTrEReaW2YBr0j4xDSpy8BQFSdjKNFfxYB5gT1H
 6qug==
X-Gm-Message-State: AOAM5316abwiGMk+M/vnp3YRML/AkY1V7R8F1F6DlUgZPpYvFNYm+TSN
 K5U91By8IVBWWLLKyuYQXnE8IEOJ83aahShAnb4=
X-Google-Smtp-Source: ABdhPJzQNKo0NCS/gev/84LFJdl/t7cFk/P0MbontupAc3TEEC8fojLUF077JyIOEUXaSsjQ4xMUUHOBSRb4KLWIG/c=
X-Received: by 2002:a5d:66c9:: with SMTP id k9mr16328868wrw.278.1617959927509; 
 Fri, 09 Apr 2021 02:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-10-hch@lst.de>
In-Reply-To: <20210408120842.1450092-10-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 9 Apr 2021 14:48:20 +0530
Message-ID: <CA+1E3rJU_WT9f2Gzdk66kho+5h2h-gkmrq8SpsvO-Oz073Y6vQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] nvme: factor out a nvme_tryget_ns_head helper
To: Christoph Hellwig <hch@lst.de>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, "Javier Gonz??lez" <javier.gonz@samsung.com>,
 linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_101849_501024_9ED01754 
X-CRM114-Status: GOOD (  18.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 8, 2021 at 5:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper to avoid opencoding ns_head->ref manipulations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 98d87bff4ca37f..9637f2e5e9232c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -549,6 +549,11 @@ static void nvme_free_ns_head(struct kref *ref)
>         kfree(head);
>  }
>
> +static bool nvme_tryget_ns_head(struct nvme_ns_head *head)
> +{
> +       return kref_get_unless_zero(&head->ref);
> +}
> +
>  static void nvme_put_ns_head(struct nvme_ns_head *head)
>  {
>         kref_put(&head->ref, nvme_free_ns_head);
> @@ -1975,9 +1980,7 @@ static const struct block_device_operations nvme_bdev_ops = {
>  #ifdef CONFIG_NVME_MULTIPATH
>  static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
>  {
> -       struct nvme_ns_head *head = bdev->bd_disk->private_data;
> -
> -       if (!kref_get_unless_zero(&head->ref))
> +       if (!nvme_tryget_ns_head(bdev->bd_disk->private_data))
>                 return -ENXIO;
>         return 0;
>  }

This new helper needs to be added inside nvme_find_ns_head() as well?

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
