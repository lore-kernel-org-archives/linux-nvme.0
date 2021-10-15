Return-Path: <SRS0=EQPQ=PE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A5FC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:03:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2BFB611C8
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2BFB611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IGHq/zn5r0bFrYNjymK6TXitnBNWw/sSmMius/3bC28=; b=V0miwoM+9pOzVHB1SpeV8xkPiz
	gkKCdDNOfSMjm2GvXPW55n48EJPaF1JP0lklVcrxLuvPEusCngWLNE6JAA+9CsUV1nY3R2dTmrGON
	mHE2HsI+HDTtARDUzmArMQRTBVSb7uzewTTr6y4dx+nAVEjfvS6ODZIGdH+6t8wJRIckZvE3fU60D
	73++U+WvUbFUu1AGbN0So595X8JFt1kKf02Tl1gWeWAWJl9+1rzjk/vrG8D+R8/R1qC7rWIv75HYK
	6dOzLGxi7H90G+Cv920Lz5GwobE+IKdJjJBQcnKf/wG9dj9SXWEwrMK3ZtHdqZdsgy3iQFEJ+IzWb
	V8wt2OhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbXA8-009GIt-Qy; Sat, 16 Oct 2021 00:02:56 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mbWzt-009C3F-AU; Fri, 15 Oct 2021 23:52:21 +0000
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
Subject: [PATCH 10/13] ps3disk: add error handling support for add_disk()
Date: Fri, 15 Oct 2021 16:52:16 -0700
Message-Id: <20211015235219.2191207-11-mcgrof@kernel.org>
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
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ps3disk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 8d51efbe045d..3054adf77460 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -467,9 +467,13 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 		 gendisk->disk_name, priv->model, priv->raw_capacity >> 11,
 		 get_capacity(gendisk) >> 11);
 
-	device_add_disk(&dev->sbd.core, gendisk, NULL);
-	return 0;
+	error = device_add_disk(&dev->sbd.core, gendisk, NULL);
+	if (error)
+		goto fail_cleanup_disk;
 
+	return 0;
+fail_cleanup_disk:
+	blk_cleanup_disk(gendisk);
 fail_free_tag_set:
 	blk_mq_free_tag_set(&priv->tag_set);
 fail_teardown:
-- 
2.30.2


