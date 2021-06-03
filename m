Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD02C47096
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:09:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02C661408
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02C661408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4zkBQyFncPmbzc17HfK24kWLR5ILjmQRpxsDVtu0oP8=; b=25i8r4pTrfcIzN
	GgT7UOPbTvM0DTuq3cLqA1OPyI4AULMTHDcZH4NnH3oCSxoHxFmGRrJVdbKGCvvyXmdvKU2ielKtk
	iqX8yxCuxdUIlSIyAJy2lV91cPhI3JpBH45BYcW2zacqXA/UnBkNwzzdj6glFVfRmNJZiv/xwdEgu
	NuuqBq5iqnZkfsfJqjG2Z2pOu1ppLHTAH4OCmAv6WFc7FGpwXwrK/GaLh2NRw2vEeGeyLl8LBIqgF
	ymN/U0eI6WfiT6vVY2w0p+OVg6zn9uEZMGSqv6rXsPvjvIl5BhlHNbmkZxOJZJIUe1m10PU66SckO
	WU0UORvQlP+H/VhYkQtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loqqT-009ka4-RP; Thu, 03 Jun 2021 17:09:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loqpW-009k4i-3x
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 17:08:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D21F3613F5;
 Thu,  3 Jun 2021 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622740105;
 bh=dlgU04bR/sbF/+Ky2teH1Bjfg0yElnMFnXuEDB5oDSg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HGJjcXxCxI1WZyaYmi63T26mxnM2NixfEM165zl+ORZjn6+jS4BGnncb9MYpOlqpf
 iLws204RJy2ugHycr4ucol6TnKB7JlTbi9XI04lOfiI/MKfGnS9fFfubc4F9wVXMvb
 su6crFC1rWfgpA0n/V0BdukAe5VzvXJdkgIrhnx9t8zSQbiDPfD92h0egC4oLqCxha
 gboBWCYCbp+B0iq3akM2+3ZmD7Y3zMBVBq9q60yIxTwCZrSKv1hk2x3SQYqPjjrxsO
 NfAWOHXh6RCz1dIk36M14nBXzzHenFoXHQQHCOvf3M4L5iFVX+Ju0Of9iZC9p4DHvk
 6BvU7I3SXbJng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.12 41/43] nvmet: fix false keep-alive timeout when a
 controller is torn down
Date: Thu,  3 Jun 2021 13:07:31 -0400
Message-Id: <20210603170734.3168284-41-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603170734.3168284-1-sashal@kernel.org>
References: <20210603170734.3168284-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_100826_221040_2C9E5D80 
X-CRM114-Status: GOOD (  14.86  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit aaeadd7075dc9e184bc7876e9dd7b3bada771df2 ]

Controller teardown flow may take some time in case it has many I/O
queues, and the host may not send us keep-alive during this period.
Hence reset the traffic based keep-alive timer so we don't trigger
a controller teardown as a result of a keep-alive expiration.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c  | 15 +++++++++++----
 drivers/nvme/target/nvmet.h |  2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 348057fdc568..32880c38ec69 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -388,10 +388,10 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 {
 	struct nvmet_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvmet_ctrl, ka_work);
-	bool cmd_seen = ctrl->cmd_seen;
+	bool reset_tbkas = ctrl->reset_tbkas;
 
-	ctrl->cmd_seen = false;
-	if (cmd_seen) {
+	ctrl->reset_tbkas = false;
+	if (reset_tbkas) {
 		pr_debug("ctrl %d reschedule traffic based keep-alive timer\n",
 			ctrl->cntlid);
 		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
@@ -804,6 +804,13 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	percpu_ref_exit(&sq->ref);
 
 	if (ctrl) {
+		/*
+		 * The teardown flow may take some time, and the host may not
+		 * send us keep-alive during this period, hence reset the
+		 * traffic based keep-alive timer so we don't trigger a
+		 * controller teardown as a result of a keep-alive expiration.
+		 */
+		ctrl->reset_tbkas = true;
 		nvmet_ctrl_put(ctrl);
 		sq->ctrl = NULL; /* allows reusing the queue later */
 	}
@@ -953,7 +960,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	}
 
 	if (sq->ctrl)
-		sq->ctrl->cmd_seen = true;
+		sq->ctrl->reset_tbkas = true;
 
 	return true;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5aad34b106dc..43a668dc8bc4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -166,7 +166,7 @@ struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
 
-	bool			cmd_seen;
+	bool			reset_tbkas;
 
 	struct mutex		lock;
 	u64			cap;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
