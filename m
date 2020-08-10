Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60324C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF8D20774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q0Zt92X6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OPfPhmjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF8D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oNpSh5oyf4HW3IB7r1a/0ZS2YYPbvlaojCFdLMogTRA=; b=q0Zt92X6b+zWmqu7VhGZ7w98i
	AtFESQVXFqGK4kClwz/Zfm/eIpl5+DJ0U6PeIxYsjrYDsffIqiTz+ZEvfEPuaXj5fVu33wQ5KSMuM
	yA0km7OlS9DxsG4uuNtb8bILBEf57bNVxVIUsEmx4cUMaw3hatxkXcITRxKrfI6pEW76WB23qrXaI
	O+ewsvfrnZ2Ydldo6vfY/bPcqLo9oUJACQcm9UL72wINFnAzaZ8Dnzga/Hbb9GqmXhur7OFqFbTVE
	Nb6sHTRaH+r8URIhnZciyiHzURWb6hJiLYILTRJqn81EzDfSv4t+G2B+Ungi/dPqXuMYwY9auZtDc
	kuqKv+Qag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5CxX-000753-Dj; Mon, 10 Aug 2020 18:55:47 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5CxU-00073k-CP
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085802; x=1628621802;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gJzXgu6ldZru/2gwwsEmA4JFNeBxSzpWL5td4QtrPEQ=;
 b=OPfPhmjxNmtFzhQPmdJe8C1xzIF6ffwRWsS86D0p63f4ovMK7JTnok1h
 NY6fz3kvgSX6M4ED4IuASgZuk8Y5masQXrJQuc6sR0fve/5zKX8oBst5u
 CZpb56BwnMK7I9sFnLOsNcxrOGfYZ/EghR/lYsL4aJwMUi4NRKANVPw0R
 tVuNPI4/5ZGkguwrq2xyptr3Hr3Pk+1vOWrs5nPVRvxcNCsTX+dO3btsW
 CQFtiN/42GqPO6hACRnTF8HBseXbfGeaU/Ulty9QhcJSo7fUyGI22o/tZ
 wP+liQk2qnlOyycgE8BtJwQ3Ik1+bqbICqB+ebpuxpcwuf6GQzjEPNlPQ A==;
IronPort-SDR: FKiX+GE1lzamSnpvwGFJnd9BjxlFkO0kuWDvsyrckQwL218LpsniyMNMDWuaTDod53f4kq2ZiG
 D6y/MOuf5xp1SXryvW7w+4C/FXn3m1BX2URt46VTcgulrcTtY58hGsZdt4cjTgGKpQgETyVTxU
 nGFE82RSCluRjjSTbgJXOsQ/ogFYnqN/Jp9hNkhFJr6HAV+tAeslp0QwczIqxeHsqczKpKw0uc
 JSjQRArRAC/F15PL+vYF+Richm/bVzbLu+3qVA7HhXOBHmDC9vMnFg0bzyiXg75m2yceEH3FEu
 29o=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="247732494"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:56:38 +0800
IronPort-SDR: qNTBuLX8IUhaMfLmYqrlQLfPYi4ZD93WuYv8Ai6Jhzw0rFuF9YAABpmmREru6PcRnvLemljNQP
 UahL2KPl7/Tw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:43:35 -0700
IronPort-SDR: Wb22nRTXMBO1/WAz5zRptWEBuxRXw8u+9pty9dbhgrYbbQQ1qMGKBmgGdM5hVGyMfaodugfHGH
 CyAjXZNHMCNA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:55:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 05/14] nvmet: get rid of the extra variable
Date: Mon, 10 Aug 2020 11:54:47 -0700
Message-Id: <20200810185456.7713-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145544_554397_E51CA953 
X-CRM114-Status: GOOD (  15.64  )
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

In function nvmet_passthru_execute_cmd() the return value of the
function nvmet_passthru_map_sg() is not used to determine stauts i.e.
we can safely ignore the actual cause of error that is returned and just
check for binary status pass or fail.

The prior check to this function call can be combined safely with the &&
so that we can get rid of the extra variable and second if condition.

Remove the extra variable and adjust the code accordingly to have only
one if condition.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 58377420874f..9a175b8b9d57 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -221,7 +221,6 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	struct request *rq = NULL;
 	u32 effects;
 	u16 status;
-	int ret;
 
 	if (likely(req->sq->qid != 0)) {
 		u32 nsid = le32_to_cpu(req->cmd->common.nsid);
@@ -242,12 +241,9 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
-	if (likely(req->sg_cnt)) {
-		ret = nvmet_passthru_map_sg(req, rq);
-		if (unlikely(ret)) {
-			status = NVME_SC_INTERNAL;
-			goto out_put_req;
-		}
+	if (likely(req->sg_cnt) && unlikely(nvmet_passthru_map_sg(req, rq))) {
+		status = NVME_SC_INTERNAL;
+		goto out_put_req;
 	}
 
 	/*
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
