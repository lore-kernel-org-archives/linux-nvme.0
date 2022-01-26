Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0406C63684
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XPQZUxJnS1AhgoTuyOTJHtmC/GkSaDgaBjoJlTyaC2I=; b=3lnc4pv7xm93CZZKPrrCiApV+Z
	AIlurIeYkqGBXNjC0N7SWolUFLwEXrpT+OWbHCXI+jNxgBg+UZkiamjYwnsxfOmOG9bT5arFIs6Fg
	gjOCjmtDEP2FoZcB8lR/eFnPcP0U5yR2A+c8PhptLN+uJM0bfhG3GPl4j378U3+edvgoBmOBnSHX5
	qvopPdYUSh415vnT23/415w7Ukc15KUyOlbyyc5GtVvCHrij7VXjC0Uns90r8VjlPM+1MZrzfG216
	ztrtooX3YjKdpa2Y5dXVPC3kQn3lNrU8euNotq3NGXH1tj81QziahsbS8LHdTFh5iZvGL47yFEwao
	XZplqcQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCluA-00Cvyp-3a; Wed, 26 Jan 2022 17:16:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCl9D-00CdVk-Ay
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 16:27:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9E7E768AFE; Wed, 26 Jan 2022 17:27:47 +0100 (CET)
Date: Wed, 26 Jan 2022 17:27:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 0/3] nvmet: add buffered_io support for bdev-ns
Message-ID: <20220126162747.GB31431@lst.de>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119072038.3942-1-chaitanyak@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_082751_593000_2A39AE54 
X-CRM114-Status: GOOD (  12.21  )
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

Shouldn't something like the patch below be all we need to use
buffered I/O on a block device?

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 70ca9dfc1771a..7d9da2f77b83a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -76,6 +76,10 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
 
+	/* force fallback to the file backend for buffered I/O mode */
+	if (ns->buffered_io)
+		return -ENOTBLK;
+
 	ns->bdev = blkdev_get_by_path(ns->device_path,
 			FMODE_READ | FMODE_WRITE, NULL);
 	if (IS_ERR(ns->bdev)) {

