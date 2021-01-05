Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDE9C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 07:20:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5490224F9
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 07:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5490224F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EvG1tNwBz6/nvNRc1hVWLHY1Ru97GFJzG8vswn8gxVI=; b=xIj4clASWRE6STZsDTlaYaRDU
	bWw8KdTEiWcdRNXXAor8NeNlR1JfwIiF3uXBheYspWJ2zThrOWPN6ZdDzFpUyFHYHtxfMmackk4Dc
	bXYY0cR1gK/wKI/L+pSs/baXbddRiK72yVKuQjJd6gDS04TH/Epw40lq6m+0g3MB8m5mLFsqDp7yj
	eO8Uh4d1vndXdAqkSgthjmxhufyJOH52mbtbgktY4n4DPFqpkXOuzfTuECly5LH7g45dQEHRbsTCx
	7FCRzIS2WpxHVUwZcb2EzQriIhLtGP+KtviFcixCmGt6ve9Sh4mGL/VU6YiBdy/DBsLnasHNx1du2
	ZYqjDnHTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwgdK-00071v-RQ; Tue, 05 Jan 2021 07:19:58 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwgdG-0006yC-1W
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 07:19:56 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D93l33yQRz15nk1;
 Tue,  5 Jan 2021 15:18:55 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 15:19:40 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 5/6] nvme-tcp: avoid IO error and repeated request completion
Date: Tue, 5 Jan 2021 15:19:35 +0800
Message-ID: <20210105071936.25097-6-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210105071936.25097-1-lengchao@huawei.com>
References: <20210105071936.25097-1-lengchao@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_021955_000002_953627F5 
X-CRM114-Status: GOOD (  14.06  )
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
 axboe@fb.com, lengchao@huawei.com, kbusch@kernel.org, hch@lst.de
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
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1ba659927442..a81683ce8cff 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2306,7 +2306,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	ret = nvme_tcp_setup_cmd_pdu(ns, rq);
 	if (unlikely(ret))
-		return ret;
+		return nvme_try_complete_failed_req(rq, ret);
 
 	blk_mq_start_request(rq);
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
