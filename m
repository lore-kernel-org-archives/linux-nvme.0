Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628AAC5517A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE84A2078D
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xMDMbPc/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HUwLoS6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE84A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QyqJcwtMnnzaLq+LcZHAZQ07ZiSBKJmkfTHB2WNDtbg=; b=xMDMbPc/YozQDoQTcBd8rBjly
	tGpEeEZOMY95lKoO4bCsT86MCky6QWH7ed7/A2PRKiGk4YAHd7PR7K8aoEEk/Y3qLGNlH9qX9ObhP
	NQWkRHfuNtOdoPMgFFo0w7AmP4TBOd3AuTk9T5o+d5hCKV1oxUhew66VoAfO/W7Uw/mofzdZWMXFQ
	yTp0O7fHRhqxIClsGtIO2INCeo2kbk8oQvw5igm64QD8GWpnvfvAJwY9DS1Kg3wwVTtzpyb5CG5eX
	QoVWwS/5UV42pSU5CNoY5/bFoHaE0Ci+mArZ7i2zA7OnQvxAjqV96z1csoiOs2rcsj+jNfbkkyuHt
	4VNFLzmrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcHbk-0001yN-OU; Tue, 10 Nov 2020 00:34:00 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcHbh-0001xe-MH
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 00:33:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604968437; x=1636504437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e+p1Sbgj1mqylXAMY29UxGh4KGxJrL5TxAJiwOroD+A=;
 b=HUwLoS6OKVx0vTP7K4k757R1nmdJ7N3WTGYWx1f4de1YgCqpJSkMpLsR
 KFmMeJM51nFXp+XVlmwTXtqgRrhf2yvFSfoFGX9MopSjGKvrDO4oSGhBK
 3RkINBRWl8AalaOdNaxud5T7ea372bScyzJRod5m+2v9Lq84om12kb63U
 XEZtgzOcTAp1okTLabl4wPtDAtnGR+njXHnnkzV3nBFVo1uDjOW8VNeOv
 IrYQe5VPy5wmJqhG+JNil7z9ejdTA+hpTM/kqR4MB34UMzRFgR8wQnqHP
 1f0EIYRz0+Pa2Bzj/Usq7CbB2zQz1CGA5Or0oMS0AQvCTeL+jqs83ni/W g==;
IronPort-SDR: J6xBf8EPt4wy4JAi0OTMWpNo6dJHxUsox8DO0BbD+73zXcDw9D42HwX3fNRw8QKPR0zkCikj5Y
 B5qRluovkE/keHf3aEjxp0HzVMh/Lcz5Q6MHhEESQLcWDwmkr7o1abolKYD/ppaQf6BhNBSP5E
 +sWxtZ6cwEE3pfQOW7hlFVrBBJ6dHpVgUC5CtAyh23DW3utASG+SRQeyKJ6JW/EcOCXSXEvfHf
 KvpOYdDKGJd8hgjb7DpY0gOeFEGarXSGMj9L9DaJP5pVs6YlghaSstM2nijcD6aXIm9XYH6k08
 Nvw=
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; d="scan'208";a="262236135"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 08:33:54 +0800
IronPort-SDR: TejwyPp2l8/9euIKbb96oa9qzTkacpvp93nDb9TK/grB9avUUA/cQnGRDE4A2xeuIK5wtbuJvk
 sjPmDMJmmwPORoAanbJg3o1BRSYdAnkcINQChZQbQvWbPgbMWdlRptEDEN8wpwzPXBf7Up593p
 ctEy/0t50oWXT9ptiuxqZay3g4Vp6EJmyAh3acdufslQFB/YdSBe08y468WPgsmqIEJzFykY7a
 2EpJnlmczjygXwDULJZ6ZRdqIPXFQ1vxVZ0dryW31IGlkx+ZaZ3qis7OBo5JXj34QOkrokH6Dj
 +D6G5ezwBihgGG+a/OHD1gKI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 16:18:42 -0800
IronPort-SDR: zRjuEI3euDgNK+1Q4sRr5sKaNu/6/2wxV+FijvA7p0fksnUTVMZ9rhmTtTJLIK8OWkgvyFc+dw
 5vpPUl1woMUzpcaiXc68oDBsm/pm4OaubbVsDScGT0YlQioGlm3SSjmq8p38nA6IbplIvsg56H
 RFpmG8HcWrraATFR9KUZ3b5Gk/LKxZ5B2VYMHZWlBIs/C2PbIaOBxU2RL8r8cXjCaymZTqu6iX
 ZkM0+WqkmahAZm06raD+u5XGBUCXPDG+xOfBAgdGNxed+In6rhcm/S1yfkZIO5OhijkG0uEZs4
 LHc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 16:33:54 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 1/4] nvme: centralize setting req timeout
Date: Mon,  9 Nov 2020 16:33:42 -0800
Message-Id: <20201110003345.8191-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110003345.8191-1-chaitanya.kulkarni@wdc.com>
References: <20201110003345.8191-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_193358_477586_15CEEC08 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvme_alloc_request() is called from different context
(I/O and Admin queue) where callers do not consider the I/O timeout when
called from I/O queue context.

Update nvme_alloc_request() to set the default I/O and Admin timeout
value based on whether the queuedata is set or not.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c     | 11 +++++++++--
 drivers/nvme/host/lightnvm.c |  3 ++-
 drivers/nvme/host/pci.c      |  2 --
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b01afcb7777..97348b1ecfd6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -533,6 +533,11 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	if (IS_ERR(req))
 		return req;
 
+	if (req->q->queuedata)
+		req->timeout = NVME_IO_TIMEOUT;
+	else /* no queuedata implies admin queue */
+		req->timeout = ADMIN_TIMEOUT;
+
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	nvme_clear_nvme_request(req);
 	nvme_req(req)->cmd = cmd;
@@ -901,7 +906,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	if (timeout)
+		req->timeout = timeout;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -1071,7 +1077,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	if (timeout)
+		req->timeout = timeout;
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8e562d0f2c30..88a7c8eac455 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -774,7 +774,8 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		goto err_cmd;
 	}
 
-	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	if (timeout)
+		rq->timeout = timeout;
 
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..76465d335924 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1310,7 +1310,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		return BLK_EH_RESET_TIMER;
 	}
 
-	abort_req->timeout = ADMIN_TIMEOUT;
 	abort_req->end_io_data = NULL;
 	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
 
@@ -2223,7 +2222,6 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = ADMIN_TIMEOUT;
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
