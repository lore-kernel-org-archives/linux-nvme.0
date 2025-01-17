Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47652C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=z2f9BLIhtCpgiQRlG1198KZt3a
	MYGGXCxrZ1JKdcf47MazT1jE0xrcjkMhsebYdq6fJ9cTG8LZo3luAmHA3tnb1PJzLSvdCbUQ8jQXY
	PzvFLXY2cEZgEgM7RXSxl5lsPsYPBv6l2AEwG2Iti500UQcMSoWVr72O8dOWfttjh+6Oqu1kLEiLJ
	U2gjxOfwfNsn5takIBySCukaRHFiefwgISgca/xalCMTBDOpafwl6v1VKvPjEnDZHz58GAAEOzexm
	cxq4qa9UL11de9KHLPHx916/k9fODEOb5PQpPYpIKynj8YsgCiyI5YJuGsCIGtD18yEGJ1BAhjVwH
	0gT2AG7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhSZ-0000000HIGW-0Eke;
	Fri, 17 Jan 2025 08:12:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhSW-0000000HIG7-265N
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 08:12:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 288C568BFE; Fri, 17 Jan 2025 09:11:59 +0100 (CET)
Date: Fri, 17 Jan 2025 09:11:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-pci: Add TUXEDO InfinityFlex to Samsung
 sleep quirk
Message-ID: <20250117081158.GA26937@lst.de>
References: <20241216223145.135942-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216223145.135942-1-wse@tuxedocomputers.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_001204_687020_DAF894EC 
X-CRM114-Status: GOOD (  10.48  )
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

