Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F2AC5CFC1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3KTA9pFWou7k4BD0I50OFBJZVGzJdeantpCxQ/xUzxg=; b=Bsxt88733loqMFmEkrFUVauUw3
	Y/De4heJNZEunX6x8Y6e5IbQCUM2lF+HAB5gvoBuCcoAMA6SbIsgSiLQQNw9T2FGixeXy4BfPi/Me
	ZV7FLcu09sJfjI7hewnFGY3XQPiZKCg169A7ZmW+RTPeyKA4+BYnVmDyoWbiGDJEAlm/Dpr359pmp
	1hqLPtd4osAtvW7RgfU8h0F4hvGHFagiYpoEa9XG4FJEtC8sT1+FRuwu0V89qf7plIAa4AlW1x8r2
	R09snZGp4Ck58ui7CWaxVIzs9rQJPRY1Tz1tD048U4OLrWUFBn67oasvr5nH03rd6a4CCpO7NBcXJ
	txFtQcAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuxaG-000000036GV-0GxP;
	Fri, 14 Aug 2026 19:28:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuxaE-000000036GL-2uit
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 19:28:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D2FA960008;
	Fri, 14 Aug 2026 19:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB621F000E9;
	Fri, 14 Aug 2026 19:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786735729;
	bh=3KTA9pFWou7k4BD0I50OFBJZVGzJdeantpCxQ/xUzxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=giLxFmsBcug+RdQiBSf1Z+HKoYe95INxef9uuB2zQ/dWbsPTNgEbAEZrxlBxezvBq
	 J7AwYqBRiuZeRnd8cbT5byga7e458LHoqA20B5Uh4lY+ztLy/RNhKT8U7g40RBUcpo
	 8W4jv+klCGsGoGKiXkplVOPsoXJgSmz10E/uNTuRXE7uUWYY5IaHAGdFIvClmB13z/
	 PZ+oj+xygD6WJktOfulrOkaFSSa2LZ2C895mY38BcxXSEaIApM7kYc0ZAF1MtFYlCC
	 +seMs0BNeqCgHfc6TyKtWNf6vZ9xSym+imKJ/0Ty88cj/s8QxC+IHAYudXjFRXx4nP
	 wg37KIM/rtiUw==
Date: Fri, 14 Aug 2026 13:28:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
	weizhu@fiu.edu, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: reject zoned namespaces whose zone info query
 failed
Message-ID: <an9sbzM52QqKdQuP@kbusch-mbp>
References: <20260814160954.2839507-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814160954.2839507-1-coshi036@gmail.com>
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

On Fri, Aug 14, 2026 at 12:09:54PM -0400, Chao Shi wrote:
> Before commit c85c9ab926a5 ("nvme: split nvme_update_zone_info") the
> caller tested "if (ret)" and bailed out on any non-zero return.  Restore
> that behaviour.

I think the namespace is generally left up on purpose for controller
reported errors so that we have a device handle for admin debugging
purposes.

Can you just skip the zone limits update when you have a bad response?
Something like:

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2457,7 +2457,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
                capacity = 0;

        if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-           ns->head->ids.csi == NVME_CSI_ZNS)
+           ns->head->ids.csi == NVME_CSI_ZNS &&
+           zi.max_open_zones)
                nvme_update_zone_info(ns, &lim, &zi);

        if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)

