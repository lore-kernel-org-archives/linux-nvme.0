Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52340CAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fcL+DKaIempU1CR5EBY+djRs7+
	vT5XaACZw2FEgwUkvU8Yt2sWFwRGDGSsk0mlf4qQMCPpDT5KI5sS4zwU9BSSPSvmH4Xm7G1JJ+8PW
	kKsOAWsNjib5ESSb5ODB5bs5jQEn9z4dunI1McjADiBtwEBZ9W4CxzhXVvtfqrnNPM6JSXzbhRl5y
	II+DyBYSKior6XAjRC0/8EgQe75+Dp/2t/wykFqrAP01NQqcwvw/JtYE6Jf+xOWlKfggwivKoiC+/
	I8Ppa5pqZGUGc3cM7lBKD0A9dSXSjp/pXNVLBaSZDoiTlRy8iPe7IHYxBJ5CBbxy7pQ70LdNmS8R2
	B460Iphg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aJ5-0000000BovP-1Bbe;
	Fri, 03 Oct 2025 07:34:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aJ2-0000000Bov5-1QVN
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 07:34:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2046227AB1; Fri,  3 Oct 2025 09:34:14 +0200 (CEST)
Date: Fri, 3 Oct 2025 09:34:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] nvme-keyring: use correct format specifier
Message-ID: <20251003073414.GA12862@lst.de>
References: <20251001142200.61696-1-hare@kernel.org> <20251001142200.61696-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001142200.61696-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_003420_520071_2DFCD03A 
X-CRM114-Status: GOOD (  10.04  )
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


