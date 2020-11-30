Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F02C64E7B
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EA0206DF
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rZli7tvR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VvrklgSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EA0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p/JdAhgbPKWyvvSO5QrcCllamvyoKQ7x+iJWOQ/tWvw=; b=rZli7tvR39uW5/ee2l+7HMZ34
	yLLRASLMKsai3d+LZXXw0xYHmj1tM5sOPYf80g5oYSRQCKY5kizYv91arR1X4+k/CWi5t6fKuR+W7
	mLeOWTxILA4WnJQmhK2Halus/v+mshoN4IYG6Grj/Mt8sWjkkdNAF0Dp6fPVX3TNWfZKhulo4Dua2
	cBXMJHNXSfKbiX2upFibNRvL4uWeLjA9mPJMsFsCaQ31qBE9tMUhke81v0x38m3z/lbD6viuPJG+g
	2IlvjJBWdFuW5MlXn1a1+xPnJZOZ7rOnksQpmGrYGEkxZH+UygZaDCuUhCcf4UJGpKnrY4wkHOZBP
	nO1jX0JCA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZuf-0001MB-AI; Mon, 30 Nov 2020 03:31:41 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZtL-0000tY-0X
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 03:30:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606707018; x=1638243018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KZvesihZxqvpooUM98Q5I5u1Gk/h9BuWE3/slZ8Ndhs=;
 b=VvrklgSCrZHulHE8Qe72Hf4RoBFrolxLcXTPloqqXR/no6dZnsiVy3ZP
 nV97Idd3B5xydohYXZvKyjn0kpEAAy1nFNDEhYeDc7TMynCd+IShAo9Iy
 vlKN11LzZDdJ0q7kKXwSX63ARtYbQAOWHGOJrJ79BZh2gVS2oorH+4VDs
 fxS/NQ8e1/ZkzAS+/jB0a7vXsED5Y5O11dWhm74wzCV2LOn1jB9UH5qoo
 KwhXfKM3RMEIX8xda8SP/+CxobrgYSzHF1Y8FIbMtV2SRobXy1q29tUHc
 3xMWeTcrUdF9SrqS3mW9yaiG/4L5pD1hyD2Ab9bqlo4a90v6CUAuWAlc0 g==;
IronPort-SDR: Fbi4s1NDjq2lQQKv7hgFCTT64mDuufED/hrA4HAPBBNcothKWofmx08+fRY8UqEiN8lOEo5lte
 ASXLj4xqCCsIwbUMDbmpiD+Y0gl0GKg3/DLv9FibXNQy2vA+gHTaKUu9kj33ZR4n4/E2lacZYY
 xTChtphuhRRRhOZgm3MS5gXhZBwV4LelnRgslgisPSAWjkyKQPByhM4o7/OOMqTR6LT6qTqP1y
 c2KT1tWOZh/tn0TB778/rNOk1IrOdULPmbzZK52RzzoxpZSSC7ROnaSG5s8MIklh+YBj2ZuWfa
 SK8=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="158242353"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:30:17 +0800
IronPort-SDR: /5nVgbPfGhRQT6xzuK0DqvBbhYEDh6zQWLx5E3VdFcjs8R3n3399PaToyEKHqF2QsyIA+mnW3j
 pZHlb3D+BK7XBMQ1td9nf6lqureX8yALE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 19:14:31 -0800
IronPort-SDR: D/BUOXWv2eTkbgoe7jKf7dg39j2KiXkWrENICF9TxUT2qMl1QE4vc8zXddcDHx96f86j97JzMx
 xRrVlGunzBPQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:30:17 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 9/9] nvmet: add ZNS based I/O cmds handlers
Date: Sun, 29 Nov 2020 19:29:09 -0800
Message-Id: <20201130032909.40638-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_223019_295341_697A4E71 
X-CRM114-Status: GOOD (  11.46  )
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
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add zone-mgmt-send, zone-mgmt-recv and zone-zppend handlers for the
bdev backend so that it can support zbd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e1f6d59dd341..25dcd0544d5d 100644
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
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
