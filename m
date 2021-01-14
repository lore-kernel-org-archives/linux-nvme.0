Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D942C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:35:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4BA23356
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4BA23356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i/Hev3bq+Ab8DdbkgpzlPZM3qn3EOzL1f3H1W1NZE34=; b=UQwk2mTzPtTSgZv9xlsdUooyE
	s4yGG49Djj4E/uxUhDKy6oK1Hd6hWleLjEKRn9sCImog1wfegIE2CqerGH5+MyimAqpnL0LTCQy09
	pR2JVMJIXyf801T0r4bqqDJvMsFKogHODg4C0+lVtagVYzN3B/ae/zYv7qbm9wTTXb3C5nOyvNrgl
	utIermh5U+WMjp58TVZbvkbrcTwWvrXJfx2OgrnekQ7NkshRPL8cFDzjzXeasJ2Zq37cbNlIyxITR
	LDuIta2n8OOSC05Xvj87o4zfLt9DKk4E5Sei0drsSJgh2Pxnd5Uai9PTnG+e3k9lHVusNT/sZm8GZ
	cRz3xNzGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzrWz-0006nw-V1; Thu, 14 Jan 2021 01:34:34 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzrWx-0006mw-I7
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 01:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610588071; x=1642124071;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pR5IIefX9LG6JTfdjvcqC5DbFMCOeFLWBcIkN5bZCtw=;
 b=cfjPGIXmExKTJxRpSFy8kvjcBYV59P/XiFzEgH892dr2XESxxYpf/8em
 1IuNgPMvP5MBmKMRwjKVgAoQjPy/qIkO/9YPb0TIvyXEg/PZNlny2C9BU
 SvjWpefAJuLVIdpWbnNgsZDZXpZPm8AKvZas+BrW5rl0UtDRI6k/OFMHI
 RKd0/Hx+xTXHvnXpi27gVqqBejGJLpwJqAkgrTibZmg9edPs8QmnlGE8Y
 Vqf4AduXJv5u34slf/EMb3LZ3pbIaTjeiCTV2lcmcHu7yId8hqw1NfLaL
 lef6WQrznw2Qy1cZJIi8iSbbJxJ4jM6la9iPcfshwtWXMH7dIXsN1Yb6A g==;
IronPort-SDR: IleDG6tybtGSJHH2Md+wCO/URxnhA4pmN7EgB/mG9MYPYYwXHvxtuJccU6V7dpMxk+mATBvF2O
 Twx1PW+0vO3usBfs/AH5rh/SBINM21O+kxKeF7yRHJFHZ7GA/pi6XEkRdB8M54yrjNDi1r44wH
 5+q9pgwDsOmnijOm9RgVbdRMDOhlkDjhccUNdhhH2gJBB8gL4UwzATswHgUwvzDaP9BLHL9ZFT
 lN8P72MPJNYlASKmUbcc+uvdUxH62q2VF0KoWF+kz+KV+CtGRYzi+0ckAtUyIHYB3WAlgZYgoe
 gbk=
