Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC9AC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWIBXVs0fkgryl3oxNTCyzyNFIs41B8IahGuJE83Yvg=; b=VBBv6QC8D9Cae3QX71H8il7Wu2
	Znti7xyRz91+gBppudvrC1fjOU+8b5beFzaJy7ScfRgv0JAsaiLEDWoe2H+OQ8JPgdI3k5g2cToIi
	7QPqPlfAD8p8A/jtgvhBzMyA6WJm44ONs//SeOHMiCNwTD6j9pBEY0RzFYm1Xb8p+oohtGN86BaHJ
	CSr2pZyOVKf/oyrheaRcqDy6AduBY+3Cm7wDgOsZPwumfqRBJcbZqob4bCenAYZOOctkLPy+PW4+X
	8waauLuSv1cH0QSwq0W/oLmG03saRXRZuqHVEYxKW1gjWZy4/kLTCYXUKXD6iqUO3o4tgKm/z7AEi
	vqvY/pcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovM4l-006NBa-Qz; Wed, 16 Nov 2022 17:19:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovM4b-006N6h-8M
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 17:19:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF76268AA6; Wed, 16 Nov 2022 18:19:35 +0100 (CET)
Date: Wed, 16 Nov 2022 18:19:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: August Wikerfors <git@augustwikerfors.se>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1
 256G and 512G
Message-ID: <20221116171935.GA24524@lst.de>
References: <20221116171727.4083-1-git@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116171727.4083-1-git@augustwikerfors.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_091941_473585_056201B3 
X-CRM114-Status: GOOD (  13.28  )
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

On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
> The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
> reports eui as 0001000200030004 when resuming from s2idle, causing the
> device to be removed with this error in dmesg:
> 
> nvme nvme0: identifiers changed for nsid 1

What EUI did it report before? Is the identifier stable after
multiple resume cycles?

Can some of the Samsung folks here reach out to the relevant firmware
team to see if they have any clues?

