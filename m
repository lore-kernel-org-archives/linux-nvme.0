Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D6C433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:10:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCC6235E4
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCC6235E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=loMPYUq+u3XFg6YEOeoziC54w+K8LzsRRo9x2tn28lA=; b=zyjQYyUlZw7WpwSaYISZ4l+56
	P4ZZb5bGcZYy+NoJSdBqmZIZOTaLjDzvLQC5ISad307Ps5prg0XU0iskZIXifpdMm9du5d5G7yXTb
	BDbb/JZtUtf44vYefPOxqPcUl8LnEaGkOeG6N20J/x22H8cCpM0TSyPcfXthe22x6hPMzgew6T0CL
	rpRYjeIS2FMeguWxGyV2xj1BATVNKuWbzb2LIH7tR+khCvE1EyG1auL/J72RnE2BXtuwY0PyK4LJt
	/WSIanVa086AunvieS1Fg/4J7W29Z0T42DlsUsYLI/ZYxfKr3X9OGwzOmMOSX7P6KlZ0apbNjWbXU
	WYM+QcBHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2Vyd-0003Nk-AZ; Thu, 21 Jan 2021 09:10:03 +0000
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VyX-0003Lr-CF
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 09:09:59 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B600944e40000>; Thu, 21 Jan 2021 01:09:56 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 09:09:56 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 21 Jan 2021 09:09:54 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/2] nvme: update enumerations for status codes
Date: Thu, 21 Jan 2021 09:09:47 +0000
Message-ID: <20210121090948.8027-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210121090948.8027-1-mgurtovoy@nvidia.com>
References: <20210121090948.8027-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611220196; bh=KlMTaKJaMkLKUgiKIcJqU5h3wgf1KxiLhDHPo91HnIU=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=jXqjeRlJH9V5Nlo4cjiPqTHWgGUy10dsXIqeq+i6rkjHk1iPpjREejcrUfZESnhCe
 wrKY5Z2eiHjDEMf5+WRiM6elzdo2cSHNqipOH2/wYF1NINk2qZSmQAwlT+VCH56zaP
 JR34r2OPWBGNNaIZnfKpQeMPT9NAPhUWaseX0AhK8tZ1nHcV72znoHbILoitnSyDCk
 hoNuF3emlEWe8HhWObjRHLsrxornFVDbN6/4AdFnCosPWVuBgO06rJ00AukVcTKtCv
 gzFk/fcV2iRhFtDjzdKEDjsNx9c2Bd9v1gS4fb6k59Q0BupJE2lrZzZmJ20o0Gz1+b
 sOMot9ehngrcQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_040957_482931_719A9790 
X-CRM114-Status: UNSURE (   8.50  )
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

All the updates are mentioned in the ratified NVMe 1.4 spec.

Reviewed-by: Hannes Reinecke <hare@suse.de>
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
