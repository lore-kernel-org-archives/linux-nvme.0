Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E245C3DA41
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jul 2024 23:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MW/LFME6Lsdc+4FiS6MpNVW112NfaW7b3f8dERH2vAs=; b=C7kgvJGK4zYzmvZInWodUkeJY3
	L5W3HXMc0Mq8ng9wXKqbv0O4u5bt3nr9xIcAFFzlkkYZ8IEGspQ5OzHULOlOCgskGodfCQvS73/81
	xe8n8ZyHA0DhcEVYiZIeeNlN12O4SG5o4KwkdwFg36nVXPNsCLKon5nF5YUle5duCAQ82F6wQHfjf
	ULrYzWRKbWQE89iClKYpQa7goppRwYpRCviHZA4NjjoDRMq2Rnvd7YZhrW+B7E1PFIvkR+iHThIqR
	gF5HPS2lIFsB5Ik/b1a3WF7Ak5RghOMwMy9c6odcP+aiHgCwpAq/uZYlh+WRFjnY7f8O6zaBXR147
	4FW7ekDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRgZn-0000000C3jM-1SkS;
	Wed, 10 Jul 2024 23:18:19 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRgZj-0000000C3i3-3Ief
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jul 2024 23:18:17 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKDLF2Qx0z6ClbFV;
	Wed, 10 Jul 2024 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1720653491; x=1723245492; bh=MW/LFME6Lsdc+4FiS6MpNVW112NfaW7b3f8
	dERH2vAs=; b=KU7fW9L4pVqvzyN7FGhW11SE2a5eU59HTd7Fh5+vPbtaGKsNRwP
	1IlaqLn0Wc5Uo/cQv3V4KCsbGF6C4lkJObTeQmpzjxNy1W52DeLxiC/jrZHcETCT
	35LhYLa1RT0W3P7dsHDCyFrZP+rPVqnAlCcIJRIjjX/s3DhDJZ0aIFKkv4jl80cq
	c7vbTl7q+BIKPw53l3zonOHEPFQRrzJk/JstdUdcB0sEg/W2Oee9/AVdMpkeO5qw
	ZMnrTi99qm+2zNCihAfa1JNc5xI6OENkhIntgs2jY7jBzx45mwd3GtvxIteM9l79
	2Qyf+swb9b2kRgET4J++CXCR2K/npwf9rjA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jXIlabdb_ExX; Wed, 10 Jul 2024 23:18:11 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKDL95Xmgz6CmLxT;
	Wed, 10 Jul 2024 23:18:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme-pci: Fix the instructions for disabling power management
Date: Wed, 10 Jul 2024 16:18:05 -0700
Message-ID: <20240710231805.10481-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_161815_895902_F8014623 
X-CRM114-Status: GOOD (  13.69  )
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

pcie_aspm=3Doff tells the kernel not to modify the ASPM configuration. Th=
is
setting does not guarantee that ASPM (Active State Power Management) is
disabled. pcie_port_pm=3Doff disables power management for all PCIe ports=
.

This patch has been tested on a workstation with a Samsung SSD 970 EVO Pl=
us
NVMe SSD.

Fixes: 4641a8e6e145 ("nvme-pci: add trouble shooting steps for timeouts")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65f..358822ea40e7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1274,7 +1274,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u=
32 csts)
 	dev_warn(dev->ctrl.device,
 		 "Does your device have a faulty power saving mode enabled?\n");
 	dev_warn(dev->ctrl.device,
-		 "Try \"nvme_core.default_ps_max_latency_us=3D0 pcie_aspm=3Doff\" and =
report a bug\n");
+		 "Try \"nvme_core.default_ps_max_latency_us=3D0 pcie_port_pm=3Doff\" a=
nd report a bug\n");
 }
=20
 static enum blk_eh_timer_return nvme_timeout(struct request *req)

