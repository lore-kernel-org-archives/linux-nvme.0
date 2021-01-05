Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C36C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 07:20:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FA2224F9
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 07:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FA2224F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+Qa9ktOxvaHDzHWv6fbiCQgdc1UvF2ECanFVHDHsTuE=; b=XAyuG6kJ/AxE2YbMfqDXTp1+1
	5Xgmeaj/N8Buk2JjYpsMUUHOQHL4I0jeZHxLbd7f+QjhKHVtdtPDegMfohcqDAZ5sc9TV960Xp6Hf
	pbvlK37qF/zFeL4pCUqq6f6rEJzXRp0xg1z14VkPkbfDQnCg2yF+qaKe+t/kykf5ezWDMP19alh8g
	AxJeVFhS4U5s7GwR2rrt9Sm8ToBj0ZcyF/oiwkNQpit+1HLL1UAh9Cl6eYnS7yaeZvAPQ5UUhd/hO
	wCldg/qcfUCL+JS9wmOFDQjpWMP9AWTkfJI6v18qh3s7iz9peB8gJwZzUQYIwaQv6Ze8yWtCuefBP
	c7UmLZnEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwgdO-00073n-OD; Tue, 05 Jan 2021 07:20:02 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwgdL-0006yL-PG
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 07:20:00 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D93kn1BDXzl10F;
 Tue,  5 Jan 2021 15:18:41 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 15:19:38 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 3/6] nvme-fabrics: avoid repeated request completion for
 nvmf_fail_nonready_command
Date: Tue, 5 Jan 2021 15:19:33 +0800
Message-ID: <20210105071936.25097-4-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210105071936.25097-1-lengchao@huawei.com>
References: <20210105071936.25097-1-lengchao@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_022000_135913_3AA4DD4D 
X-CRM114-Status: UNSURE (   9.28  )
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

The request may be completed with NVME_SC_HOST_PATH_ERROR in
nvmf_fail_nonready_command. The state of request will be changed to
MQ_RQ_IN_FLIGHT before call nvme_complete_rq. If free the request
asynchronously such as in nvme_submit_user_cmd, in extreme scenario
the request will be repeated freed in tear down.
Nvmf_fail_nonready_command do not need calling blk_mq_start_request
before complete the request. Nvmf_fail_nonready_command should set
the state of request to MQ_RQ_COMPLETE before complete the request.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/fabrics.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 72ac00173500..874e4320e214 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -553,9 +553,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
 
-	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
-	blk_mq_start_request(rq);
-	nvme_complete_rq(rq);
+	nvme_complete_failed_req(rq);
 	return BLK_STS_OK;
 }
 EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
