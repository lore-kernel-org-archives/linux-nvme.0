Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1C9C5CFC1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTSHfVFlIyP3No+ych9sX+3eIDYanupXU3o8EYU/LXU=; b=cizz1F1X0oENgYLy2Ql2Bup84s
	Qjflf9d7WPrQboTwLsNezba3xwPdltMSwNM5UU0W4A1PfiJkc0G2U/6PxxWVnFU7DglVZCWnKos6I
	6pW3SF0XeWW0DcpPH3bidOKQK1bgIGRf/ozVjEYcUSJgmeU682uNXCXmr+BklOMM4T5JwavN94OvP
	X7HRar2nMyrqs5VlgzEw6xJ2RJwAV48wTjV3+hq7WwiJrphhRRIzqgHQ9Vnr9Qevl4ylmr6815DcV
	brwq8J/si9HiijTZekX0IYLdTo6iegO7htttGTkXllVXfYv6Ph27r4l/g8rpHqAt3JEjHgHGDnFuP
	rOedpxmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuung-00000002vSI-1Yts;
	Fri, 14 Aug 2026 16:30:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuune-00000002vSB-10lW
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 16:30:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 45875600C3;
	Fri, 14 Aug 2026 16:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B641F000E9;
	Fri, 14 Aug 2026 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725029;
	bh=zTSHfVFlIyP3No+ych9sX+3eIDYanupXU3o8EYU/LXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qz8afG91whF46nNqqZ0GCYYrIk3FdWwm73kEL+I7nLt5Xntd78ymTvQQeyrSDNOLR
	 fVRaBf+p+wHT+zfoT2+Cir8iQOvL+0w+28QKmpBQZypqCZRTxDwMK42zlQV1v0hbA1
	 b+XLt2YPH3+nmDGaxA6/ZJ72t5kVwsQrIsCI/aavMCihzle6LkJ+6adrNhOyHb67l/
	 3v3Zt5KEa223rcCjDDDHXoz0wIl7QbJx2gtL2BJexsMzM4OQTq5VFhO1FDG7/TSpYV
	 C4WvkKDh5sdizYBuknJUk0DOVgrF+xzrWpYdmGLDKj2rDFvlldnzs/HoB2tFH6AB+P
	 lNXVoZjOwf+bA==
Date: Fri, 14 Aug 2026 10:30:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <an9Co6vHIqggWNIf@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814143833.1953415-2-cassel@kernel.org>
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

On Fri, Aug 14, 2026 at 04:38:34PM +0200, Niklas Cassel wrote:
> ctrl->ctrl.opts also stays valid for the whole teardown now.  That is
> not the bug being fixed, but it removes some fragility around the old
> idiom: nvme_free_ctrl() calls nvme_auth_free() before ->free_ctrl(), and
> ctrl_max_dhchaps() dereferences ctrl->opts without a NULL check when
> ctrl->dhchap_ctxs is set, which nvme-fc permits since NVMF_ALLOWED_OPTS
> allows the dhchap options.  The nvme sysfs attributes that dereference
> ctrl->opts, such as hostnqn and address, evaluate their is_visible()
> test once at device_add() time and stay readable until
> cdev_device_del().

The allocation that ctrl.opts points is freed in this error path, so any
access after that is a use-after-free that needs to be fixed. I think
setting opts to NULL is easier than the proxy locked list check.

