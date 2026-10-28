Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4D9606A33F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xMEChejP;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYoBw8u+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=B3gEUUfog8/BG3LLWJAiAImyKHgEOQB0h9D611qbYgs=; b=xMEChejPuzV37H8+iYwP+r6E8E
	Xpw4feJpor9fN8NX8ZxgsvHiRAOjEJvBXP+t175JYTLxjUyUZss3CJF0Lla3oyCl67deDljTZ8BjH
	8bPPiaGVDjZ1tA86oJSCGBBMemGLcu0Kqn/amZWeHgK0LViELrHYFDgO5CLabyKMzQ6P/NWc2UrVS
	u3cQr1SwY/GztEMYUiG55o0r+U4AJtqF5GsAjj/LfOMJyptgmNycZIWkUEtHdM+zrQFI6qy//aQCc
	FojC1ILz0pNZAC6rw/wVNFZShbwcc85q49Um+aCnvbLPGZTaHgxi3TO9r9V6y2wq6VoIfFuMgtceh
	bB6OOqGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM94u-00000007qMM-1HVb;
	Wed, 28 Oct 2026 19:12:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM94t-00000007qMG-2JFm
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 19:12:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D0E37405B9;
	Wed, 28 Oct 2026 19:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB41F01828;
	Wed, 28 Oct 2026 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214770;
	bh=B3gEUUfog8/BG3LLWJAiAImyKHgEOQB0h9D611qbYgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aYoBw8u+k6MNHgFvIo4HUrENGG9lbVCLCYJPqrcFtHqAVItuu1oHBVLhImES6no2D
	 ceemRFI9TnSsbxtIpxmpjeH1ZWXZRIRbYKKqOnkWUoOVlreIFYvEA6Fy81mdBBpvhR
	 p0+XCgEYLykxGS0bqQsz6l0VGLHMhI/AKA/Ue+I/Bsx/9R6/WB/CuJm7MkXBj8XVmE
	 2yij/qfL++64nL77dUF6WV69F+9ctkaRYzHIHXQBzYQMkfBDyvZESbxyxkzR/W0Q9I
	 /X4zfvh+Dw2lnFxBJBh1ToR01QKLPB+v2hlLe6VKfjqmOQ14YDvgTYA/hN50O6ggtY
	 6ac592Tyt5tLA==
Date: Wed, 28 Oct 2026 13:12:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCHSET 0/98] Various block related fixes
Message-ID: <auJJMDwye-BadWjD@kbusch-mbp>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:41:03AM -0600, Jens Axboe wrote:
> Got a giant pile of stuff dumped on me, and went through and did some
> vetting and, particularly, commit message rewriting to get it to a
> somewhat comprehensible shape. If you're CC'ed on a patch, please
> review it. Feel free to queue it up, or reply back why the particular
> patch is garbage, if it is garbage.

cc'ing nvme; original thread:

  https://lore.kernel.org/linux-block/20261028164415.1262013-1-axboe@kernel.dk/

I've picked a few of the obvious ones for nvme from Josef and Chris: 45,
65, 72, 73, 76, 78, 80, 88, 90, 95, and 98. The rest want a more careful
look.

