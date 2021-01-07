Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739DDC433E6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109F322D01
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109F322D01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V/2MMoVxG6s9t+9rML4hy8M+3tuDKBsS8WAIdxvt1fo=; b=pnU0100DlMowO9p0jTKyEmakC
	uuTlld9ThRuwbaHHrSL+Q8HTNVBKnfl4FN8TKscGPGS3TADdZRmXs56PonMMdZte01wQLQ5aeySa9
	BWRhRx2mKVp+2s4a0GNk4kv/cWAjrJY6Vi/o81BcYsn+FCn8T21BlOGdcurTpbyu8MnnZTk4jWeg+
	sM98Q4HDmz9oS4foRFByf3II3PPefExcNUjGtYE9WtomKZKXuPUosKH1VtQdAfq6vbX7ajLjDgaYb
	yUeFj+cfFKx0eRd6Vha7raEvEUo+zHbbyrGxXipY6NtSHNnDwV1O5m6AUN4X+ZXeuGx6OVWPhkR6w
	CBfnDgztg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxM27-0001Oz-EY; Thu, 07 Jan 2021 03:32:19 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxM22-0001Jc-AZ
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 03:32:16 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DBBb76l2Xzj3q6;
 Thu,  7 Jan 2021 11:30:59 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Jan 2021
 11:31:53 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 6/6] nvme-fc: avoid IO error and repeated request completion
Date: Thu, 7 Jan 2021 11:31:49 +0800
Message-ID: <20210107033149.15701-7-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210107033149.15701-1-lengchao@huawei.com>
References: <20210107033149.15701-1-lengchao@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_223215_294578_63D8F84E 
X-CRM114-Status: GOOD (  13.20  )
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

When a request is queued failed, blk_status_t is directly returned
to the blk-mq. If blk_status_t is not BLK_STS_RESOURCE,
BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE, blk-mq call
blk_mq_end_request to complete the request with BLK_STS_IOERR.
In two scenarios, the request should be retried and may succeed.
First, if work with nvme multipath, the request may be retried
successfully in another path, because the error is probably related to
the path. Second, if work without multipath software, the request may
be retried successfully after error recovery.
If the request is completed with BLK_STS_IOERR in blk_mq_dispatch_rq_list.
The state of request may be changed to MQ_RQ_IN_FLIGHT. If free the
request asynchronously such as in nvme_submit_user_cmd, in extreme
scenario the request will be repeated freed in tear down.
If a non-resource error occurs when queue_rq, should directly call
nvme_complete_rq to complete request and set the state of request to
MQ_RQ_COMPLETE. nvme_complete_rq will decide to retry, fail over or end
the request.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/fc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 38373a0e86ef..f6a5758ef1ea 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2761,7 +2761,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	ret = nvme_setup_cmd(ns, rq, sqe);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/*
 	 * nvme core doesn't quite treat the rq opaquely. Commands such
@@ -2781,7 +2781,9 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 
-	return nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
+	ret = nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
+fail:
+	return nvme_try_complete_failed_req(rq, ret);
 }
 
 static void
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
