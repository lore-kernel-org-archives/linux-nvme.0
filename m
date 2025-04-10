Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04633C369A4
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X7s8BJ/0moFVq39/eYke/FPHelov8XHQSUnbg4oEm40=; b=vqmEKfppuu/bOrT7TmLFJYqUMJ
	o/B2LvPqSh/DsJfyJrYE/NoYbhiU9VcYcPePE1Yn2D1tduKQ828yXrq8R21hgRS26McVMwLkkX8ib
	VOQk6pEjOUwT5XeKE6Y5tEMGC/9zL8OXfSd92NieSEiC2zL+lZc4IvTFxs5EnZBGbi5daFLSoJj0+
	z9lVhidfkIcvON4cAd+U+jM1OS415NDdOxC50GfBF1yRJzAvIZVk9zlzEAG0u6Ax3/5txEvJ401K8
	HP7Plt0A/LLdxOJJRgQHCLnVI4JyqnL9WUglHBY4juVZmLwBkDHCIqd4J5hqnHLbocxTOoAf9Z5Gm
	TgmuT5cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nYU-00000009npS-3UTH;
	Thu, 10 Apr 2025 08:46:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2n1W-00000009h81-3cYJ
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 08:12:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E8AC68B05; Thu, 10 Apr 2025 10:12:30 +0200 (CEST)
Date: Thu, 10 Apr 2025 10:12:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 0/3] NVMe PCI endpoint target fixes
Message-ID: <20250410081230.GA1442@lst.de>
References: <20250408024733.690966-1-dlemoal@kernel.org> <ddfd83f9-faf3-4e4b-823f-4037cdcd7e58@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddfd83f9-faf3-4e4b-823f-4037cdcd7e58@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_011235_044010_22816F0C 
X-CRM114-Status: UNSURE (   8.58  )
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

> > The last patch cleans up/simplifies the management of the PCI link
> > state.
> 
> Ping ?

Can I get someone else to look over them for an extra review?
Niklas?


