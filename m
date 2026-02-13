Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C61CEDF17C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KBVoqA1OL3BGlBRjXG/RM1S9eqDZnAMtXmaRjWr96bA=; b=AVlO1nonq4mWqly2vmtCDm1wl6
	cw8cdN3Kh3+TtqGaE3caZ/T+uaerAPNQudUEmTQFZd+T+IBIBSq/4AKZL/IpgOzhHj6Dn32gVtrTx
	6oOQnMa9oOs94UQYX2njJ8PxJkLadwBpmvvWvT0KPWnGAe+ynEYEyNFdsE3M0e8PEOuct7bB9+gKA
	EaDCD6/UzvypNWMkQgPP6sA2IiPqbuDpB8ovWcsNi3ZgLgZ3jTTCqCIpLqysaNuZEZmUwZ+vv+gF8
	zKJZwncPRF8JyTRIXApFzvN6J8zfG8qHWDUCfETB5H0LZgw1LRxkNhU8P4ABwdwdLrV76ZlJ3avak
	KYn7/8bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqvoW-00000003f91-3zWD;
	Fri, 13 Feb 2026 16:14:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqvoV-00000003f8q-3o7Z
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 16:14:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E3D8760054;
	Fri, 13 Feb 2026 16:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A35EC116C6;
	Fri, 13 Feb 2026 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770999278;
	bh=vt7i25VqgrXoFLo7tPoHeH0wmplUJ74bExgNYpL25fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qt7+0d0UOseYZOcooCiK/HI9tJrlLEpP2IeQ+iuCo2PvYkwNHp43nJYVPec4atwiy
	 m03dsI0GFWUqwfIM1zZs59ntDmlSlRPvHuklp3u3FD52THuqBIuV4fdFJqwGh72mZ1
	 cSJWNh6vrMRJyy/wuLRB0qOnVilNcdoJqRqCTgmytjMiNK1PEe6oojshvCMnTxVvO7
	 YbieYyM5IOxdxqpPXCla8Mquv3txFXlu+jPLj4Emn1SL/42Khu4c58HyzdmYvmRYoY
	 jS51oF1jVeZk3QwwV6kcn4v4nTc9njuWYDE9QQOQ6MaVwVlIWP3qH7Zk+pH5qigxN9
	 zo/UVNE/s1I8w==
Date: Fri, 13 Feb 2026 09:14:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: Re: [PATCHv2 3/3] nvme-pci: do not try to add queue maps at runtime
Message-ID: <aY9N7IN-mCpkdiT_@kbusch-mbp>
References: <20260212164733.3006071-1-kbusch@meta.com>
 <CGME20260212164902epcas5p15b0be6076ed178f710bc585f87477fe7@epcas5p1.samsung.com>
 <20260212164733.3006071-4-kbusch@meta.com>
 <9ef40515-1f4c-4b12-8243-3084eb287fb0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef40515-1f4c-4b12-8243-3084eb287fb0@samsung.com>
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

On Fri, Feb 13, 2026 at 04:05:47PM +0530, Kanchan Joshi wrote:
> User may not get an error on adding and, therefore, may feel that 
> everything went fine, but such queues cannot be used.
> At least, that was my observation on increasing the number of poll 
> queues from 0 to !0 value.
> I continued getting "not supported" error on issuing hipri I/O from 
> io_uring. After this patch, the poll queue became usable.

Thanks for confirming! Series applied to nvme-7.0.

Considering how broken modifying the counts at runtime was, I wonder was
it worth fixing? Clearly no one tried to use this feature. Maybe I
should have just changed the parameter permissions to 0444? But hey, it
wasn't a big deal to fix, so it's safe to use now!

