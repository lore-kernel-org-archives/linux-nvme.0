Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B293DC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:10:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6703660E0B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6703660E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+KqiFV6H7C1nnZJ/v4qEcHjo1gd/5Qd/KDG/0ZBA+x0=; b=I7zJLfH9zghf5q
	hTQaAksNiKEDOMQKjtNAEMvv2+liQ3Jqy9Di14hnlGlBaKhr3jF3wXKHbyRgf96TjjmY8sHrhdoSh
	U1E0g2pXSmfrQURoKCA/09hzBr3+FRyTKcfmqZktnN3o+lUI8MdLye0N20lRD4+ylF/XhpmlZa3WW
	1SpRvEyrU5lZTLNjUgmzn8fJYAFmuDWVaIsk/YGep+cIQRH1hVj9C+YphIFkeWwruLnEtC2C2l4Dw
	lTq4qWvjaAEoaKZK/tP/EP44WT421YVJm1d8GSguWPXXmNBtTRP99XAQVEmfCO7K24GyyPLq0d/Cc
	rkzfxzMFNah/oRKEeyIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjXM-006leC-Ir; Mon, 28 Jun 2021 05:10:24 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjWZ-006lPp-75
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:09:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856974; x=1656392974;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9UsvBHkc7IpPEndq9xDwF6EMzEMMho5Xx7U+78ixAF0=;
 b=hgIBNI3i5vm+2vl0un8LJCgSsrLYrXKm2AVMngsmLXWq1DX3RNrdFjKA
 Dktvi0pS6g1cWedv25J+ftS8n1UG/Jhre/34LrvPd3kLvNU2JxmkOkf79
 uCacxVnzbcuIPJHVJhTU6cJnVFxpCJrhCXsQPLdpT8sh2+/OnFGigxICj
 wtgGrMafKTZm26dvgn0rHhXHkSgv6IeA8XUQmGwtXDBCZ/pHG7wBl2h+w
 OdwDZcO53sXzKX1r7/SBMkigDBqG2fPfjt6Q3X8IN+aSdfjCrOeX+72OP
 Y4Vo6ppi6LwKs2UlWHuncXQqnP0x+M59us2u6q6s7i1QHy7GA+J6qj9Vt g==;
IronPort-SDR: TTS9If7QJR/UHSbeA+OWW4OtPMqtAqP0bxGD36lMwWkMh95uX96BS1NkNCyTyjdG8CLRVz7s/2
 jfLu6E0ZEI0mIvnTYJhhpLTCMEaIeWZw2CwLieNOBfJEDiuyp7FZJoeJHhXxLp6SmflRNrRdK7
 A+Hp4GL317G36Yo78EZSUj2TyUDVZRD5EoW4oxbjfgBZQfZjquevEbou1eNLv3IG1JZ9rSBRQt
 +lLDZIIGbIizIyqd9rn1i8t/vWS/k6FJr+x9oag3NSgS3oAY88pdcD2qwO+BuXtknfV5wqK29I
 NiY=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="173060178"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:09:31 +0800
IronPort-SDR: BrShEMMdPwikOJgcEQK6RqaLq+mNftK3numshEQkIN9+r5Mbj7Gmv1aUDHQVVmV1c+kIwPIO8E
 oO1gVGLmZOgAptPe8HC64Lr//XbogPwFwarg7QsU+6YW5ZC+SFSN+OvQRRsMueHtOXM0OGn4KV
 BA7WX7ZUheo6H7BKTy127z7wQzPNvgHu9QnmsXJ6eMtov0LoxFZBNd1xDtFhjS6QarylhAW3YP
 vtWQYmlkzDmOEt2Wh1Pqr3yu/wTpRMkCF82dEwEgZ2YKvxqmqLcg08PYR4tzUanTw7MBM7ZyxJ
 OW5KyyvkXdYzM9h2y5xunfBK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:48:02 -0700
IronPort-SDR: 6g9AZI38mSPMUXxHDJjpqZe4erxxLac4/kOecFSW4mEovBzUu6h0JsJdLN3IpOoGZL39IBCNQ9
 PMa3oApIv2uIRtTt8h+ZBtKaHlc+nLl/T/bFQceiBYpoqmspHX07+3zfFtLN/Tj8nJjz2rDQMD
 p3NtqdDvLrBx1+ViY6G+lG0N+td3eAcSBImriJjhcf4YyZ9VSvrDWIFZotjgFwFnc1YafUgxa+
 iwojGvsC6UDjYwfz/rQgeCQZROtLXjfOfryz7l0zY859YSTqwpE9FqzOuguSLdBcNLVvuVx/Lj
 pVs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:09:34 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 07/14] nvmet: remove repeated call for ana log page
Date: Sun, 27 Jun 2021 22:08:10 -0700
Message-Id: <20210628050817.19788-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220935_329402_D75D6E85 
X-CRM114-Status: GOOD (  13.21  )
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

Return status from nvmet_execute_get_log_page_ana() and complete the
request in nvmet_execute_get_log_page(). This reduces number of
repeated nvmet_req_complete() calls for log page handlers.

Also, now we can get rid of the goto and out label needed for request
completion and directly return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cf02d70dedeb..4e58dfbfbbd5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -265,7 +265,7 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
 	return sizeof(struct nvme_ana_group_desc) + count * sizeof(__le32);
 }
 
-static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 {
 	struct nvme_ana_rsp_hdr hdr = { 0, };
 	struct nvme_ana_group_desc *desc;
@@ -275,11 +275,10 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	u16 ngrps = 0;
 	u16 status;
 
-	status = NVME_SC_INTERNAL;
 	desc = kmalloc(sizeof(struct nvme_ana_group_desc) +
 			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);
 	if (!desc)
-		goto out;
+		return NVME_SC_INTERNAL;
 
 	down_read(&nvmet_ana_sem);
 	for (grpid = 1; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
@@ -305,9 +304,9 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	kfree(desc);
 
 	/* copy the header last once we know the number of groups */
-	status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
-out:
-	nvmet_req_complete(req, status);
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
+	return status;
 }
 
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
@@ -339,7 +338,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		status = nvmet_execute_get_log_cmd_effects_ns(req);
 		break;
 	case NVME_LOG_ANA:
-		return nvmet_execute_get_log_page_ana(req);
+		status = nvmet_execute_get_log_page_ana(req);
+		break;
 	default:
 		pr_err("unhandled lid %d on qid %d\n",
 		       req->cmd->get_log_page.lid, req->sq->qid);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
