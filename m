Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB675E7716D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f5FyhNWkJPTcwvQwkILExjYDBoYu70nH5M2JdUb41+E=; b=DlgJ+n46qXHIvg75Zg35MlZGUt
	E0UHOdyeP4vu9cgXt9gAtv3VwKRV38BOXGHZd1epslbgVGydORdkaVjeZkIZvI2Tu0QQ75wLF5DWc
	NrWmTGLWHOWdaI4FWl+AbRpSSeqliiusM6Bt6U5BNZ1CZP16J0F5Oe3Pk1GI1oDSb9i4EQ+t1H5xI
	tRjYcmpOoyiI+eyrdW98lDTN1CJOMGbkEQCZ5849zxh8gbVqJFquWjyptntW1otXeAooDze7AKGSN
	tVm81OF1H4Xnva/bILW/TGRuem74zyUiINa2vqk8QYhVrlL8Rn/CrGZ+bOD9VZs2H0Q0APfXPuknv
	TbZgPFsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIzbY-0000000EL1b-31pR;
	Thu, 05 Dec 2024 00:20:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIzbU-0000000EKym-1r45
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 00:20:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D524D68B05; Thu,  5 Dec 2024 01:20:12 +0100 (CET)
Date: Thu, 5 Dec 2024 01:20:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, Leon Romanovsky <leon@kernel.org>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: Re: [PATCH] nvme-pci: don't use dma_alloc_noncontiguous with 0
 merge boundary
Message-ID: <20241205002012.GA12820@lst.de>
References: <20241204004240.687875-1-hch@lst.de> <39a67024-2926-4a20-8feb-77dd64ab7c39@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a67024-2926-4a20-8feb-77dd64ab7c39@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_162024_617878_8E80B56C 
X-CRM114-Status: UNSURE (   9.60  )
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

On Tue, Dec 03, 2024 at 06:36:08PM -0700, Jens Axboe wrote:
> Fix looks fine, but s/moundary/boundary?

Yes :)

