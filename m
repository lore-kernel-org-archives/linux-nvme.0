Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E40C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:11:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8D42151B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8D42151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q3nVtmU/cS8nWDmEFMF3JKpQpbrQ1vwmAbAqZAKdMM8=; b=MaqABBVdLIlwqVFR2u+wcly1k
	4StfEV+VuEn7/+fXr/865WUoLrehQ/vOTZeUbBg9Zao3YeGewikzkxZh075Me+xVFoiftvJLNDRvx
	5JJcydpF/UP/Fvt+V0vGXf88jfD1kF29WpyhAw7Nxyo+WeRlvmxPwM/cs0JQAYDDQqRybdrhbzOJm
	xKwhNhXAOnI1Kc6ZeROcbHy5EAmye/N1GWEV9DUsBb72NRmM54a7rCCSg6tyNx1Fn4FKgNdrAJwbx
	z1HaxisatYEMUI4TEiwiBxYp6VezscfjfqTAHZHzkMGD1lyLcrpgZTkRlyGnQJ8aXdxCLQqJ5ckf0
	yFQ25pdVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwI8t-0003BD-OI; Mon, 04 Jan 2021 05:10:55 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwI8r-0003A5-6x
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 05:10:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609737053; x=1641273053;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+KFLZpUtOVppPVkEGSqZ/Y2S+fvYtihjTo9dNASzwNg=;
 b=R2hXJ+mQFO05FghgY20PwZ4JUUHD56AaZ4g8uW3ia2ZVuYTg55iRK0K1
 K/CkadwPBrjg9LFC3QtYO/4BNa8a5l7qVtC7nAxIJq4DDMWaIZzgdCM1P
 ZoaRFdI+D/lF5XjbsCEBIyYHR2jKhyUM8uuJyxr8vRf6TSwXIEmxdI4Hh
 0Jv5GibMySGNqJ9p8KDWqb1GKwUVSkey4Tvru3FYDWWRgT2dBBIwFyQB4
 hSogVJBvviDsmlb24zTZKVMzGSrBR0GTplfo66Pk4SGSTdlM7bQ63Z0e6
 JDHr9j7Lqn3aAOcwRWHAl7Nt8BglKeHb/lu2MTOSAWkAk1GtI+P31j653 A==;
IronPort-SDR: ZFNzid5ZHrncAJUIS+xCKGF3RdaviuUy6jfpG4lASonzCpyxkP0hZe/gE2xSecXzCX5M0mxt4y
 7iAg446hxn7SBhz1xvjjprhcEoipMeeLvT/eWaJC3rADqw0XNoDzBSq/HOYTkMDcjgI2Z5AdlW
 3xI4KvU3aTsikW7LfUVQBOcKkvHOgkZYcTXsVCYWA/3LHDUn8R/O9+Fm/tgBIY+esWInURXLvI
 NMcf9auLK1ufhCmCaxGnMKcqk4L/CsPAvVkck09209wqCLvSvdEGgoMRC46lEJqsblIWp2HdZB
 wmI=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="156435546"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 13:10:52 +0800
IronPort-SDR: g1Y+eolXK9jAdlGOMym5/cX3sbnsLwxJhzAc6jSXraqqsZjb8O/k8X4kIDN6z1Bm9FEcz/Q9QZ
 P9UQBD+mgcLvWy7rONOMRlDpSiYWtCiaQK6RzCHee5iGh7tBmSF/uiuR023sgXRbe286kjSOD2
 0pKPCIp+ureBqasIDHQ1pj1Y7Gx9jvJreFdm16KnSfO6+J+s7XY6Nw7niET329P4SfyKic67+x
 Awd5DGdNTWg48UCmgUTu2gdDKFGy40hEdOH3qnheRgd+/2yyB1tvsL1nLjcKdIyqC3bkT1oqLX
 MebaoSK3bwUx+WsEg86xTgtU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:55:47 -0800
IronPort-SDR: tr8h9n2O/GmS+XsItSRqUgXDtD/n2GCU9YK2cByI02z3Y4mvtpMzTQk2x3IsrZPZe9goZIVo5r
 xDAlxLTOTL6Q/oTiZ1ATA4qh8pSeLZKdh1Zrj9ii1lmuWWnJUgfvKz0hkPHwSoGVF1OZG2qqcb
 sa0bvNbbgSjrJyMde+MmCWZc7MMHutSZbbyWUmH5NUcH6iG4ekk5PBQmLFpIkBD21MLxHOhwTY
 Wdi0SWNY/9z/pRYWBaoyFSMVM7ivhhBevE3YltZCLeUBJtS8LAAYgMrXuQJFZLP9HP2CBXw2y2
 150=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 21:10:53 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 8/9] nvmet: add common I/O length check helper
Date: Sun,  3 Jan 2021 21:09:37 -0800
Message-Id: <20210104050938.25745-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
References: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_001053_407494_13D09CBD 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With the addition of zns backend now we have three different
backends with which checks for the nvmet request's transfer len and
nvmet request's sg_cnt. That leads to having duplicate code in for
three backends: generic bdev, file and generic zns.

Add a helper function to avoid the duplicate code and update the
respective backends.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 +-------
 drivers/nvme/target/io-cmd-file.c |  7 +------
 drivers/nvme/target/nvmet.h       | 14 ++++++++++++++
 drivers/nvme/target/zns.c         |  7 +------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 562c2dd9c08c..c23a719513b0 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -240,16 +240,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	int op, i, rc;
 	struct sg_mapping_iter prot_miter;
 	unsigned int iter_flags;
-	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
 
-	if (!nvmet_check_transfer_len(req, total_len))
+	if (!nvmet_continue_io(req, nvmet_rw_data_len(req) + req->metadata_len))
 		return;
 
-	if (!req->sg_cnt) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..e7caff221b7b 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -241,14 +241,9 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
 	ssize_t nr_bvec = req->sg_cnt;
 
-	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_continue_io(req, nvmet_rw_data_len(req)))
 		return;
 
-	if (!req->sg_cnt || !nr_bvec) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC)
 		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				GFP_KERNEL);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 93ebc9ae3fe4..f4f9d622df0d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -685,4 +685,18 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 		bio_put(bio);
 }
 
+static inline bool nvmet_continue_io(struct nvmet_req *req,
+				     unsigned int total_len)
+{
+	if (!nvmet_check_transfer_len(req, total_len))
+		return false;
+
+	if (!req->sg_cnt) {
+		nvmet_req_complete(req, 0);
+		return false;
+	}
+
+	return true;
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index bba1d6957b6a..149bc8ce7010 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -289,14 +289,9 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	int ret = 0, sg_cnt;
 	struct bio *bio;
 
-	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_continue_io(req, nvmet_rw_data_len(req)))
 		return;
 
-	if (!req->sg_cnt) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	bio = nvmet_req_bio_get(req, NULL);
 	nvmet_bio_init(bio, req->ns->bdev, op, sect, NULL, NULL);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
