Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EB7C5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=++b0GHZbwINw/a9aQSLlA8nye5n4fj9t5uGfoHxF3GQ=; b=dm56N0/mVCuE/OUAzmLYGw8r3z
	L7jBalYHyKLcmxVfBIhhOUgdT5pejX6QcFpOAHRmaZRPX417Wv1Yqg4juuZf6LA3TYJBK2cgONuPA
	gzSqWeNcU5Mbk7DRZk5DeTxCEk/JBj4DYADh429N3RSGEKDOAnlxI/ssBDBUG0sjHQpWp9c65Ksj3
	soMOocntOAKJhkLDzaN3m1wtIRi0QoelQoto69ifziiWdE3Cnn3JZ9wP/MyLF/2Bg9L259CpeAK4O
	rSIDRGnukcLIsGxSz5oHHx+C+4ghTSGjTyHOpWheUjge1aY4JYUZiTpsEnVByIcO2LRTlTIOnCnJm
	+7hW/mvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiGv-0000000A5tf-26AK;
	Wed, 19 Aug 2026 15:32:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiGt-0000000A5tJ-409b
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:32:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 671CE41750;
	Wed, 19 Aug 2026 15:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E511D1F000E9;
	Wed, 19 Aug 2026 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153527;
	bh=++b0GHZbwINw/a9aQSLlA8nye5n4fj9t5uGfoHxF3GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yy2D6ah0JQKy+rs65htcfWd5uWNNZDATwLS00+WVE3r2/IU1OenZjv+iGy/OWWAYy
	 1+9EbCB1S9sOOZ7VMuUG31jHvDtzRHUwMvH/N22fcqwHEhvxAXvxjbgl1wzqAMh6w5
	 Omys6uw2YMxX2JLhAU7fMGjsSRO/B1/XE61tsw04OYo0XfHN9b6wZUX9fC9NeQ/N3P
	 mYlytbDw/3G0ukHr7sGygjWFZ+n0oH2KCrYr8hfQOm8X5iA7QX767Y3WhIs2oTd1L3
	 d3Zrw1ZFZAeSjFagZyZbcG9wzR91Fj1JPUIJULLSoMT/KNb7oaF12736CVtJ1XIE+3
	 XiKFE+LB+qCmQ==
Date: Wed, 19 Aug 2026 09:32:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, dlemoal@kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v3] nvme: skip the zoned limits update if the zone info
 query failed
Message-ID: <aoXMdbA6laYL6aXk@kbusch-mbp>
References: <20260817175859.2966055-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817175859.2966055-1-coshi036@gmail.com>
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

On Mon, Aug 17, 2026 at 01:58:59PM -0400, Chao Shi wrote:
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

Thanks, applied to nvme-7.3.

