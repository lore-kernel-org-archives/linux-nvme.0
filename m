Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D888C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 18:42:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE81B600CC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 18:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE81B600CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wNQLxL5fT4EiTSmW5ieC0H1n87lvo+3Lx9xHbo8gCfQ=; b=Wg18kcEDdAtC8jGBnwnjH4UlDC
	skdqYY3PZDk2rNfeb8PEiJj/0fUNc1mYoyHSOyZ+Xrt0H62+7OI5uiSpo3SfMzLjKLQHHNetxr93h
	yqupWRsy8POCvMeonrRQDdYuc2PwFeS+ZS4zdJTg+ImsQg33kMEzbixw8MlhlsBShiSV/63ibbsjX
	7or0eJQO5AeuLQLuxG7yIbU16nT/CtiJrzx8Kn0LjIoPYG8s8bUjKPWOj8CFjiQYF1qbw+fxOGOgq
	IX6r44aIvpAiHe5ghtjY3oH1/iJujuCzdC51vHq8eTpXxnMw1U7ymrmbjVEBM3QzCyXmEQuAcINtx
	DNIhmaEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1majCG-000KN2-DU; Wed, 13 Oct 2021 18:41:48 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1majCC-000KKr-TI
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 18:41:46 +0000
Received: by mail-wr1-x436.google.com with SMTP id i12so11445124wrb.7
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=wNQLxL5fT4EiTSmW5ieC0H1n87lvo+3Lx9xHbo8gCfQ=;
 b=6x5PEfVYV9dk0TgkWnODuEW8HBlAHEHe5lFbg3kjPx4XnizNr0AzRQFEi2FkDTRafl
 qp7aAMgyO2H4RjcjYDZHk80PK5mrF/mAueUFu6TLpaLUNaHzQwYaxW/ENCOCnNYC4kSi
 cNFcvyaq9bX1Y01hd0Jg/xPoxL7/kp3Eut/0uJvHxdwP44B+tL/wl/JDoM8BDLvRaxWE
 ADqNyax9jX1a1tLST/Q/Iv2kkRKP9Uzy5AIRT92GP/D47mElzvwZswGt1uz25/mpE7GO
 4WMRvPvIftKmyRnaLNGdpvZJN+OQabZLOJbKasFTscc0ZWiPHBW1W0M+icgLcbJWvZ1I
 SKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wNQLxL5fT4EiTSmW5ieC0H1n87lvo+3Lx9xHbo8gCfQ=;
 b=u6KvyZFxsOmh710CobaFcS4X9FSaof4L7z9d46hCSb87SitX66Jr8HEIsaS/Oe9I+m
 J1eZ6ZhavKD596oIZu5Q3f0ac3kwmAz7P11AlTO0XeTFiVcWQrOsUp8YVX2kDeVPmDzp
 zpnJ3BtkUH/tfUMLmMmrZpz85KlOSdejg6pPmdL+pHGdTq+OGEj2a6AR9SFLJw6Wd2Rm
 gI8sNrF0v67vQ0J4yo10TIG4QZj1w/hwMohYNbzsV3brkO2mPBNSDksjn9Ul847blLaa
 HMry3RyhhrmFeuFZqNyf2XmoRP5asMkcJGh++ZJY3rDpteLWCgyHeFiAXQ5V+a7VrIbe
 koWA==
X-Gm-Message-State: AOAM533naig6yRW6n/CGZgZ4Hr0JsMkqYH1JPrYXFbW1/ji/bRQxirbe
 /I7vuDEbuJ/77aQxaDfSweOkWg==
X-Google-Smtp-Source: ABdhPJx+LOfDiWVro2yW4L9TMnVs6CvlieIvsnKNOKpZoZs47dGlEL1TOhE6zrGPAHs7vPwDLqiV0Q==
X-Received: by 2002:adf:d1ee:: with SMTP id g14mr917508wrd.165.1634150501848; 
 Wed, 13 Oct 2021 11:41:41 -0700 (PDT)
Received: from localhost (5.186.124.144.cgn.fibianet.dk. [5.186.124.144])
 by smtp.gmail.com with ESMTPSA id h11sm315191wrz.5.2021.10.13.11.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 11:41:41 -0700 (PDT)
From: "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?=
 <javier.gonz@samsung.com>
Date: Wed, 13 Oct 2021 20:41:40 +0200
To: Adam Manzanares <a.manzanares@samsung.com>
Cc: "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Cleanup per-namespace chardev deletion
Message-ID: <20211013184140.fevatn7xt6h565ow@mpHalley-2.local>
References: <CGME20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959@uscas1p2.samsung.com>
 <20211013150413.320133-1-a.manzanares@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211013150413.320133-1-a.manzanares@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_114145_037116_207DC693 
X-CRM114-Status: GOOD (  13.71  )
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

On 13.10.2021 15:04, Adam Manzanares wrote:
>Decrease reference count of chardevice during char device deletion in order to
>fix a kmemleak. Add relese function for the device associated chardev and moved
>ida_simple_remove into the release function.
>
>Fixes: 2637bae (nvme: introduce generic per-namespace chardev)
>Reported-by: Yi Zhang <yi.zhang@redhat.com>
>Suggested-by: Sagi Grimberg <sagi@grimberg.me>
>Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
>---
> drivers/nvme/host/core.c      | 21 ++++++++++++---------
> drivers/nvme/host/multipath.c |  2 --
> 2 files changed, 12 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index f9a25c61fb8b..3bc4bb620ab7 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -3583,10 +3583,15 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
> 	return 0;
> }
>
>+static void nvme_cdev_rel(struct device *dev)
>+{
>+	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
>+}
>+
> void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
> {
> 	cdev_device_del(cdev, cdev_device);
>-	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(cdev_device->devt));
>+	put_device(cdev_device);
> }
>
> int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
>@@ -3599,14 +3604,14 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> 		return minor;
> 	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
> 	cdev_device->class = nvme_ns_chr_class;
>+	cdev_device->release = nvme_cdev_rel;
> 	device_initialize(cdev_device);
> 	cdev_init(cdev, fops);
> 	cdev->owner = owner;
> 	ret = cdev_device_add(cdev, cdev_device);
>-	if (ret) {
>+	if (ret)
> 		put_device(cdev_device);
>-		ida_simple_remove(&nvme_ns_chr_minor_ida, minor);
>-	}
>+
> 	return ret;
> }
>
>@@ -3638,11 +3643,9 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
> 			   ns->ctrl->instance, ns->head->instance);
> 	if (ret)
> 		return ret;
>-	ret = nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
>-			    ns->ctrl->ops->module);
>-	if (ret)
>-		kfree_const(ns->cdev_device.kobj.name);
>-	return ret;
>+
>+	return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
>+			     ns->ctrl->ops->module);
> }
>
> static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>index fb96e900dd3a..bd490a7c4808 100644
>--- a/drivers/nvme/host/multipath.c
>+++ b/drivers/nvme/host/multipath.c
>@@ -434,8 +434,6 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
> 		return ret;
> 	ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
> 			    &nvme_ns_head_chr_fops, THIS_MODULE);
>-	if (ret)
>-		kfree_const(head->cdev_device.kobj.name);
> 	return ret;
> }
>
>-- 
>2.25.1

Thanks for taking a look at this Adam. Looks good to me.

Reviewed-by: Javier González <javier@javigon.com>

