Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A4C43381
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B4D22D01
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B4D22D01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NJBFjgKBY53wElWaQD5r7i9wgaDS19YrzVXUb41zuD0=; b=DksU29mE0jhRtGCm8YdpU7lT0
	J9WANJjAdgHcGDJN4VTvybX6gFLc35gh+bS0t/ci8o79fERcS7i9TjjYvElGQ3j4IMw8BvVxGuKx8
	HWyIqvMQR0GPSYakow67/quc4ScgEcjgHc+cL8yeYPRLRPDqBwLt3MpHL643e1uYO/tUDDES9Lk2h
	fqzzoc3HTIdt93J3BO042alYasqbuoCnqf1dfq4T0BZ7E2BBMRiKmMKvxkra1gMZ0ovq6MZj+B5pM
	w0QtUS/M7XZqa/eMryUp+pqFvNlTafA5vQ2Ql1w9gvyITjcKBD1vRXl785QS/51Co+p6RfNySRtTV
	+2W95btTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxM1z-0001MH-QF; Thu, 07 Jan 2021 03:32:11 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxM1v-0001JZ-Dt
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 03:32:08 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DBBbM0ddHzj3T3;
 Thu,  7 Jan 2021 11:31:11 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Jan 2021
 11:31:51 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 2/6] nvme-core: introduce complete failed request
Date: Thu, 7 Jan 2021 11:31:45 +0800
Message-ID: <20210107033149.15701-3-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210107033149.15701-1-lengchao@huawei.com>
References: <20210107033149.15701-1-lengchao@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_223207_753030_FAD691A2 
X-CRM114-Status: UNSURE (   9.66  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When a request is queued failed, if the fail status is not
BLK_STS_RESOURCE, BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE,
the request is need to complete with nvme_complete_rq in queue_rq.
So introduce nvme_try_complete_failed_req.
The request is needed to complete with NVME_SC_HOST_PATH_ERROR in
nvmf_fail_nonready_command and queue_rq.
So introduce nvme_complete_failed_req.
For details, see the subsequent patches.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/nvme.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bfcedfa4b057..fc4eefdfbb34 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -649,6 +649,27 @@ void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
+static inline void nvme_complete_failed_req(struct request *req)
+{
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	blk_mq_set_request_complete(req);
+	nvme_complete_rq(req);
+}
+
+static inline blk_status_t nvme_try_complete_failed_req(struct request *req,
+							blk_status_t ret)
+{
+	switch (ret) {
+	case BLK_STS_RESOURCE:
+	case BLK_STS_DEV_RESOURCE:
+	case BLK_STS_ZONE_RESOURCE:
+		return ret;
+	default:
+		nvme_complete_failed_req(req);
+		return BLK_STS_OK;
+	}
+}
+
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
