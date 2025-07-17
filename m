Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E15DC83F34
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+4OzER4OyH2p1GjoxLsAyvot6MPJK4LgJLJTCGwV74A=; b=HVGV5skoQvqFQ4nNdKmcZEOSjs
	YOSRU8O1m10hFoYebRS3+NzecuU9YCZL9z/NLr2NMJu7KIyaBLRzCXhg6puhfdQ225JkF6wJspDvm
	lpAe+j3H66Lng2zI4Zum6+tc+UhbwSeKpnaeYrfCIPeRCEyHT5fgNXGSt9bDWm7opkwzrfytw6MV5
	CapDJrUNMW5IO3VMPHYi3qnskt7ao8qOvwCPCyCbpYPB4yTcjDHGIrG4kq2j2cXtvB5jvCuarKmHs
	MERpUEEN3Zr/LQnRmkgH4Ihjc36Jib5b+f1GY2OGAjaH+gyz82//DL3YWESubcovptAtYu1sKikQu
	dw305RuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ7u-0000000ARfy-23ET;
	Thu, 17 Jul 2025 15:02:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucP4S-0000000AJ1K-2Oja
	for linux-nvme@lists.infradead.org;
	Thu, 17 Jul 2025 13:54:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 00CC060200;
	Thu, 17 Jul 2025 13:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E076C4CEE3;
	Thu, 17 Jul 2025 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752760487;
	bh=nvFG+G9cWFNGo745GVqIx1XqhTnnYN6UhU020EnNbQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeLc87rWupwgFsgR+54s2uL3mEUOODLi1gxoXugDQBd4Iur6WiwBnKmVTBlpZ9D+k
	 fNmLr9cIRDaWYmWYGE88wSq6d/Nucf2m/02G1ZxEDUC7nH44dgveq9z6C7IAfNyYr/
	 OBVNB3veyEkmAdjNhFpznauE00L08eBS88tvAXBxSSDIP/Jt/hzRSljX0noby9f5V1
	 29TlinMFE4ZmgJO3FFG2LVwNqZszw7Q8kLGuSh3y+4RzWiKPd8y5hT8HchFiarqwJ0
	 +8AtlUUqOWScWt9FtxuT8vTGQow9llQtlqBY0bUh+dTn18vbxl6mX52gCt49fkAwz0
	 JvozNGzcqBPbw==
Date: Thu, 17 Jul 2025 07:54:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCHv2] nvme-pci: try function level reset on init failure
Message-ID: <aHkApYpN-O1HLKp3@kbusch-mbp>
References: <20250715191627.3690017-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715191627.3690017-1-kbusch@meta.com>
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

On Tue, Jul 15, 2025 at 12:16:27PM -0700, Keith Busch wrote:
> +		dev_info(&dev->ctrl.device,
> +			"controller reset completed after pcie flr\n");

Urg, sorry, this was the wrong diff: that '&' shouldn't be there, and
build bot will probably flag this.

Christoph, could you squash this in?

-- >8 --
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7aa8ba4951f4..73d5a5298822a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2083,7 +2083,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 		if (result < 0)
 			return result;
 
-		dev_info(&dev->ctrl.device,
+		dev_info(dev->ctrl.device,
 			"controller reset completed after pcie flr\n");
 	}
 
--

