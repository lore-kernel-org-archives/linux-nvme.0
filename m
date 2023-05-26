Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58182C7EE23
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wrp/p2JlYlr1a42eE9mpYkhzTkjQuCT4cr2Pi5Zpf5g=; b=LkqaGtp2t3YLjKLTT2axc033yG
	orVAWZqdBQIODzkLSHHW60TaytNqgBPux5UBXk5AbKqg7/r2wof/sSp4bJueGJsQ0WRMDHypFmjI1
	GFZd3g7libGRTlumu+JOsVXA6EGPeA7iW/MPumnUNCQUlNgtrteUvnwioEPuARFP0gyLI0cCo8MGe
	dCItFVCnBSzaNuVxPh5VsNWK2kqmhsD4nLkkB8Jj7DSEoW6E0dm0go/R/TSi8ziyzJzJuRfu3ZyaJ
	Oh/Ye5zIQY1ey9Gi7Otaln/GW3nlYGC1cFKXAcPqXAct17jiohliFjzNwfWMtLpe2pp3ztbCHLI5k
	DV3KBD+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2SKd-001XCN-1w;
	Fri, 26 May 2023 07:57:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2SKb-001XBV-1A
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 07:57:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2A4268D09; Fri, 26 May 2023 09:57:46 +0200 (CEST)
Date: Fri, 26 May 2023 09:57:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: "min15.li" <min15.li@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix miss command type check
Message-ID: <20230526075746.GE16072@lst.de>
References: <CGME20230526030614epcas5p4ca2cac6dc85dd8609b62e5802c06fb40@epcas5p4.samsung.com> <20230526110434.17036-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526110434.17036-1-min15.li@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_005749_536443_6046FC5A 
X-CRM114-Status: UNSURE (   8.11  )
X-CRM114-Notice: Please train this message.
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

> +	if (!ns) {

Instead of all the extra indentation just return early here if ns
is set.


