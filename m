Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC02DC43381
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 07:04:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389A32396D
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 07:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389A32396D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vtQ3QQOPq5HhvP0kc+ruJ466OCskRTNzG4rxYasjWMs=; b=apNT1bsRXRyTd+LgW36az3v+G
	efBJ1Dt42kymr75xkvT109nZrgfVliBDOgLdw9OMPFVY+n4GaN9CCozdvQwoPoNquS72e8NhNN4jw
	5FJXOu7AEDGyBmVazYx7g+NVoygm6XzvZdo9oAKOmoj8kM/nLuU81RmPbjZyon1vczxtR30Cy0xYa
	Px+lrZNEubKsRIZwWQBZ7Qzg+90C5Uqo0+fBiELUo53/2Jh8Whn5N4nMX3Di0ORG6AGyrooCp82u+
	T5ErikQdfXDez1e6YItF1RAL3NdOqf5ZTz44FjlcCrD74JGnJN1NcUJN30OFPQRBO0ukk6MBitHr5
	+yoCMivYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2U0T-0006lB-Ju; Thu, 21 Jan 2021 07:03:49 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2U0L-0006hb-GG
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 07:03:43 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLtcj59K5z15wfw;
 Thu, 21 Jan 2021 15:02:29 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 15:03:34 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v3 5/5] nvme-fc: avoid IO error for nvme native multipath
Date: Thu, 21 Jan 2021 15:03:30 +0800
Message-ID: <20210121070330.19701-6-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210121070330.19701-1-lengchao@huawei.com>
References: <20210121070330.19701-1-lengchao@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_020341_804688_A35C634D 
X-CRM114-Status: UNSURE (   9.97  )
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

Work with nvme native multipath, if a path related error occurs when
queue_rq call HBA drive to send request, queue_rq will return
BLK_STS_IOERR to blk-mq. The request is completed with BLK_STS_IOERR
instead of fail over to retry.
queue_rq need call nvme_complete_rq to complete the request with
NVME_SC_HOST_PATH_ERROR, the request will fail over to retry if needed.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/fc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5f36cfa8136c..ebc9911f9528 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2791,7 +2791,12 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 
-	return nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
+	ret = nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
+	if (ret == BLK_STS_IOERR) {
+		nvme_complete_failed_req(rq);
+		ret = BLK_STS_OK;
+	}
+	return ret;
 }
 
 static void
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
