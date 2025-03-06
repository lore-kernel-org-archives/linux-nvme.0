Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C9EC282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=slkkwxc0Lyi3feHmDW1O1u143E
	LhkA2SI6qL8dmhcQcATb/XR993Cxik8m/BR27PRE4R6ztCq6cquFnUj2B4X+2pehNPySfFzcfFE1v
	0Xz71tTFx61syCTIxccdAYCj2sef/8UVr8Vx4xpHTF2xlYuPqSqbT7zfTut32vAUJ9wAyGITG3JAf
	eIWZLKidsno59xuwQqkF7SHMnW+NN2zPjlggOR1fVcO1YSMu2XgUuJ8G0YS6aNbRvl9qz0PLCpmua
	Y/NevczLDHhTjJopHfi9PDPmdVQx+ZK+gKx/SxOn3ueaS111Yile4W19PiEoI6Gr2mb5WQRkDW93T
	ImGNB9wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqBzM-0000000BAUf-1xSd;
	Thu, 06 Mar 2025 14:14:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqBzJ-0000000BAU4-45GB
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 14:14:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 074EC68AA6; Thu,  6 Mar 2025 15:14:09 +0100 (CET)
Date: Thu, 6 Mar 2025 15:14:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/2] nvmet: pci-epf: Set NVMET_PCI_EPF_Q_LIVE when a
 queue is fully created
Message-ID: <20250306141408.GB21296@lst.de>
References: <20250306085549.834943-1-dlemoal@kernel.org> <20250306085549.834943-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306085549.834943-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_061414_149880_99FA6B67 
X-CRM114-Status: UNSURE (   9.34  )
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


