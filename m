Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38845C38150
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WloEZcA/EXYYLdP8Wof5sPfRQEE8cLtzbQaKG8novyw=; b=hteRazoDOCclsuJi2Ecl9tYgpH
	dZmTamEGaKX+MvR/tbmNQZJupG2FTz2sTfpyA6861krMgme0cNXexKTbkea3dByFheMmmDnodtMdK
	AsY2ggUQXtFAag6CTQ4HNoxcov5KGkXaP6Wn36xvcw8VA4WVGXXksgKh8sIHnUY4Cg1jFulBCdNV8
	NTlYHwsjlhcWYjhuohDYpQ0xC9/az6eqdyonfB8Xj/r+wG4YP5ge48jFvMSsr4HCW0bjLHAcfbK9p
	iquf/ocgvCatX64rPRKE3r+ufFsONRMeZpTu/V8F3T71jA2lofEwYlvjuNra3vIMDPqroJLk3s2ju
	fRDrpH/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPm9y-0000000GSHM-0Yqi;
	Fri, 05 Jul 2024 16:51:46 +0000
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPm9w-0000000GSHA-2SkG;
	Fri, 05 Jul 2024 16:51:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nfs/blocklayout: add support for NVMe
Date: Fri,  5 Jul 2024 18:51:41 +0200
Message-ID: <20240705165141.2248305-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Look for the udev generated persistent device name for NVMe devices
in addition to the SCSI ones and the Redhat-specific device mapper
name.

This is the client side implementation of RFC 9561 "Using the Parallel
NFS (pNFS) SCSI Layout to Access Non-Volatile Memory Express (NVMe)
Storage Devices".

Note that the udev rules for nvme are a bit of a mess and udev will only
create a link for the uuid if the NVMe namespace has one, and not the
NGUID.  As the current RFCs don't support UUID based identifications this
means the layout can't be used on such namespaces out of the box.  A
small tweak to the udev rules can work around it, and as the real fix I
will submit a draft to the IETF NFSv4 working group to support UUID-based
identifiers for SCSI and NVMe.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/blocklayout/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 221781fb9cf14b..6252f44479457b 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -404,6 +404,8 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	bdev_file = bl_open_path(v, "dm-uuid-mpath-0x");
 	if (IS_ERR(bdev_file))
 		bdev_file = bl_open_path(v, "wwn-0x");
+	if (IS_ERR(bdev_file))
+		bdev_file = bl_open_path(v, "nvme-eui.");
 	if (IS_ERR(bdev_file)) {
 		pr_warn("pNFS: no device found for volume %*phN\n",
 			v->scsi.designator_len, v->scsi.designator);
-- 
2.43.0


