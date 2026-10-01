Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D193ECA5FCE
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2026 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KofKL6DMyNwNkFRP22JD3bKVkyzb29TfyRjV0Y0r2Ug=; b=lFxV9E187TjlS4k5fluOH45oKe
	IHzaolLH1ENk79RZHCzXgAZsa0Rhh9QpKj4wWGB27KTkJvnM/paHGdjl8x9nbxZwE/4P+cJVSPcFA
	L+NskssU7wPHBk4sSafzLSEZqJbNPFrgy6sOtkKbmNCM2mWIOeE7plB3lQkur6KoD0FpT7t4ZG9pC
	I0T1bcIh6xivuOtP3IrMY5kocAxzOLCk9B++iTr9L8hmPlc6EJ/iviwKxXuw1WgBqDd4gomwafgW1
	ZwzmHUUCodoIoVjTCP5rxtEonCD+LBrOSzv1bp0JSQaKX74PYOq/Gx0vdwZiRHIRpzCXFz0BvA7+8
	KPiAdpGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCLEk-00000009xCc-1988;
	Thu, 01 Oct 2026 18:10:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCLEj-00000009xCL-1Ke9
	for linux-nvme@lists.infradead.org;
	Thu, 01 Oct 2026 18:10:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A8EA9437FA;
	Thu,  1 Oct 2026 18:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623CD1F000FF;
	Thu,  1 Oct 2026 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790878228;
	bh=KofKL6DMyNwNkFRP22JD3bKVkyzb29TfyRjV0Y0r2Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ac2A2e/1DeJpjHbdIlYtlc+6CQqqF/PXDx6JHdS/ed69jP1C9UqP2vRJsvXiPHGmz
	 ws0jxuHv4us6LHnU1dg4EB+0EssuL4AuT+JTnkMiFLq54ZkYlsIGfzVc6y/5sRR5nI
	 /YESSgJG389pcBLZH9S2PTODgL9d0gaDFwux97KyvDkCuifnTB8R04D4ijp0xjP1CL
	 x8a/ZaVyjlJON9QokgNIBAUKTxFHvbaFzSQeNu8hnNQyKzeb5h3FEy6zAq67rqHkOG
	 pUjG4deHNgVvZXKH9IFBFm57bI6tbkJ3o1OZ9+z2dms7aId7MSaxFwCexNezcmbV2o
	 5A3o/TJxPJZQA==
Date: Thu, 01 Oct 2026 08:10:27 -1000
Message-ID: <b214a375adad1579b2b17c0e9a0f4869@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peng Yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] nvmet: add cgroup_id to charge namespace I/O to a
 cgroup
In-Reply-To: <20260929232411.101087-3-yupeng0921@gmail.com>
References: <20260929232411.101087-1-yupeng0921@gmail.com>
 <20260929232411.101087-3-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Hello, Peng.

On Tue, Sep 29, 2026 at 04:24:11PM -0700, Peng Yu wrote:
> Implementation:
> * Add a `cgroup_id` attribute under the nvmet namespace folder, e.g.:
>   /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/cgroup_id
> * We can write a cgroup id to it, then that cgroup will control
>   the IOs used by the namespace.

This doesn't follow the usual description format or content. Can you
write it as prose explaining why the change is needed and what it does,
along the lines of the scenario section in the cover letter?

> +CONFIGFS_ATTR(nvmet_ns_, cgroup_id);

Documentation/ABI/stable/configfs-nvmet has an entry for each namespace
attribute. Can you add one for cgroup_id? It should say that it takes a
cgroup2 ID, that 0 clears it, that it can only be changed while the
namespace is disabled, and that the namespace's I/Os are charged to the
cgroup's effective io css.

> +static inline void nvmet_blkcg_set_bio(struct nvmet_ns *ns, struct bio *bio)
> +{
> +	struct cgroup_subsys_state *css;
> +
> +	if (!ns->cgrp)
> +		return;
> +
> +	css = cgroup_get_e_css(ns->cgrp, &io_cgrp_subsys);
> +	bio_associate_blkg_from_css(bio, css);
> +	css_put(css);
> +}

bio_init() and bio_alloc() already associate the bio with the current
kthread's blkcg, so each of these bios gets associated twice. If the rw
and zone append paths wrapped their bio allocations in
nvmet_blkcg_begin()/end() like the discard and flush paths do, this
function wouldn't be needed and chained bios would be covered
automatically. Not a blocker either way.

Otherwise, from the cgroup side, this looks fine to me.

Thanks.

--
tejun

