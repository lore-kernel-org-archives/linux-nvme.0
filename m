Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB628C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TuvtxHWlMg6SSWjIWXDaeeGGhGJrNXyxHFrHUMvvWI0=; b=fo7bffXb2mcyhI77ZMc9sUDLaY
	R2ocAY07qhaSLDrEFPl4AWwaIlaIefLE0MgFzSbczBvoguYdjavP70pAj/rtwtb8JRDchVZNLZF8A
	hXwznsiipCHM5VDAlqQvoX3oEiRAeBjTdQCCefkAO5fw2dNu24S39Qtd3pzMOBg1bOvf/SmP6ZGaE
	g646O0X66hKiDpPSeiUgsCyTDUitRfGw5VFaapUP8aZ6y5AhycP5wgFp0uAY5emFyVxExT5nOOza+
	8Gkw/ySTtmh9k0xeHYO4VYeCynzEC4/g05WQ0XBBjPg5f/X2gbyAaQreSwGwWtiAgC4sx3Txpunqc
	88PIWd7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk5kJ-007b39-Px; Thu, 28 Apr 2022 15:07:55 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nk5kH-007b2O-Fp; Thu, 28 Apr 2022 15:07:53 +0000
Date: Thu, 28 Apr 2022 08:07:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vincent Fu <vincent.fu@samsung.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: have nvme_setup_rw return BLK_STS_OK
Message-ID: <YmqtycoRZO3yxVCW@infradead.org>
References: <CGME20220418194351uscas1p18e05fad61bc279e8ea18d1a1a8597dc3@uscas1p1.samsung.com>
 <20220418194324.589248-1-vincent.fu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418194324.589248-1-vincent.fu@samsung.com>
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

On Mon, Apr 18, 2022 at 07:43:50PM +0000, Vincent Fu wrote:
> Return BLK_STS_OK instead of 0 on success. Since BLK_STS_OK is defined
> as 0 this patch results in no functional change but to avoid confusion
> and to be consistent with nvme_setup_write_zeroes as well as
> nvme_setup_discard we should have nvme_setup_rw also return BLK_STS_OK.

I really don't see the point.  blk_status_t like all __bitwise types
is designed to be able to cope with a plain 0 just fine.

