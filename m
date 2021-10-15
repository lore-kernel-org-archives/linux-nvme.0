Return-Path: <SRS0=EQPQ=PE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D316FC433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:05:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904BC611C8
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 904BC611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7R5PYVFPXskQk20vzfFqzumtxD4zBhl8b3RLHCGuP34=; b=YfVfAR50lYtYtkyzsI1p/4dYRC
	QYEc9MAF7TVhXtITPNufHklhYsocuyPhFKil5SaBLkZzNzIhvTUrW/Ma4XfDTX3JeraRo+MplgRjx
	J4E5j/ShFA98E7ijpuATJAKPZxZH7UYC793dVE6asDVOMFTN6vH/obkJ+Im/bOtGxW4NDyaviRrqo
	3eiVkkL6YNiifEeidFbUSVLo2jhQxDmzOr1VEtU3XTgb7yySONaqr+80mSyOfmpq5J88wmQcVO32E
	MnWM8y3K29EDIVW+5km70Xgj6U2RHVf+AsXwsEJLkMkqFXsZavu6MIkGnhM9qwqozCjzhU4blXRwy
	fdvPoEpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbXCw-009H1Y-P8; Sat, 16 Oct 2021 00:05:50 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mbWzt-009C3D-99; Fri, 15 Oct 2021 23:52:21 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
 richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
 dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 ira.weiny@intel.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 09/13] z2ram: add error handling support for add_disk()
Date: Fri, 15 Oct 2021 16:52:15 -0700
Message-Id: <20211015235219.2191207-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
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

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling. Only the disk is cleaned up inside
z2ram_register_disk() as the caller deals with the rest.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/z2ram.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 4eef218108c6..ccc52c935faf 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -318,6 +318,7 @@ static const struct blk_mq_ops z2_mq_ops = {
 static int z2ram_register_disk(int minor)
 {
 	struct gendisk *disk;
+	int err;
 
 	disk = blk_mq_alloc_disk(&tag_set, NULL);
 	if (IS_ERR(disk))
@@ -333,8 +334,10 @@ static int z2ram_register_disk(int minor)
 		sprintf(disk->disk_name, "z2ram");
 
 	z2ram_gendisk[minor] = disk;
-	add_disk(disk);
-	return 0;
+	err = add_disk(disk);
+	if (err)
+		blk_cleanup_disk(disk);
+	return err;
 }
 
 static int __init z2_init(void)
-- 
2.30.2


