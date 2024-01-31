Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19818C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 07:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHkR76yiqegpE8jc2vUdWBG3zcZpQ5nlA2J109anhtw=; b=mmOV6rG3wtr9uI9YD7yNrmD02Z
	8Zn2d7wls8kTaNSpOcTSW1DyL50zcAtSo96L7tgZduw3rQCuHhhMwIyz7cZ8P2lE85N3wlaW1Rth8
	aPtRSwiKO5JDBf3iZMk/5rq1myp2xZ0hdGTGSkhOxRHwYyrYVLllndwC/y9uCwwn9SGfLVM5YpAcg
	lQ7cnzbmsVIfGsgji3xhE7oNX6SdZ6v0qjLjGNr/2aqIURBDmoC1WHpn39EibYPJ5EhfT+c1FPF7J
	uZCzKYbjisWjGBppc3c6+tj3hiKpF+2cPXD/q6EaweZL5qb1Tuj4Bs90jQTFJts8B5p4XDU+zBd22
	G3ATZGKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV4vj-00000001nOb-1yXS;
	Wed, 31 Jan 2024 07:22:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV4vc-00000001nKA-0Isf
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 07:22:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7325F68B05; Wed, 31 Jan 2024 08:22:33 +0100 (CET)
Date: Wed, 31 Jan 2024 08:22:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH 3/3] nvme: allow integrity when PI is not in first bytes
Message-ID: <20240131072233.GC17498@lst.de>
References: <20240130171206.4845-1-joshi.k@samsung.com> <CGME20240130171929epcas5p24f6c25d123d3cd6463cbef1aaf795276@epcas5p2.samsung.com> <20240130171206.4845-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130171206.4845-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_232236_335196_4272D006 
X-CRM114-Status: GOOD (  12.74  )
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

On Tue, Jan 30, 2024 at 10:42:06PM +0530, Kanchan Joshi wrote:
> NVM command set 1.0 (or later) mandate PI to be in last bytes of
> metadata. But this was not supported in the block-layer and driver
> registered a nop profile.
> 
> Remove the restriction as the block integrity subsystem has grown the
> ability to support it.

I think it makes sense to mention that the by far most usual
configuration is metadata size == PI tuple size and you're adding
support for additional less common setups.

