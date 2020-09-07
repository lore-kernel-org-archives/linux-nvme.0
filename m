Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB3C2BB84
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:33:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003102193E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="COgdf+h2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M61d7zNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003102193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1KRwyzaurdVBUQW9m7I9Gq0NB8V/c/VbT8FHW/NLn/s=; b=COgdf+h2F++6INHOqEsgoJdvi
	H16SzyE+ZD2GyqCYRNQNh+ieJ06sviVyAMxbkeLKE9ii5TKbVaNgP6NSXZVjcLMdRdRuq7X+28Lb8
	B1nzrJI49tAy9AiUhcByESdUlPdXFBq1vQZTyM+5XU9G217+BiVh4sz4r/PivPu6gsQcYs4JwrhoR
	JiBaUsAcRH7QECKffRNmm/gF4e5hT0jVDxt0YWuD4X824jDusOS43pmGMNIjDQPWJMtV1mxdfH6Bw
	vbn/HFf2MRmxoesi/Kw7Dsh2skwug1rzAW+Iz+HrLYz338wnqdoGExTrXEI6osNyz1u2vzRreqY8b
	KY2Zus8JA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFK4m-0005Jf-E5; Mon, 07 Sep 2020 16:33:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFK4g-0005H6-QN
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 16:32:59 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9167C217BA;
 Mon,  7 Sep 2020 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599496378;
 bh=Nj/GzaD1UpOXnjHdTpNAtZUw2gLD8Wl7Igk/DA9JABQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M61d7zNxL3MarHhw7xd/yduCGRf2gkKeAWENhVdTsc7ynGhxkXY9kfCYnyndB52nQ
 49VzH0J5EWdtLh/JvHN+SIkGEr2o7CWrwmsP5CCsc8dDekXYVpGNaherxg4hvWL7Xt
 KBEkUrdhfezuGUPzxHgcmnJMMRHSBwabpGGxtdHQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 29/53] nvme: have nvme_wait_freeze_timeout return
 if it timed out
Date: Mon,  7 Sep 2020 12:31:55 -0400
Message-Id: <20200907163220.1280412-29-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_123258_976694_014AD3E1 
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
index f38548e6d55ec..3770020dd8492 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4287,7 +4287,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
-void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
 
@@ -4298,6 +4298,7 @@ void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 			break;
 	}
 	up_read(&ctrl->namespaces_rwsem);
+	return timeout;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e268f1d7e1a0f..c053aedbc55db 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -538,7 +538,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl);
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
