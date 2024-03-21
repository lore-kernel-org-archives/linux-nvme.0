Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B415CC6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 21:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pT13mWDbqgeFy83Z9y0M0jHAa4Lu8pnLWKSYr1+EalM=; b=CpHoMXz0+r6XmaR9Po7cYvj6bc
	t3wMi1Q7ZMpQR4u0E+LCnC74YGeSdiW5uThn27ZxZZS3p+rSRkSnFiwiS1yTSuoECmj8wvqYN0tUE
	dnceK1KaLcDR2V0CzMLRC87OVEIEoOpMVcMdL2r/MPhrZ8V+l8Df/vpGGMx8HSHjvC8YAcbrhUJIE
	wjsKS2uokd4ezB8/OIumDlO763gv2hNTIQSL11fSgascQvoXlnGJGmfLpKtukpg7ctb7BaROenBKj
	6s6sel20JjFOGZdaSyscVEYMmKFcfx2wnI8gWHC2gY+/RmdgP55jye1XPShmWtJI/Voouk8Xs+5pQ
	Uc8o8dcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnPXV-00000004cEE-0PrE;
	Thu, 21 Mar 2024 21:01:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnPXR-00000004cCp-3T36
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 21:01:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC5C268B05; Thu, 21 Mar 2024 22:01:13 +0100 (CET)
Date: Thu, 21 Mar 2024 22:01:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: remove redundant BUILD_BUG_ON check
Message-ID: <20240321210113.GB21139@lst.de>
References: <20240320091949.20791-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320091949.20791-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_140126_193955_D9D8D07A 
X-CRM114-Status: GOOD (  10.25  )
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

On Wed, Mar 20, 2024 at 05:19:49PM +0800, Guixin Liu wrote:
> Remove redundant BUILD_BUG_ON check of struct nvme_dsm_range, it's
> already checked in nvme_init_ctrl().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

