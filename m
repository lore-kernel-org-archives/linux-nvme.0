Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23413EDE99F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KltQgv0LsSUbvefXqOkAit5Q8kULNhLk7ZdaoE8hteA=; b=n3bGeWTuxHp3pLe729gtWShyC1
	2okSnTNBuBTm8o5jOPaNoyw42IELp4ijA7bltVppaACiU5sP8uzPWO3ga4KpdJlrqbY2YhzpFvcFl
	qDrpLSV/fgWoDhVVHVV6+jC7UffEclDEI4Kw8H4eQaCQxfBzYVbrzdl1CfBroZGsqXpg2ZzV8sz8u
	80CyIifulVsIv7SCxuj673k1tehvgFWe+kMZ3DRRs4ExvUq8qQtrTwbeka3hwX1yyq7z9ugjJqroW
	TC/HXTA0e2nouUZAC5h3FnilY9zsznadPbmIhvx2H6DD1+2/6OjKsMOhay8vdMbYgqcVGunF7u4f+
	GfUzx+ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so38f-00000006E3P-3O9e;
	Tue, 10 Sep 2024 15:50:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so33Z-00000006Cd3-3O2e
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 15:45:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35979227AAE; Tue, 10 Sep 2024 17:45:27 +0200 (CEST)
Date: Tue, 10 Sep 2024 17:45:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 08/10] blk-integrity: remove inappropriate limit
 checks
Message-ID: <20240910154526.GH23805@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-9-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904152605.4055570-9-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_084530_116550_501FC452 
X-CRM114-Status: GOOD (  10.93  )
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

On Wed, Sep 04, 2024 at 08:26:03AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The queue limits for block access are not the same as metadata access.
> Delete these.

While for NVMe-PCIe there isn't any metadata mapping using PRPs, for RDMA
the PRP-like scheme is used for anything, so the same virtual boundary
limits apply for all mappings.


