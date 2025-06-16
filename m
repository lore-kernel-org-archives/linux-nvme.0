Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D58C71155
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 12:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bU6wVgI8Kg6ek1kzpY5ZfSlJ3lLiNRff2p1nMc/WFec=; b=y7edTXJe/bZW957Ym2nA8lDzap
	1HdDSXbtF9dq5AKuPFzz9cAeNYSfM7oOJIxMNHP6HYKQVhiqfdvu5WEv27+JvpDtRttdwX1b9SGUq
	1sv8ccpaT6XlZhLukcS4l1oMLjZNBXa0Tkd1GH0Fvpwqv5ur5imGGHNUfrVwylDKKfkgnINEiqJoK
	YSG/r77KBXHJmtEXN8q5noJgHSLjaAbMj6REMKwf19KVFZ1ZANtJX4C+gXqVBBAnAOh3M9eCCD2jM
	/Nmy4AjE6QxFXCPHC/FWwAR8RhfJCNluTqdrygZA1VAAH9iLMp8FB3pXMc/5XlhFnCvk5FOMro6JU
	I4ooUL/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR92z-00000004Nm4-42AW;
	Mon, 16 Jun 2025 12:34:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR86D-00000004DMd-0Cre
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 11:34:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D42D167373; Mon, 16 Jun 2025 13:33:55 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:33:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <20250616113355.GA21945@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-8-hch@lst.de> <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org> <20250612050256.GH12863@lst.de> <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_043401_235845_FAFA8EBD 
X-CRM114-Status: GOOD (  21.71  )
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

On Mon, Jun 16, 2025 at 09:41:15AM +0200, Daniel Gomez wrote:
> >> Adding support to
> >> multiple SGL segments should allow us to increase this limit 256 -> 2048.
> >>
> >> Is this correct?
> > 
> > Yes.  Note that plenty of hardware doesn't really like chained SGLs too
> > much and you might get performance degradation.
> >
> 
> I see the driver assumes better performance on SGLs over PRPs when I/Os are
> greater than 32k (this is the default sgl threshold).

Yes.  Although that might be worth revisiting - the threshold was we
benchmarked on the first hardware we got hold off that supports SGLs.

> But what if chaining SGL
> is needed, i.e. my host segments are between 4k and 16k, would PRPs perform
> better than chaining SGLs?

Right now we don't support chaining of SGL descriptors, so that's a moot
point.

> Also, if host segments are between 4k and 16k, PRPs would be able to support it
> but this limit prevents that use case. I guess the question is if you see any
> blocker to enable this path?

Well, if you think it's worth it give it a spin on a wide variety of
hardware.

