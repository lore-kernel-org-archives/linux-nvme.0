Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D58CDE012
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2024 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Ai2VPQI2hpeM7/x8P0J31cRiXq2Iz9nqcykQv2NCD4=; b=HibTNjwICmEf4ItIQvTTuR0vge
	nFKFREpBKjATkAICbDUzL0XeltiI4Pz524NofCruECV0e7cvHbEf44Yfcp00u0V+WH4hvGg10vn8h
	ReCOOjHf8QEJiVBVGegr/DTCg5v1PvmpYkOzymvIq0DHdHL4efq+oCbHkE+cVUC1PqVS2tPm31N7z
	zzbmw/dXlzVog3jwQdWTiatx5K5qGtc3G015n9lzyMwyqWBDTO57ZCb5fqrokF6vfpuoYEbxa8S2q
	ustkE/tamblN40mFmio/O0e4X+T7BOLZqE0XvFLzf6ZY6AWoYE/sn8CbC6eAO9sCuIsszsMFpLCKx
	TOF2Hl3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stq5t-00000008hE0-1XYk;
	Thu, 26 Sep 2024 15:07:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stq5q-00000008hDb-2tKo
	for linux-nvme@lists.infradead.org;
	Thu, 26 Sep 2024 15:07:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 38FBB5C5BE2;
	Thu, 26 Sep 2024 15:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802DBC4CEC5;
	Thu, 26 Sep 2024 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727363262;
	bh=gAfiloP6m7au+IIFfFXlowkqK2zR2URxRao4ffFBcBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OIRvB8tkgfJMCfYnsh9nBhke814LUsJqEvRgcfR+KpfRBtJd//5w7ywy9/5CLucHI
	 rmmJmMxnDHXX5KNS4/yXA9KbXMz7zxf72jqwmI/s3OryZxR/sNGyTvdrW6jNGN/jB2
	 z/g1pCP9lNBzr3+8KMJWj+DcnKxCyns7YKkQMlvG2UU7edIb2o2oLihlYTbD5IO51e
	 MiK+3LGl+elEwVf0JMbnVzk7uRdVZFky7nD+hM1l7B6juOKpelVtFApELsCZwI+KRe
	 Q/qhOQ4YCa6BCYUANCfhqjzmkVMjx1R9Fgv2qv+3wIWggbZdbokqosTEiw0uith8hF
	 w5mgnEuvPsgHA==
Date: Thu, 26 Sep 2024 17:07:36 +0200
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <ZvV4uCUXp9_4x5ct@kbusch-mbp>
References: <20240201130126.211402-1-joshi.k@samsung.com>
 <CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
 <20240201130126.211402-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201130126.211402-3-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240926_080746_825565_AA39EE36 
X-CRM114-Status: GOOD (  10.60  )
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

On Thu, Feb 01, 2024 at 06:31:25PM +0530, Kanchan Joshi wrote:
> Block layer integrity processing assumes that protection information
> (PI) is placed in the first bytes of each metadata block.
> 
> Remove this limitation and include the metadata before the PI in the
> calculation of the guard tag.

Very late reply, but I am just now discovering the consequences of this
patch.

We have drives with this format, 64b metadata with PI at the end. With
previous kernels, we had written data to these drives. Those kernel
versions disabled the GUARD generation, so the metadata was written
without it, and everything was fine.

Now we upgrade to 6.9+, and this kernel enables the GUARD check. All the
data previously written to this drive is unreadable because the GUARD is
invalid.

Not sure exactly what to do about this, but it is a broken kernel
upgrade path, so wanted to throw that information out there.

