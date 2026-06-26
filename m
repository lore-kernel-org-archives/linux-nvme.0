Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A363FCDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 07:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=G+fF+15cQRhvILzacXZX2l00nr
	3L5ahvXMlOsjwbOWD+RrfWxtei+9yulT1EGxHwNCYlYoT8Clx44wPLIwDZE8DgYj8ut3MmuSBFca/
	Ftw99KPPEf2a5S5eZSTRsukiaTsp1jB/EzO7sC/bY3HhgU9CkKKcEIwSA4dqLnn/STJwB4ouvNvdd
	F+sZnk61OqN18DLeVmMFh+4PC5r7lAFDbhpbDoRoTbHKbpMXjZXmzqrUEsIxF8pqbifeZICb4RJj6
	Unp+vo70aeUCMrGt58D1BQ/FC3MItoPirmMAmFw1Dfo4SgBCbK3HnE4RbhvD3TFw3MhKe8tGBDM9a
	uY+F57qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Zb-0000000Adaf-1MGp;
	Fri, 26 Jun 2026 07:01:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0ZY-0000000AdaK-1i2U
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 07:01:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2B7268AFE; Fri, 26 Jun 2026 09:01:53 +0200 (CEST)
Date: Fri, 26 Jun 2026 09:01:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix typos in reservation related constants
Message-ID: <20260626070153.GA11515@lst.de>
References: <20260622033254.1350917-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622033254.1350917-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_000156_611412_C6F9A950 
X-CRM114-Status: UNSURE (   8.75  )
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

