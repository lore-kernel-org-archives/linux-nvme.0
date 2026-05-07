Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B41CD343F
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u179a+OD6EeA0eb2tmM/DVMlolTemyJ/4dyHs4UAmXA=; b=HozCB4OKR0vd/S+s0AW8FiyZjL
	Jamri15LYrGoUqghsrSkBbo4QOJk8gHAZeB6C835uKiPfoy1oQkaq15vXomn1ulvHf6RpQnUH4nXs
	9U0Xpi4HyNY2a/I51mMJ6f32luQQhL3/K7nMPezfcJGB/6B//OOgw9SvIdG7lEv3Vxw7+mYkbHloN
	66+ee/ejUcGdJ/fY5/GpbEUvykBV+rCotlz4XISbobfRncVfbfOJkekCV2XacXVqUu8gFd02J2OLX
	+LO8Q0i5bFw9Xb5X4dNb7B8DIG0ZOQKG9o5LAAVMFLGaBuUEeZXGgPZpE55gRIIX9q+ZdBqGg+fFm
	mMx5DwWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL3D7-00000004Z76-011r;
	Thu, 07 May 2026 18:12:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL3D5-00000004Z6s-3mqJ
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 18:12:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 01FC56024D;
	Thu,  7 May 2026 18:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78E2C2BCB2;
	Thu,  7 May 2026 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778177550;
	bh=nhFXydb0xZV+rEe/xtyu585U3MKjv53awL0/x4N18R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVhqP9SXoo1MAgXfrQ6K5kcSnpObOkz23LlZVwAADhmT/eu25DEiz4u4R3kd1Vvsq
	 D4oCXPv1GQJsj8jY1DBMMYCx8dGEvhOSHSfAiMFOIAGI1jSko+EZDz6Z4OKQ4cfRoR
	 loqmWMpf91Yy6j3IohOHI0FAw5nZJO5+GPBkJMHYA8EkGAjAueUlqqucDlkF8XR6FE
	 Txj+L5fY0fwgnT8DDggsxIParwhH0COGYGBospnB1UKkgjVhETMC6ShRZEiknE0WG0
	 MD8pZGsIKfiLlOOnGJI1CC2lYmp33LNuMdlhbqRafUGov2eM23LbmtXMcl/+uoLvXm
	 aP/0owoOuoqJA==
Date: Thu, 7 May 2026 19:12:26 +0100
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Message-ID: <afzWCpJSqvjnTgpF@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427003457.1264511-1-coshi036@gmail.com>
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

On Sun, Apr 26, 2026 at 08:34:56PM -0400, Chao Shi wrote:
> In both cases the bio was submitted without REQ_INTEGRITY (because
> blk_get_integrity() returned NULL at dispatch time, so
> bio_integrity_action() returned 0 and bio_integrity_prep() was not
> called), and it reaches nvme_setup_rw() for a namespace where
> head->ms != 0.  The existing BLK_STS_NOTSUPP return correctly handles
> this dispatch; the WARN_ON_ONCE is a false positive.

This is what I'm not really following. The cached request holds a
reference on the queue that prevents the queue freeze from proceeding.
This driver freezes the queue along with the queue limits update. As I
mentioned in the other patch, that was supposed to ensure the block
layer had the updated limits before it could allocate a request, so I
think we need to understand how that was defeated to get to a real
solution.

