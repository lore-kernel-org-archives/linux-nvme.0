Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA165C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 05:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=PGFNOsSsWTWF7+hfpGUQxfWfO+
	YPoPfsFp1kg5p5co0OTGwMayeU3V7kEzcBfh0/G0mrqAnIRu5NI/O44UTLnyRyu4+d1rkiyQdYHn5
	mNzqOq6U+dyJfK6D+xiheci5RhN2HeUbKz1MAIIdDKDiZ6ioxPN7kcmm46UNBSBW5OVh7LRqZuy7w
	2aWffV41Y98M7MS0WD4p1p6BAotFrEk9Y6ZrCZmlH/vHu8DVaevPlBy0jxr6j9GkMT9oNJHOQhKrQ
	LiVsSki+39qjHRKLF2BIOw2mImVnNtVXTW14YXq3IrQcPuThZw+BMh9HmSEUvqo9SjaVNRXtoNWlt
	4T8RlyDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFxd-00000002UCC-3QQJ;
	Fri, 09 May 2025 05:07:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFvf-00000002U47-1Sqg
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 05:05:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2BB1A68BEB; Fri,  9 May 2025 07:05:38 +0200 (CEST)
Date: Fri, 9 May 2025 07:05:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, dlemoal@kernel.org,
	alistair.francis@wdc.com, cassel@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH 0/5] pci: nvmet: support completion queue sharing by
 multiple submission queues
Message-ID: <20250509050537.GA29502@lst.de>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424051352.7980-2-wilfred.opensource@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_220547_525924_DA8ED12A 
X-CRM114-Status: UNSURE (   8.31  )
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

Thanks,

applied to nvme-6.16.


