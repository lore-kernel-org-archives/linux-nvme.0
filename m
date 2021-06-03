Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4B0C47099
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:12:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A242B61407
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A242B61407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tHnT6DxJX9Jlibd/cphu2T9o5kRaknkzGuCJWpesFZw=; b=4P0bCjV+lwtWs4
	g4n6DKqfIH9VnhfQAJ9U90UtgW8uU4wiXXZZVsF9bgu1qGBSDgwEpdoKhPe3IZZ31UOYb8Q/mKCXo
	HBLzlxMFPqT5qvqSwEfVIYhOyQXf1qUigqnRiaOCBzboLVJZ8jpxQg/GaEDNr8ByefPZnm0nbAb6K
	eQDhN2jjLYndpvaRoyVT4GVIx3JASLRsKUKWARw7ZxsHPJj7r2hWzBbUx1r3raAfq2Ow+QWxv6K6p
	QEkmP6UrRF/l783cIOfv/3u7704jgQpsqAlBvYlxF1rWeXaBvzyMjt2Q0wNn8BulEBU92J+7PlDMP
	k7PducBs5aY+c1A+mlYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loqtb-009mOO-54; Thu, 03 Jun 2021 17:12:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loqqJ-009kUc-Pk
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 17:09:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78387613F9;
 Thu,  3 Jun 2021 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622740155;
 bh=k9Gy9yU2Lau7hfNyTvlypj7xK92azCdmisxj3CcIxh4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dc7ZqvEfYdaAZWEYnpjnkvQVcHeY3TOMr3eUDb/lohswu20Py/n8uaYaRDVjXk+Xa
 rOWcCcAUwo8eY/eDC00E/GUpks/RPN/xlcKVr3poUQ2E6t/XrmR9gKG06T/b21W+uX
 AixNFr6N7YPQwGCzwsWymOfhHRBkWI5vDVaK7m8FDVfCR0m8Ol56uqMq24M9D0HWtS
 ud7HSUOjmmdBc/+66sCRqJx0M4zAi83daz+qLsCkk6EQXFTPLsDmZaDM0ppWMh9NFV
 euIuQLujVBPWMEWyRR1EC10KOVolPykkewuki2tgoKA05WM2NOoT+U289KmzJfdkrA
 95+8wABBLTMAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 37/39] nvmet: fix false keep-alive timeout when a
 controller is torn down
Date: Thu,  3 Jun 2021 13:08:27 -0400
Message-Id: <20210603170829.3168708-37-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603170829.3168708-1-sashal@kernel.org>
References: <20210603170829.3168708-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_100915_919101_C7060882 
X-CRM114-Status: GOOD (  14.76  )
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
index 46e4f7ea34c8..a65a4a810654 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -379,10 +379,10 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
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
@@ -792,6 +792,13 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
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
@@ -942,7 +949,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	}
 
 	if (sq->ctrl)
-		sq->ctrl->cmd_seen = true;
+		sq->ctrl->reset_tbkas = true;
 
 	return true;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ea96487b5424..4bf6d21290c2 100644
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
