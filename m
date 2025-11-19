Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF680CF3186
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mb0+dn+cdl5lEj9qZr/FdgJHsl1d3xMSs7XHspZckQo=; b=uO/JugCouKWvw6Nccbpy/uZQZq
	ft8TvgnzkorFZWGkhhyNQAwlCX5lXRnX7Pu1Tvts5gS8jRu9ODQdguj0NgjGH+UzjoUh9JyAOh+jH
	VTwJD12eoj+WsQvWUi7L8GdY6RZNBXQaCKbsPRVy59QD/P8W8dMB4MIf7rhphWowzMiSpR/yqstf1
	2d3LPGqC138V9L0VhE3DjViCxH1E1w5SXC9a7zoR9Lv9XZEo3jEjigZvuJUKU1YhSoL6zZ2KmrIt/
	jlheGD8R6MFbAcKbUzu/hP/H9MdfMmRML3a9R1qhv43TEJ+7l6LvFx62XM51xBl9pwrQA0JpkWHe3
	VQB8Bkiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLf9N-00000002wAf-3ysS;
	Wed, 19 Nov 2025 10:10:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLf9K-00000002wAB-1RnC
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 10:10:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C69168B05; Wed, 19 Nov 2025 11:10:48 +0100 (CET)
Date: Wed, 19 Nov 2025 11:10:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to
 handle larger sizes
Message-ID: <20251119101048.GA26266@lst.de>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com> <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com> <20251118050311.GA21569@lst.de> <20251119095516.GA13783@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119095516.GA13783@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_021054_529188_DE67311C 
X-CRM114-Status: GOOD (  13.24  )
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

On Wed, Nov 19, 2025 at 11:55:16AM +0200, Leon Romanovsky wrote:
> So what is the resolution? Should I drop this patch or not?

I think it should be dropped.  I don't think having to use one 96-bit
structure per 4GB worth of memory should be a deal breaker.



