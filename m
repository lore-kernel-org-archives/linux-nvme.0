Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B7C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 10:34:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F289422288
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 10:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F289422288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=thPgRB6uem8bU6z333cygk+CGSk7hX9qkbVyxqigTqk=; b=QkRRBrYKyzJbaTMehtm7inys5T
	g/e1JJQVJBniZxu1pIMV3U2gzpF3UXsLqF11Di6fDJ6u3Ajj+D1TJll78mr2H0F87fVRQvshnYiL7
	hgJepy3Jrfy0/1qajmxr7FPsqdNH/QmWCQvSXMr5PxfENlSdLtPXTxpZ05kJhvNivSmA2Vyti66az
	W7wl6CWqtAeqaJViv4D6t+3zuIWF+Co+acRLDJNXhwu1XAG/50N3LvxNNsAQjqqSygD/CzAv3tUVo
	bTdv9lAk6lpVDJQHDmRTsXGNctV3jg1SHHJ+/BK0P9xafMh9giRdJ4DQ5K7PIpMDRsgYmlJ9Zf/Dx
	70JVlGlQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwjfJ-0007ie-0y; Tue, 05 Jan 2021 10:34:13 +0000
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwjfG-0007hw-Gw
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 10:34:11 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff4409f0000>; Tue, 05 Jan 2021 02:34:07 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan
 2021 10:34:07 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 5 Jan 2021 10:34:04 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>
Subject: [PATCH 1/1] nvme: remove the unused status argument from
 nvme_trace_bio_complete
Date: Tue, 5 Jan 2021 10:34:02 +0000
Message-ID: <20210105103402.3121-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609842847; bh=PASwNOl9bBlcps0mcA1P9O5AtaXygzuOUGgquWIeCiU=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=PfKldQvgMT9gAjPgaer+W7k1sY0lsRmkEmAxy/KaXi49WEW8o7pNAzFJ/ojCYDtoe
 BRsoCMl9yEY1X/KgZTxLFeKG0yslckScBVgt09IB3Hc+wm2et/A6/jFQfdlQsO5V2i
 arE1jMaq+sr2ik93zfDMilEtBqJ+1SYtWKletcHPNGr4o7Ne82BrOlVE3V2zQkCeDN
 3cPtHyIBmZmRuOg4bifsu2tpe0b9Ji2YfcZzqZ488FL50Iaaz0u7SlHzees3Z3VVQS
 qzfdhKFWronvj26rY9UwA8dnsxTdCac0aDmOkxInGGb17EjNSpo+1zmwlh3iOYxszg
 pG5ma9BHfdADg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_053410_651930_2FE62FF8 
X-CRM114-Status: UNSURE (   9.06  )
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
Cc: israelr@nvidia.com, Max
 Gurtovoy <mgurtovoy@nvidia.com>, nitzanc@nvidia.com, oren@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The only used argument in this function is the "req".

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..7da1c42bce78 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -331,7 +331,7 @@ static inline void nvme_end_req(struct request *req)
 		req->__sector = nvme_lba_to_sect(req->q->queuedata,
 			le64_to_cpu(nvme_req(req)->result.u64));
 
-	nvme_trace_bio_complete(req, status);
+	nvme_trace_bio_complete(req);
 	blk_mq_end_request(req, status);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7e49f61f81df..8bd7d8dd906c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -675,8 +675,7 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 		kblockd_schedule_work(&head->requeue_work);
 }
 
-static inline void nvme_trace_bio_complete(struct request *req,
-        blk_status_t status)
+static inline void nvme_trace_bio_complete(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 
@@ -731,8 +730,7 @@ static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
 }
-static inline void nvme_trace_bio_complete(struct request *req,
-        blk_status_t status)
+static inline void nvme_trace_bio_complete(struct request *req)
 {
 }
 static inline int nvme_mpath_init(struct nvme_ctrl *ctrl,
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
