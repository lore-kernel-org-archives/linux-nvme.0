Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22E7CA5FA2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Subject:Cc:To:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jFgegtxrqBLiSDoehqBbaOYTYpSiUebKsQY5pgr6G+M=; b=vaAwkBX8VdlI3y7L5WZNsBJxsh
	0426f1B2EfuRA60BXyS1rMgI8Oou5fHb3DajKG64YoLUv/6XAcShoae+DmD5Pb6A90VNb6bb4SLQM
	jNxU2yEFIG42AMh7mWCSx0Qw2268XWlMY1myuN34k5hjtb6Xvb19mLKXdnGGoV6I0P3nePsSmE3QH
	YR2VKGXLzxMz5hNV91qzUiuxsM8OiZYjChIVPGNHx9PPNbSzKhRMHWsa9PEFLAUgceSQJ4BeZ4ySh
	93FbFsuSFzrg52o8H+hULFV3bWkOfaJv3iIIx4czEnCy4hVpnAC51xZQF0UAS4MrSEkpesdDPRdPE
	pcga1Yng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBG1t-00000001JKM-2LcK;
	Mon, 28 Sep 2026 18:24:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBG1s-00000001JKG-1o59
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 18:24:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 16A5F4343A;
	Mon, 28 Sep 2026 18:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D241F000FF;
	Mon, 28 Sep 2026 18:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790619882;
	bh=jFgegtxrqBLiSDoehqBbaOYTYpSiUebKsQY5pgr6G+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JXEl6xoISVDdzEfU5MH19jz7JFJTYMQWsyJMMaCTTEg5BSRtsUV7kLJy1NKhv+oX4
	 F6Vo06jedsKB3C+Y42PEdDmvCkCdP1OScHxKcz9YOl7s85sLV1VkupV40OtI0RhRzI
	 6iJid23uoc1Vl+VpVOZ75SPAUd+Fo5vu3BMx4r6EdK2GAPcKBiRneoa43wE/H/1Kyt
	 iKDRt5SHpp0MVtqKQZTE+kVb2LKXj7XsJj31o2agOCxvZuRsWvLKlNVDZdpX12BYUh
	 W5Vj6Qn1bRrbGs7CdhAav5wXCgUGFceWf2fQiZOC83SOyddCXbu3v4pMJVCrMHuI8x
	 1nHcQigxzcVrA==
Date: Mon, 28 Sep 2026 08:24:41 -1000
Message-ID: <dfe81db2d9bc6cc6b17fc1f440af184b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peng Yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] nvmet: add cgroup_id to charge namespace I/O to a
 cgroup
In-Reply-To: <20260928061417.1574676-1-yupeng0921@gmail.com>
References: <20260928061417.1574676-1-yupeng0921@gmail.com>
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

The following is a Claude-generated review.

On Sun, Sep 27, 2026 at 11:14:14PM -0700, Peng Yu wrote:
> Scenario:
> * Create multiple nvmet subsystems/namespaces.
> * The namespaces are backed by different LVM logical volumes.
> * Some of the logical volumes share the same physical volumes.
> * The subsystems are exported to different users.
> * We should provide each user a specific iops/bps quota, thus a noisy
>   neighbor won't impact the performance of other logical volumes.

- 1/3: Can you explain why in the description? Per-IO users such as nvmet
  need the lookup to be O(1) instead of walking up the hierarchy.

  rebind_subsystems() moves root csses between hierarchies without
  updating e_css[]. This is fine as a root cgroup's e_css[] always points
  to init_css_set.subsys[], but that isn't obvious. Maybe note it in a
  comment in init_cgroup_root()?

  Can you also add a comment on the new e_css[] field like the fields
  around it? It should say what it points to (the css of the nearest
  ancestor including self which has the subsystem enabled) and that it's
  updated under cgroup_mutex and read under RCU.

- 2/3: This isn't needed with the change suggested for 3/3 below.
  Otherwise, cgroup_e_css() now has the same shape as cgroup_css() and
  could be a static inline in include/linux/cgroup.h instead of an export.

- 3/3: nvmet_blkcg_set_bio() calls bio_associate_blkg_from_css() under
  rcu_read_lock(). If the blkg doesn't exist yet, it grabs queue_lock
  inside the RCU section. f928145cbcb5 ("mm/page_io: don't nest queue_lock
  under rcu in bio_associate_blkg_from_page()") removed the same nesting
  from mm/page_io.c to prepare for protecting blkcg with blkcg_mutex
  instead of queue_lock. How about the following instead?

	css = cgroup_get_e_css(ns->cgrp, &io_cgrp_subsys);
	bio_associate_blkg_from_css(bio, css);
	css_put(css);

  With 1/3, this is O(1) too and it skips csses which are going offline
  the same way nvmet_blkcg_begin() does. It also only uses symbols which
  are already exported.

Thanks.

--
tejun

