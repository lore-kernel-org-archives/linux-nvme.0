Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A248C5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 06:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xspKBQpiRhuPQgMtzGTua3ey0cy+poxPpbLU5IANlw8=; b=EopERM4r02vMGIB4N/fbw6gG+c
	tQy8eJb8rMoLQEMFbv9Ja2dnrhH+2sn6P3aWcn1Mhfh+22JNnmDDYJhI5u5q0SoHNtClpvtNlw0fH
	O+Al7ECg5FN4cHY8EnkRmPOUoOTqZupmgSXVn6/y1ZtfOVAW/0eC6S0p1ADer4/7C/9laQZq7gMNL
	TsoJmP5ssXHlRkvDnwLu1tJ2orVw1ea2YRnGS8hPt4Q/y9wfGTjXyXpxb9+N5DmzWru9Tn0zQAy1N
	ga8GHXX5S2hwTryynkjU28Z4SNAlxzaXkE4rGvtTqxI/JXmJ/HWNZynW0uwNGh2nljHEbDO8jPvBa
	qhdeIQ1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrGP-00000005VLr-16SJ;
	Mon, 17 Aug 2026 06:56:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrGJ-00000005VLS-0XX8
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 06:56:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A55A68CFE; Mon, 17 Aug 2026 08:55:54 +0200 (CEST)
Date: Mon, 17 Aug 2026 08:55:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
Message-ID: <20260817065553.GB16255@lst.de>
References: <20260816191729.2865523-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816191729.2865523-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_235559_343218_8CD5A5DD 
X-CRM114-Status: GOOD (  19.67  )
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

On Sun, Aug 16, 2026 at 03:17:29PM -0400, Chao Shi wrote:
> nvme_query_zone_info() returns either a negative errno or a positive
> NVMe status code, but nvme_update_ns_info_block() only tests for the
> negative case:
> 
> 	ret = nvme_query_zone_info(ns, lbaf, &zi);
> 	if (ret < 0)
> 		goto out;
> 
> If the device fails the Identify Namespace (I/O Command Set specific)
> command, or the Identify Controller command issued by
> nvme_set_max_append(), the positive status falls through and setup
> continues with the zero-initialized zone info.  nvme_update_zone_info()
> then marks the queue zoned with chunk_sectors and ns->head->zsze set to
> zero.
> 
> blk_validate_zoned_limits() does not check chunk_sectors, so the limits
> commit succeeds.  blk_revalidate_disk_zones() does reject the zero zone
> size, but by then the limits are live and nothing rolls them back, so
> I/O keeps being submitted to a zoned queue with a zero zone size and
> disk_zone_no() shifts by ilog2(0):

Did you do error injections to get here?

> +	/*
> +	 * A failed zone info query leaves zi zero-initialized.  Leave the
> +	 * namespace registered so that it can still be used as a device
> +	 * handle, but do not configure the zoned limits from it.
> +	 */
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -	    ns->head->ids.csi == NVME_CSI_ZNS)
> +	    ns->head->ids.csi == NVME_CSI_ZNS && zi.zone_size)
>  		nvme_update_zone_info(ns, &lim, &zi);

The most common case for this is probably during revalidation of some
kind, and then we'll just keep the old values.  Which in general
should be fine, but might be worth mentioning in this comment?

Also we should probably log a message that we either just register
the handle or keep the old values?


