Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518F6C0218C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 11:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sfldtdBowwuZ1WlfnVT6zw7gCfLF13vnxjNp/kE4YhM=; b=ZbRGyCkPnXKL3ktkr3ebyK1Y7v
	P+8OcakVh30tAuc+z6mNF+YSOHMOEZ/3Yw+rY/gvYCLi++uF2/Z23LGJGJhhCedvK4A5p5hevcLrn
	wfgRHRiZwBYb0LT4d2GCNlmYqyl/NoaQfZxmSc6q+8UPxRhcTrC/+nmzK4jIHhGmyfNPIwMTYcuqu
	7c9f3fDFTGeghfA1zgZ1KpUKijUatfazSRsrp3WVWyo85nkvt5VAIZr/McP3bc8J33BWIHjYyF66M
	sMAUV25qFpi7kvpAexubnlI9ZW/I9E+do5FcXSkSJFtE9efDGgk2kpe0lE6CiFRQYaxIHYdMW7SOD
	kdodzP7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIA9-0000000EbM7-3qY1;
	Fri, 24 Jan 2025 11:47:49 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIA6-0000000EbKI-2e4e
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 11:47:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9A75EA40084;
	Fri, 24 Jan 2025 11:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AD0C4CEDD;
	Fri, 24 Jan 2025 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737719265;
	bh=j8czBvdsPExltgorRUN5CGIXDAj+mQmUAP3WGcY7xsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPXxYMNmae/Yhc+OX6TcJXM4O3vpH2YDkN98NIyTqC0NyBuvhIH5AjLEa/KXycWhB
	 UCNvVv1xz7CPIjRs9Xc46KQIzu+K2JPCWff6pM+Eq+vzQny7CxyUVsZbBEVtYPbrZQ
	 BGY9ZtC3snqdFinP9pTXyFd8OC230U1vBe5mUlrwOLGqOd61w4nH/1FkJbY/QCuH2V
	 Of8AJgtyhMj2TePs1vIFGI1MM2nw2eJLRU3xVhy30Jr9zLkG7IhPNIELjqIQNgrNXB
	 fMQDRVix8qUUx8NN5I/25bT/yDhSGoEALOBIUDZjEB5f+iu4PqiPcy+WiUogEhzP4D
	 Hk6CNU11HmclQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvme: Do not re-authenticate queues with no prior authentication
Date: Fri, 24 Jan 2025 12:47:38 +0100
Message-Id: <20250124114738.115882-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250124114738.115882-1-hare@kernel.org>
References: <20250124114738.115882-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_034746_738902_4BE9D725 
X-CRM114-Status: GOOD (  13.88  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@kernel.org>

When sending 'connect' the queues can figure out from the return code
whether authentication is required or not. But reauthentication doesn't
disconnect the queues, so this check is not available.
Rather we need to check whether the queue had been authenticated initially
to figure out if we need to reauthenticate.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/auth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 000c0a4197ba..1a304eb78809 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -31,6 +31,7 @@ struct nvme_dhchap_queue_context {
 	u32 s1;
 	u32 s2;
 	bool bi_directional;
+	bool authenticated;
 	u16 transaction;
 	u8 status;
 	u8 dhgroup_id;
@@ -927,12 +928,14 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 	if (!ret) {
 		chap->error = 0;
+		chap->authenticated = true;
 		if (ctrl->opts->concat &&
 		    (ret = nvme_auth_secure_concat(ctrl, chap))) {
 			dev_warn(ctrl->device,
 				 "%s: qid %d failed to enable secure concatenation\n",
 				 __func__, chap->qid);
 			chap->error = ret;
+			chap->authenticated = false;
 		}
 		return;
 	}
@@ -1021,6 +1024,14 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 		return;
 
 	for (q = 1; q < ctrl->queue_count; q++) {
+		/*
+		 * Skip re-authentication if the queue had
+		 * not been authenticated initially.
+		 */
+		if (!ctrl->dhchap_ctxs[q].authenticated) {
+			ctrl->dhchap_ctxs[q].error = 0;
+			continue;
+		}
 		ret = nvme_auth_negotiate(ctrl, q);
 		if (ret) {
 			dev_warn(ctrl->device,
@@ -1074,6 +1085,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		chap = &ctrl->dhchap_ctxs[i];
 		chap->qid = i;
 		chap->ctrl = ctrl;
+		chap->authenticated = false;
 		INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
 	}
 
-- 
2.35.3