X-IronPort-AV: E=Sophos;i="5.79,345,1602518400"; d="scan'208";a="157380506"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 09:34:29 +0800
IronPort-SDR: oMhIGYI+/PWBRSgcw72w5qr3dL2E1dX5gPfaOfqsqfICUeQuEuYy4GbmGYPsH6xAtu0gNsMF5W
 6mhhm3OjIBBCmEQ4ki79v7G6Ga0giG4fbPerEMOJDeHTs4SOusMIElR+P0iw1k987Vfm9s2fUG
 i8sqS+/JQT4aZJey42DeIvpG+w2ohdLhf8UdYaSARjEHXQFRYjc1g+VBPs1DocfaAKIaF44yDk
 dL/ZYpFXS5bfXzGcBvRyEgzw8GoS15vQlQD0hEsYCeYbVU/z/IkEMzX2gSlo6D7xYPa1GfUiQ+
 yVlBBaGL8B8q0Ip+/+ijow1l
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 17:19:12 -0800
IronPort-SDR: /iIIcGCy2uoH5BfVLBeM/y5SguFQTztkJch6JLLdkegtIZe3bYo8JeR9ZhiZqc0ZThmFep7ljZ
 7ntPnw4Yi2rDOcZ6LVJ8hlCdd+1WhX9lkpVUBp+wNgFYDwGOiKKwJSpgpihYKp5+Gb+fRTJQgv
 GXtQSmJ4kzd+oUy5QBNl33PXQEvLX+fjaohaJqPn4pDnlmA3yep5jemJ2JJ9mO2mOAIhKGyW22
 kPhActCHZ/wb+RVyA1tKkOmBpnt9QhUDPgNJ5cOG0MU66HNFJiLI3HLS0Xh4OHXUuj2+qeYJOm
 eZs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jan 2021 17:34:29 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 4/4] nvmet: remove extra variable in identify ns
Date: Wed, 13 Jan 2021 17:33:54 -0800
Message-Id: <20210114013354.33946-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_203431_773293_9372D316 
X-CRM114-Status: GOOD (  15.78  )
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

We remove the extra local variable struct nvmet_ns in
nvmet_execute_identify_ns() since req already has ns member that can be
reused, this also eliminates the explicit call to nvmet_put_namespace()
which is already present in the request completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 1cc61ca42a7d..613a4d8feac1 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -467,7 +467,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
 
@@ -484,20 +483,21 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	}
 
 	/* return an all zeroed buffer if we can't find an active namespace */
-	ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
 		status = NVME_SC_INVALID_NS;
 		goto done;
 	}
 
-	nvmet_ns_revalidate(ns);
+	nvmet_ns_revalidate(req->ns);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
 	 */
-	id->ncap = id->nsze = cpu_to_le64(ns->size >> ns->blksize_shift);
-	switch (req->port->ana_state[ns->anagrpid]) {
+	id->ncap = id->nsze =
+		cpu_to_le64(req->ns->size >> req->ns->blksize_shift);
+	switch (req->port->ana_state[req->ns->anagrpid]) {
 	case NVME_ANA_INACCESSIBLE:
 	case NVME_ANA_PERSISTENT_LOSS:
 		break;
@@ -506,8 +506,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		break;
         }
 
-	if (ns->bdev)
-		nvmet_bdev_set_limits(ns->bdev, id);
+	if (req->ns->bdev)
+		nvmet_bdev_set_limits(req->ns->bdev, id);
 
 	/*
 	 * We just provide a single LBA format that matches what the
@@ -521,25 +521,24 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * controllers, but also with any other user of the block device.
 	 */
 	id->nmic = (1 << 0);
-	id->anagrpid = cpu_to_le32(ns->anagrpid);
+	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 
-	memcpy(&id->nguid, &ns->nguid, sizeof(id->nguid));
+	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
 
-	id->lbaf[0].ds = ns->blksize_shift;
+	id->lbaf[0].ds = req->ns->blksize_shift;
 
-	if (ctrl->pi_support && nvmet_ns_has_pi(ns)) {
+	if (ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
 		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
 			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
 			  NVME_NS_DPC_PI_TYPE3;
 		id->mc = NVME_MC_EXTENDED_LBA;
-		id->dps = ns->pi_type;
+		id->dps = req->ns->pi_type;
 		id->flbas = NVME_NS_FLBAS_META_EXT;
-		id->lbaf[0].ms = cpu_to_le16(ns->metadata_size);
+		id->lbaf[0].ms = cpu_to_le16(req->ns->metadata_size);
 	}
 
-	if (ns->readonly)
+	if (req->ns->readonly)
 		id->nsattr |= (1 << 0);
-	nvmet_put_namespace(ns);
 done:
 	if (!status)
 		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
