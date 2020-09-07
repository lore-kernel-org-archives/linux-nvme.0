Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEDFC433E2
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 17:45:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EC2206E7
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 17:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PIB3UeJj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkYeCYw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EC2206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nC+zJm4SYClbXLW7vWza2T4Vg4r2DoWK5XZtFxGQNhY=; b=PIB3UeJjif89bv+VkMcG1tuS1
	bVtCrbeK8q1tbbrRfehTOt/wcQ0ramyhFcG6c5xn6FD11S20Q8k3htQanj/5mGJvfGQIj2vtuTY61
	UQgmvAMx+u942Z2TPiq3/Nag5Vua/fhPjkkblSnQQkIP+4RAu4XvLpWOh1g1U05HlW34Rl9irnLZ5
	73GPb/ToCY+fAaGI5NNNmFhX7auQBeAiesl2F+eHMndtg6TTesasOrj65QGzQs7dXAHhv56CPkXyn
	9S1A3CaRJFsRplsop2chHmA6Y+2KBGSwqEeTF+PTe1mQIPPPjaK02+2riAVMK1+QZMJ/K93DdOBOZ
	VMKyx23Hg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFLCp-0002tc-0j; Mon, 07 Sep 2020 17:45:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFK5f-0005jg-GO
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 16:34:08 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4182821D24;
 Mon,  7 Sep 2020 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599496438;
 bh=1KLccYs4HIJBd2LVQIYIdYFq4wKOPqgFe98sjpvZdqE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AkYeCYw3BSf8vV31KVT6UsBHN3YSxY4PmY88lN61WPEvQfBfMG5wr53jBaE7KC9J7
 PQv7eA57A/SXUyFIt6Omt1vILvhV1QYpicZy13CVmTYjXj7jLmoceTaUF1OFG8Lt5+
 mkHZFXpXywaE5+H97kh1PhKnthaunh8V+C8fkOUE=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 22/43] nvme: have nvme_wait_freeze_timeout return
 if it timed out
Date: Mon,  7 Sep 2020 12:33:08 -0400
Message-Id: <20200907163329.1280888-22-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_123359_627512_31C68098 
X-CRM114-Status: GOOD (  14.18  )
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
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 7cf0d7c0f3c3b0203aaf81c1bc884924d8fdb9bd ]

Users can detect if the wait has completed or not and take appropriate
actions based on this information (e.g. weather to continue
initialization or rather fail and schedule another initialization
attempt).

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ff5681da8780d..07c881fe34bb3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4148,7 +4148,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
-void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
 
@@ -4159,6 +4159,7 @@ void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 			break;
 	}
 	up_read(&ctrl->namespaces_rwsem);
+	return timeout;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 056953bd8bd81..2bd9f7c3084f2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -485,7 +485,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
-void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
