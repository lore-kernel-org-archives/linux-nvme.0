Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B01C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:22:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0206115B
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0206115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yj4J5acB+e9VKKCv93wBw/qyjFmh0LXsBuMOQLMsS1U=; b=Kpf8SJfCFUGs5L2aKUvmxmStw
	4yYgEHzT7I8TK3kEwTjW5PbHfd6iYAs/kILSJPP9FtFvZefJ/UJ31wbrT/McE7bNCAHkgeqNdOAH5
	d6yoL3uSNNMruMVg7julJavRS3SY4icDaEpOUgOzQ0uyZaalR2dheKysfNey0uo/GsagzwEUs5PII
	b1gkt0XQguZszBKqNq5JkCmGpc9OoR4kukVtcHFyymHnreydp++/qEs9C4ZeItgNfWbSli2xvazD5
	C6Qzr5J4SDJjuqgJ23G9e+2p0K5ln/0/TmTfB8klGrTVTQUoY2k2R0xpo53f6Fo6kME2ifoBn/AOH
	VYwRzrn0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTgF-007y4A-Sq; Thu, 08 Apr 2021 12:22:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdp-007xOP-Or
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:20:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=rqC98FL1jzNYoY21G/T1XMqt2URkhNUwUWiaG85IfBw=; b=2wJyJooxHEwu4tH8ANVTYvBDwc
 P/Iws2sQr65TJTV8qA4HzBorvMdLf1Sdm9Yr0rdUN/m3Qh4ntDykT96LGyireoHl9loYCq4/Rxtmo
 wi28SOycD5Sqvc0Giu29vX5b1wrdvbubqPOIYkt2kEgFUIyTC30U4hwyPzdMpTh/RXv0v5SR0xVcg
 3/5c8FyJfrXjZE8fO978Hzxdo3/8qVStXgddo1BfiqYZ5l4ArMiOnXkZWs/dOsCeiMK/HSEuDXWPc
 twlmdz5qyC55Omlv7XGM4AjLLMTyBQJU82JL5AJVfCzJI2K6x+0cgEZdRXi5n0hy1n8qzfHmfeK8i
 kJt7PJwg==;
Received: from [2001:4bb8:188:4907:196e:5227:9015:fba2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdl-00HAUL-OW; Thu, 08 Apr 2021 12:20:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 11/13] nvme: factor out nvme_ns_open and nvme_ns_release
 helpers
Date: Thu,  8 Apr 2021 14:08:40 +0200
Message-Id: <20210408120842.1450092-12-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

These will be reused for the per-namespace character devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0072df1dfd54c7..7ebe0225e01412 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1483,9 +1483,8 @@ void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
 		srcu_read_unlock(&head->srcu, idx);
 }
 
-static int nvme_open(struct block_device *bdev, fmode_t mode)
+static int nvme_ns_open(struct nvme_ns *ns)
 {
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
 	/* should never be called due to GENHD_FL_HIDDEN */
 	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
@@ -1503,14 +1502,23 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 	return -ENXIO;
 }
 
-static void nvme_release(struct gendisk *disk, fmode_t mode)
+static void nvme_ns_release(struct nvme_ns *ns)
 {
-	struct nvme_ns *ns = disk->private_data;
 
 	module_put(ns->ctrl->ops->module);
 	nvme_put_ns(ns);
 }
 
+static int nvme_open(struct block_device *bdev, fmode_t mode)
+{
+	return nvme_ns_open(bdev->bd_disk->private_data);
+}
+
+static void nvme_release(struct gendisk *disk, fmode_t mode)
+{
+	nvme_ns_release(disk->private_data);
+}
+
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
 	/* some standard values */
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
