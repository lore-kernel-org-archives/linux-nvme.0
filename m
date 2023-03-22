Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03A8C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wX+xzHGaM0zYLz3ol8/ZZkURqWqMay4gxtvxM4h3skw=; b=X5aMfpKjhoHvTj5+DUnfsFXdJG
	hFEagoGhAigqaFuqrCfQreEhT+oS4kXiVUuR4vP+odpLcuVIToqx2cYP47c6qgl6hisJMso6MnsJg
	OG0SojufplDuvkXcAiYD8T0nXrw2p2JyCpG4CDqMQCt0qtDMdQikDnWI3BcBi7JLRmZC6Bm6P3yLw
	b2VrNDqILy1kE18B6fgP+sc6a4GDsA3WoAtTFpaiocpp8HV4zUHNXvPr01yHDGrv2nsS68k+KYwl0
	ExKmHopv3CC2G1iUt3ZcnnSonOU6WDbJKHMgIYjJ0Ebs6tXmtHCbdfyEx9X5SOBkgkHzQ9QiHvZ+x
	6b0JAeCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peyt2-00GBd5-1i;
	Wed, 22 Mar 2023 13:52:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peysy-00GBZR-2X
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 13:52:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D03467373; Wed, 22 Mar 2023 14:52:00 +0100 (CET)
Date: Wed, 22 Mar 2023 14:52:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322135200.GA16587@lst.de>
References: <20230322002350.4038048-1-kbusch@meta.com> <20230322002350.4038048-3-kbusch@meta.com> <20230322082310.GA22782@lst.de> <20230322084651.xmnup2ag3ve6jr3a@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322084651.xmnup2ag3ve6jr3a@carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_065216_986760_A9FA144A 
X-CRM114-Status: GOOD (  13.34  )
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

On Wed, Mar 22, 2023 at 09:46:51AM +0100, Daniel Wagner wrote:
> The blktest I have written for this problem fails for loop without something
> like this. We can certaintanly teach blktests not run a specific test for loop
> but currently, the _require_nvme_trtype_is_fabrics check is including loop.

Who says that we could support polling on all current and future
fabrics transports?

