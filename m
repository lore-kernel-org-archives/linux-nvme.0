Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1130CD5BCB
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G07RSMvThr+ILl4s+z8LdlXThJPIHiD0uoyIWVlk8NI=; b=BDwBRT+M4ntyBvQYNpld0hhwy6
	+Z6D4M9O+HfcXo070BM/T+3ncGzPFWZwKzE/T0QHlRTZ5MHWBuXud8AmHAq9mYEwrgY0NRsePSy+/
	pKuxGXdWSr7DFPLn1DPJ+Gs8YnXei0BmZr8XakgN+9R0LO98/XNDAuSPbIizI3CiCk0CKNVGEdEQ4
	fMQdlcmhegBH9INxzwDCY/6S2KpiytYDpAEZHJzKHsdVTayqtyDwkqOyncS2HEjmBwWCZRM1Y4Gvk
	EgVX/dhNI2wbma/Dn3zpYl9aQFUfOGCO3GTtKCRffkWkDhvp0hj4AeINZzzr94L8mWD/7R7q73rJC
	Ke2oSs/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRPlS-0000000GX0p-3qsA;
	Mon, 25 May 2026 07:30:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRPlQ-0000000GWze-2DGF
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 07:30:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D7CF68B05; Mon, 25 May 2026 09:30:12 +0200 (CEST)
Date: Mon, 25 May 2026 09:30:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v2] nvme: recompute multipath zoned limits from ready
 paths
Message-ID: <20260525073012.GA5201@lst.de>
References: <20260522075806.3168366-1-sangyao@kylinos.cn> <20260522092136.GA8708@lst.de> <20260525064026.2fxlbmztsfyzzn25@sang-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525064026.2fxlbmztsfyzzn25@sang-pc>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_003016_709416_16AA2CA9 
X-CRM114-Status: GOOD (  15.34  )
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

On Mon, May 25, 2026 at 02:40:26PM +0800, Yao Sang wrote:
> What I saw was not different live paths of the same namespace
> reporting different zoned limits. On a QEMU VM with native NVMe
> multipath enabled, two emulated NVMe controllers shared the same ZNS
> namespace and advertised CMIC.MULTI_CTRL, so the kernel created a
> multipath namespace head. In that setup, both controller paths
> reported max_open_zones=16 and max_active_zones=16, while the
> multipath namespace head for the same namespace reported 0/0.
> 
> I also checked Identify Namespace data through both controllers. In
> both cases, nvme zns id-ns reported mor=15 and mar=15, so I did not
> observe any path-to-path MOR/MAR mismatch. The mismatch was between
> the namespace head and the controller paths.

They have to.  The high-level approach in your earlier patch is
the correct one.  The problem is just that we use the block-level
stacking for totally different things (multipath and complicated
DM setups).  The long-term strategy is to unwind that, but for
now I think you should just open code what you did there in the
nvme-multipath driver.


