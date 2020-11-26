Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B20C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF8D206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d7amVzAX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YEJCkH+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF8D206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=30wUt/bAG/AnKTs+939gc2pzs20L4Ufdz468yOb8iPc=; b=d7amVzAX/UaAogcbHsBln1ZLT
	14t2UGOX395G3gsYd6Sq5xSYHj7ZjMPoWg1sAaxqV3vgwQtzUFZi1/mOYgkGZH9EyYz9ckyY56ws2
	701dakP65Ub0E3XFrs64Z7tiCk1fuZw6n27xZzQFhjuL5lzNCjghDRZHjmnzMZWHcpFyHPeP6ujwj
	81QOfuvviQIlVm7x18gjb6sSlZDha4U50yrUZ22waUns70lxnuYp+9MpoAwO2eHjQ++XuROfNhX6Z
	XRP+rU+Uoax3xQ8SLz2isT9smKTPDZ2lTloAqnXMoMbTqMBxK8lEx+nL3Xhdfryxw/trhHRoE5N+5
	TeFNX4bag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki7Eu-0005WJ-AX; Thu, 26 Nov 2020 02:42:32 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki7Eo-0005Tm-EY
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 02:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606358546; x=1637894546;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qeI8OkQ2C+8qF4W8aVLYYaL1+taXca5eouvg6P6Gos4=;
 b=YEJCkH+rSDLfGtHQ2vVT53VI952V6GbtDmilZXGw4chyyJfIipNZCB2J
 34cTKySL7yH3rEWoBvmV7yrBNmxBbsyg3Pj16daxBWBRRD4y+Mp100xPt
 alWCrHoDbUNvCb2JnkyYXHUGQLw4lIOjNw7Avo8GJ2RoZgRxad9s5SweY
 swtI/JuuKT0McpRNEbC7MjH2UKhRUjBNhiZX29ZQIYfbVbaKqSMpCqqAC
 +BIlcho6CNkPBJLkpBmlt7zvxYSP76dpxF9w37vG2P7WqwTUHsXjEhtpV
 qzbRAw5hCAvov/uI0sm5fj8QX9V4Nt/JBABlur7imBu45LgneXihdP6Z/ A==;
IronPort-SDR: 5IYU7yCD6XC+K+yewmMsePmpjjHDC7kfiSa1TID1hpffF4v6aoA/L/Qv79ftngK60M2Jfp9e87
 RnFQro7kVp1Z/mMVwc315M32smIxORPu32lISvMJy0PH8AkrXQB+AacbsdnZNL93OQLi1SOase
 kIVurLivIH0k8k9CfDDskIOxDOAjE6tuGYmVD9p9inRrBTNaDfYLN23FCddcLfwCyKYvdXA7jy
 2SA8BwEOcBvDm+m5lq4jMIkIBuaYaYvxw7AbKg1QTKk0w/3gHQP+gIdDao9EcQ5yaDsh1EWEc9
 AaE=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="153586968"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:42:25 +0800
IronPort-SDR: pczs9FZhkdw2WbX5UBtfjVjRm0A4HngZb1xTuAyO79e8xkbHDPhZV3vrvVUfJyVMAhJrr2PgRa
 UC810oBohIx+3XX5xRZXe6s47BE6QhjF4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:28:07 -0800
IronPort-SDR: /qUJeynUYlB2tGsiF3eBwSQA1RSvV7doTJnStkhrjI95IQtpqlEChvvEj3rYMPFM5RSRvHvUXK
 lx5jkLdKAkhQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:42:25 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 9/9] nvmet: add ZNS based I/O cmds handlers
Date: Wed, 25 Nov 2020 18:40:43 -0800
Message-Id: <20201126024043.3392-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_214226_826259_F0B581CB 
X-CRM114-Status: GOOD (  12.85  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add zone-mgmt-send, zone-mgmt-recv and zone-zppend handlers for the
bdev backend so that it can support zbd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/Makefile      | 3 +--
 drivers/nvme/target/io-cmd-bdev.c | 9 +++++++++
 drivers/nvme/target/zns.c         | 6 +++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index bc147ff2df5d..15307b1cc713 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,9 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+		   zns.o discovery.o io-cmd-file.o io-cmd-bdev.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
-nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
 
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f8a500983abd..4fcc8374b857 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -453,6 +453,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_zone_append:
+		req->execute = nvmet_bdev_execute_zone_append;
+		return 0;
+	case nvme_cmd_zone_mgmt_recv:
+		req->execute = nvmet_bdev_execute_zone_mgmt_recv;
+		return 0;
+	case nvme_cmd_zone_mgmt_send:
+		req->execute = nvmet_bdev_execute_zone_mgmt_send;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 8ea6641a55e3..efd11d7a6f96 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -361,17 +361,17 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 }
 
 #else  /* CONFIG_BLK_DEV_ZONED */
-static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
 {
 }
-static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
+void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 {
 }
 u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
 {
 	return 0;
 }
-static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
+bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
 {
 	return false;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
