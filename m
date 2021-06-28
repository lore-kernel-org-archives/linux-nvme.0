Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F2FC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:12:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180DC60E0B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180DC60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T8eg3RFrB8WJAjHL9Vb/1+BPnFLNl1ENQlrtdNQ3hrE=; b=r1erH8T52VnnUF
	ijGyZsDTlRO5rQiPo6G2Db3wv/GzEezGTCVTY6Hb0oAiDQC1l+6szP1CPVoUcD7pKcxL3XqiWE1t4
	6t/DCtI894nizC2s+FQtS0DC+dHBfrPtYUSRt0C/BTM20kK5DvZ309j2opNU8AcFawFjeo8w0v8a9
	zaWnODeh4EzdLT7cuB5HK6oJLkv6UXobaO84jPoGb/rOYynCEPAyCgPCDJ78qOcVWymFszU+HLxxQ
	blUlNXIGKTgORE9fllhT4OcRfEMOWq4/J6Bv6RsGI/6Rqp4ADd5ZpJVwgYY9utczd7zlbtkPDwfZZ
	d1LgrPjkhEPa6kNGpadw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjZN-006mAK-B2; Mon, 28 Jun 2021 05:12:29 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjX5-006la5-HA
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:10:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624857007; x=1656393007;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eElD+nbILv6gcIogGqrX0paC0A1qh3FzpJBK/OtzANc=;
 b=TYD9RyksnLNBcgqVjV03fCBKEpjROPYyRag0W+FoOFjJd5EeiNqWhyVz
 lFctIEgNKiqtqGQK0Cfx0D7CnAW2mjvvh4hCNfJ3MEpEJm5eHxOefzEM0
 ReMTVJc7FE2HldrKxX7k6mHU8HX4/aCT68b/UlxGgcmtROTJKQdTK44YK
 pgW6LDM4+VbsyyEN49xyGV8ythlLqWGAz00OPJQmk7X4GiKrgu9aKTqVA
 u5RO996fb8uB+ajWk3e0uxkqUkB8Z70kRJoaceCuwz0JaKGMAx7Z6CqK2
 QBtJNsW404uwzWkmF8xAUQPS/P/37KBKTCyBzsjKxpXv9P3q3NT0tYpcY g==;
IronPort-SDR: q3bpLOIpfZxgAOkIg5hkeXQE7gk49PsMHvZzYd3CCSHYIiBv4Q3xCX+CxFg+UNlk/W3chAY19t
 1emBA4vCl0Zx0g9haZoLzy/rDP7FGoCuCOwwnjI4pK2f4/wjvgaqfNKBdmPgO1bjb3YElS6OWp
 I86vb8OrYK4DMn/oDKul7kbnI7ppCwHQzcv8rN5jXmj3PKUzgBIbR4fq5Yvr/J2jr32VBtQ4uF
 6HJkX1GtLKklFAnv13HP40PI2PtJFxs0mwKbFb0A39VouYh79JcVgZZ43Y2F3W/pQ7SKSwt+wY
 nRA=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="172308742"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:10:03 +0800
IronPort-SDR: +QotEiW9CWwDhtnEulCtTvgda1y+MAaaog01PoM4xvrUozqMn8EgGuiOH69TK6OLbQXrMJvU4k
 q4OKey1fc+G6QHM6chWc1oQLiroxu5qsql9qdCxwl77ixqKxUZS/O+XZtqptfzuN+G4RE3o81K
 mDUCf9w0EdhEmWcFN87CF6DF5hOCoW/D7IdMz6/e+EWaiwxUD4qaoe+lZjlK9x7MYAlW8rHuFb
 r2Za+lGF3eCF/c/Vsf1NibocKk9c1Wfg+a8c4sh13uErQvLm08dmr1JBAYqb/srdXc56bu2IzI
 ZbXy/TQUiP6jelzBg/m8cqDG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:47:14 -0700
IronPort-SDR: mxF+wWUs4GqLU/3C0SzwMIxFrIHLJ4szBd4Vau2+YfhnWU8WDU8m7w5xeOAospSBdw++s1n2pb
 JoHUArBuP8LUd+sFlal5ceJwLVdUYtmpDm1kYCXPNRLpzaBU55YDoCS0/crw940YKdGNycyFsC
 JjjJ+B39iIq8l1jsjW8VPa3W53afvKkqtYj2YmS3N1z3sMJee5KkpOWtC7ZYR+mzobfXgmsSHf
 ZRVSji073uxsyda/1HqLtxlB53obqSOFsq5/Q8i/Wgl2MLjd01iy+eF4pV0io2k+o+yuFR1s+w
 WQI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:10:04 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 10/14] nvmet: remove repeated call for id-ns
Date: Sun, 27 Jun 2021 22:08:13 -0700
Message-Id: <20210628050817.19788-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_221007_694215_03FD8B76 
X-CRM114-Status: GOOD (  12.83  )
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

Return status from nvmet_execute_identidy_ns() and complete the request
in nvmet_execute_identify(). This reduces number of repeated
nvmet_req_complete() calls for identify handlers.

Also, now we can get rid of the goto and out label needed for request
completion and directly return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4f88276e0c48..e625a33d0861 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -486,22 +486,20 @@ static u16 nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	return status;
 }
 
-static void nvmet_execute_identify_ns(struct nvmet_req *req)
+static u16 nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvme_id_ns *id;
 	u16 status;
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
-		goto out;
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
-	if (!id) {
-		status = NVME_SC_INTERNAL;
-		goto out;
-	}
+	if (!id)
+		return NVME_SC_INTERNAL;
+
 
 	/* return an all zeroed buffer if we can't find an active namespace */
 	status = nvmet_req_find_ns(req);
@@ -565,8 +563,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
-out:
-	nvmet_req_complete(req, status);
+
+	return status;
 }
 
 static void nvmet_execute_identify_nslist(struct nvmet_req *req)
@@ -689,7 +687,8 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	case NVME_ID_CNS_NS:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
-			return nvmet_execute_identify_ns(req);
+			status = nvmet_execute_identify_ns(req);
+			break;
 		default:
 			break;
 		}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
