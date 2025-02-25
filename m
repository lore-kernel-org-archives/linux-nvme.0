Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C443FC021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=oy06NtnMgraVZUDYuXE3XqDIAU
	iJ5kSXB4ERoESws99IWnL3Zf9JoP5ehtJAlAp03HDnkd6s7aPZW0bNF/db8dymof7HXqKKLsUMT3N
	ZLz/f5uF3uow+4kACE5o2YqOBOjNyTzf2VYzO8YC4YqmGenVrq4zkb43cirzeP5D6MmXgQo1cFloa
	T4swQOHIfi3T0x2fDrYj6VxNmARaiPiAC5FqYO56yqKOKWViDRQWhGDEtCHIOBfgCBg+UJB9cJUDy
	L4dmAoGbOsmPqqembjD+H5o86VoyzoZiXFeB2gbLTPw0lkGDsT4j1sZN+hDoc0aEHdR0dOXPuUuJ0
	udV8sM7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmxzG-00000000J37-0QaB;
	Tue, 25 Feb 2025 16:40:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmw1W-0000000HXhO-1BvK
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 14:35:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75B9E68D07; Tue, 25 Feb 2025 15:34:51 +0100 (CET)
Date: Tue, 25 Feb 2025 15:34:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-ioctl: fix leaked requests on mapping error
Message-ID: <20250225143450.GB5290@lst.de>
References: <20250225013547.1130524-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225013547.1130524-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_063502_464999_5F52F08F 
X-CRM114-Status: UNSURE (   9.00  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

