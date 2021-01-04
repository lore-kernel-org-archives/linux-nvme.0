Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B37C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 13:00:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9A2207B1
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 13:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9A2207B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eWXQd/2hYq6hH1LzWIWLUKgZj4uSdHUu7FLX/GAZbKs=; b=wek7toEyJi8o/m/OEIOTM0Hffv
	2hzjFQ4vyjP2Z/YLpawi8uvctX3IBrVM4uxmc6g5VtenH43jXtO6hRqtqBNQigdgJK9uKHlIha+m0
	dA1b638udZQ4MzS36M/WM2aJAqNWfB/honsy8+/204tbDoYh5umhKxsEd1UJoU8g5CfCbvq4Yl5YN
	81eVVYig+zv4bCB5c/VIw77a0o1zpKSjFuA8qtrCHibZOEeGbEewLL06C+v+rROQwBBreZVjoblXT
	DVLa2lxzEaUPwM4uMToW9yhRc6GzM4Iy5s1IYgnvzJ8aTaF5DKA0f0wgpF5un7DV+i0YFRTeafCSU
	cjb4Bspg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwPT2-0000K2-R2; Mon, 04 Jan 2021 13:00:12 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwPSs-0000BF-S3
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 13:00:04 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff311480000>; Mon, 04 Jan 2021 04:59:52 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Jan
 2021 12:59:51 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 4 Jan 2021 12:59:48 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <oren@nvidia.com>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <kbusch@kernel.org>, <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/1] nvme: update enumerations for status codes
Date: Mon, 4 Jan 2021 12:59:47 +0000
Message-ID: <20210104125947.160984-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609765192; bh=ha/brA+it28Obm9D2pFaGCO2SrxCOc1Hm2nn122MaMs=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=RWy8a/z6WhmALrY7pxX4zaGx0pO6BKS13gjn+1Q985Cj9NcN11+eUQcrPGBcIVz3M
 qMvaoB1VgJTV03EcE0zOBUicytR/n/v0TY/wHToCpJtPiP45f6mptmg+LiD6xcOD2n
 ysWGVgDl7JOl3x5uBOYQy8NYPEP8xRlK05Sf1m8FrOfz8TIKfP2QXnrcxd4v3Qv5GJ
 tbSpcl7/bKnRr76IQg5xiOSd0Wz/0Yj0DWFb2MKUPOxz/H5Tpyd6HXU8FZHBYY11ZN
 PGsj2hLUCwC1OqzUDOZVQMVe9dR1Q5Xo/nRiEqGHKEX0+EA4W/moI7UnkuoqSo5AI/
 +s1FOYzZ04Swg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_080003_151121_6401590C 
X-CRM114-Status: UNSURE (   8.41  )
X-CRM114-Notice: Please train this message.
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
Cc: israelr@nvidia.com, mgurtovoy@nvidia.com, nitzanc@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

All the updates are mentioned in the ratified NVMe 1.4 spec.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 include/linux/nvme.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d92535997687..1c9c34be8194 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1467,20 +1467,29 @@ enum {
 	NVME_SC_SGL_INVALID_DATA	= 0xf,
 	NVME_SC_SGL_INVALID_METADATA	= 0x10,
 	NVME_SC_SGL_INVALID_TYPE	= 0x11,
-
+	NVME_SC_CMB_INVALID_USE		= 0x12,
+	NVME_SC_PRP_INVALID_OFFSET	= 0x13,
+	NVME_SC_ATOMIC_WU_EXCEEDED	= 0x14,
+	NVME_SC_OP_DENIED		= 0x15,
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
-	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
-
+	NVME_SC_RESERVED		= 0x17,
+	NVME_SC_HOST_ID_INCONSIST	= 0x18,
+	NVME_SC_KA_TIMEOUT_EXPIRED	= 0x19,
+	NVME_SC_KA_TIMEOUT_INVALID	= 0x1A,
+	NVME_SC_ABORTED_PREEMPT_ABORT	= 0x1B,
 	NVME_SC_SANITIZE_FAILED		= 0x1C,
 	NVME_SC_SANITIZE_IN_PROGRESS	= 0x1D,
-
+	NVME_SC_SGL_INVALID_GRANULARITY	= 0x1E,
+	NVME_SC_CMD_NOT_SUP_CMB_QUEUE	= 0x1F,
 	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
 	NVME_SC_CMD_INTERRUPTED		= 0x21,
+	NVME_SC_TRANSIENT_TR_ERR	= 0x22,
 
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
 	NVME_SC_NS_NOT_READY		= 0x82,
 	NVME_SC_RESERVATION_CONFLICT	= 0x83,
+	NVME_SC_FORMAT_IN_PROGRESS	= 0x84,
 
 	/*
 	 * Command Specific Status:
@@ -1513,8 +1522,15 @@ enum {
 	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
 	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
 	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
+	NVME_SC_SELT_TEST_IN_PROGRESS	= 0x11d,
 	NVME_SC_BP_WRITE_PROHIBITED	= 0x11e,
+	NVME_SC_CTRL_ID_INVALID		= 0x11f,
+	NVME_SC_SEC_CTRL_STATE_INVALID	= 0x120,
+	NVME_SC_CTRL_RES_NUM_INVALID	= 0x121,
+	NVME_SC_RES_ID_INVALID		= 0x122,
 	NVME_SC_PMR_SAN_PROHIBITED	= 0x123,
+	NVME_SC_ANA_GROUP_ID_INVALID	= 0x124,
+	NVME_SC_ANA_ATTACH_FAILED	= 0x125,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
