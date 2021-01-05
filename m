Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33965C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 07:20:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB038225AC
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 07:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB038225AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fu0cDGa6YmiI7bdj2anxnvxpZIcPSfTRgmPZmDAyuOA=; b=taZL9cjnN4v6FC19/MIkwsuY4
	nvzEgDeVdkPeuPSrK6vhF7OLHt4G0mW8If/+zmD+pNtrOtZwotfnnttkYwWZ16so8DSgY2jMiDS6q
	5Ewuyzr1kpY+Uw0qyNay2ksCuOvHrCxs8tlB5Lj02RCyhdO4oabVq0dRxnXaRq4JmfOQx7eL2sco8
	9/3Rk4tLx8HESaPddM078PxNGuhvuW3uDikUSpu2SbGrSi1i38C76Gzb8zIEyIGgAT8L+JDGIemsY
	9gA2/GC858o7wjrqPZvcSai9ZkG4WX1pcmSQe7VXjKft2oanYcclEQ2WZA15oRnDL5GFYhm3GLxtH
	mtMpP8dFg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwgdI-00070s-Dp; Tue, 05 Jan 2021 07:19:56 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwgdF-0006xU-CF
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 07:19:54 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D93kz0fwpz7PQx;
 Tue,  5 Jan 2021 15:18:51 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 15:19:37 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 1/6] blk-mq: introduce blk_mq_set_request_complete
Date: Tue, 5 Jan 2021 15:19:31 +0800
Message-ID: <20210105071936.25097-2-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210105071936.25097-1-lengchao@huawei.com>
References: <20210105071936.25097-1-lengchao@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_021953_711188_0EE21B82 
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 axboe@fb.com, lengchao@huawei.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In some scenarios, nvme need setting the state of request to
MQ_RQ_COMPLETE. So add an inline function blk_mq_set_request_complete.
For details, see the subsequent patches.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 include/linux/blk-mq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e7482e6ad3ec..cee72d31054d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -493,6 +493,11 @@ static inline int blk_mq_request_completed(struct request *rq)
 	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
 }
 
+static inline void blk_mq_set_request_complete(struct request *rq)
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+}
+
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
