Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F66FCA1007
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hp4OiLqi6D+cG9saIPg/Xsj1V1
	6SjeNFMokrqLX2sbocByoj7aJIs+sxkXJejE31LWfh+MOBEKpVKbqvd3WUFKpGozcLFvEzvtgNZyS
	v3GTBvA6v5c5/U3BPpprubNLkXnmgKW4ZVO2zjjUTnvMw13nxqv73DL9tXNqK+tMrAZ8juQAY7J0j
	Wh9QfYglq/jaeYuccdNWcWJPraTRgVt+yBVkJ71NixgsGmQn3Eay8oS6ypVrLXghRuOyjtCs7INqw
	3QH2qqn7GsjhAJBWis+plVz90j2COX6/g7A7A68dayV8y5sQqyl8VggyWH/Oky6e+fWMNDHBwH4Wb
	0Ezjea1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utghF-00000004UJI-2yQ6;
	Wed, 03 Sep 2025 06:10:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utggS-00000004Twn-0lbe
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 06:09:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 612066732A; Wed,  3 Sep 2025 08:09:20 +0200 (CEST)
Date: Wed, 3 Sep 2025 08:09:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	leon@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <20250903060920.GA10161@lst.de>
References: <20250902200121.3665600-1-kbusch@meta.com> <20250902200121.3665600-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902200121.3665600-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_230928_363261_4A03FE28 
X-CRM114-Status: UNSURE (   8.98  )
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


