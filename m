Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB29DC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:16:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB6C61954
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB6C61954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=15OZIVu2XfPocx54kyzXsvW17TPSR0NEP1eyFOMoZbs=; b=2ZVBE38H9AEQdL
	8OT2hJAlRtNdgyuQVdgfxNLCN8ksTnELKq7v4N7uzJp5m0FBAI+CujTLg8AaEIZv2yiuDJ8qLRZpr
	YesZl7OJsIWbGC/5nLNqzdl1IiPrTHWWLDHgJR8dJbaiyVeQV7c1hOTBtPvI/9pUp1g6esG5GNWT8
	8FtyKTM6VOfr32QGx6InUHew3pvT0s3PTbxaRoQYsHqDO4yL1TtbvlRercdHBiUFxKHx7rMGQQssR
	fc7MP+d1R03/f0pTIq72bXMPR7nuwMKt9SM2FTSyGERTQchC6T8xnAzhBcADg/kJGkoGiwOj5clkY
	ylhfd7+GAjWoeuxYZbqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjcr-006msR-TM; Mon, 28 Jun 2021 05:16:06 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjXW-006lhZ-KQ
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624857034; x=1656393034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cp7l1suancENEA0TXDhdwJesP75i8enncPEZ0OTTzkM=;
 b=ZoPfw+gxm/MFWfA3FjuguF1sIsrzjAOXW2YJVYZqhRFe3Utet3Pc0ngn
 oMuT8+ipq6bK8lRqy0voQXdBTkiiL2cyL8Y3HkkQ/BFOYx1HUdWZuyet6
 fwVtOs3KGYHI6XZOIFIIHJiMlxNkWVVAX/ENaUzv1oVGF21ogNG9DYbLu
 wWt9eNyUR0hj/XY+wydWijIk1yTICSD2+Ts0PZ0DsD4ydW6juP9IldXho
 J5o0aXLNcE7h15PLjB7Iu5QEJ1bZ5KtQC8/4lpnVNqvtc6+j273aAF7ft
 DXMTq97BudSOgfVs8Bn0RP1ha2T2sgzrtI5Gri0o29TkS08tw6tR1i47j w==;
IronPort-SDR: TVX0KoLYNm7SpD9BVn0QlUIRW3cDdTtwf/G+t+WBmm+k6XiEWkzTrF/06kv8VvL8ep2hLjKO+b
 m2gvztWo4tM3vifHzIqYgW/cHrwuNAIsNT/VZ6JrMomaWhNFuR+bXFKo4hC3ZJjj1MVd/iDFys
 D5GMwoecc/GE2V7DKnrRI5Dq0nLZ4JxyXyAsjkz9JAbKm7iLF/m+e4RdRYlDYMV3A2Uxx4DwCa
 uA/CjOAJIxptMfKyGJ3HWuuNiU2+UwKOAdqxtjlxi7Y8tQzQfLxIwj7P65d6GK7O2EOKXGnTyB
 yZs=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="173060268"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:10:33 +0800
IronPort-SDR: yeug4Y2UEMB/qkzNPAlbKSjuRt4Gc4V9VhnfcT7+KNS+UJUdtvLqcOU4ayq6efX8dDeteGHlXp
 P42noxOIbrVgV6ImI2/1DpeN1gX9YsTrnIHSxe/TS1j+Hml4LKvvM4/h034LVCAHMyjVX17Xxm
 YFvuqGGlmYyjTTBpicOk61TsmTlDG4WVJ4rgNIwO7yYF3lXgdSStBO98I+aKI9zyD457B/E213
 OvyjNCzyGvAc4YYFZzj8hOoCFsiBKwsIX7oKbecRXyXs+fHjNfrnIJimEyLMpZMxkRWDLc+ZAE
 J7dKInovAn9CWo7qnu8kcvQ/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:49:03 -0700
IronPort-SDR: exN/tax3UrNkWzpgsS3q7COp+YLyuq10QGLOV8hbeZHZbq4Y4n/qT57jZ7BGy4rS7+QqMLW5d0
 3zBfozZNMszIbami/A6x62mLcrc9GzbbgunEosUJqBCHBsrpFjEezKE1T37vRs8+8HcwRk5YKN
 YvCBhohXForDVw3uUIE/n7A2EXXzVVRpNluM3hQtAqD3dunIsXxJGzOoTrPxzCTNyi1jS/h8ox
 5aC4ofuKNde7+5d63Mi0hlA9Jis1zMGcy9UBbxpiooxybAW14+KvmXlcXlArrE7Ump97UD6DLT
 c+s=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:10:35 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 13/14] nvmet: remove repeated call for id-cns-ns
Date: Sun, 27 Jun 2021 22:08:16 -0700
Message-Id: <20210628050817.19788-14-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_221034_754615_A87F3B33 
X-CRM114-Status: GOOD (  13.84  )
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

Return status from nvmet_execute_identify_cns_cs_ns() and complete the
request in nvmet_execute_identify(). This reduces number of repeated
nvmet_req_complete() calls for identify handlers.

Also, now we can get rid of the goto and out label needed for request
completion and directly return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c |  3 ++-
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/zns.c       | 15 ++++++---------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 02d28158e9f0..ef6982beb6b0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -691,7 +691,8 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 			switch (req->cmd->identify.csi) {
 			case NVME_CSI_ZNS:
-				return nvmet_execute_identify_cns_cs_ns(req);
+				status = nvmet_execute_identify_cns_cs_ns(req);
+				break;
 			default:
 				break;
 			}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2119abc2a9b9..f1c9cd445c74 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -546,7 +546,7 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
 void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
-void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
+u16 nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 17f8b7a45f21..2e1f01ec0dd1 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -96,7 +96,7 @@ void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
+u16 nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 {
 	struct nvme_id_ns_zns *id_zns;
 	u64 zsze;
@@ -104,15 +104,12 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
-		goto out;
+		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
 	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
-	if (!id_zns) {
-		status = NVME_SC_INTERNAL;
-		goto out;
-	}
+	if (!id_zns)
+		return NVME_SC_INTERNAL;
 
 	status = nvmet_req_find_ns(req);
 	if (status) {
@@ -136,8 +133,8 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
 	kfree(id_zns);
-out:
-	nvmet_req_complete(req, status);
+
+	return status;
 }
 
 static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
