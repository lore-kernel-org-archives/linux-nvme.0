Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41381C43381
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 12:51:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12F264F2F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 12:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12F264F2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3dlT0r9TRmlmoMJ+o+5/XGy6EQRQSRjUHvx8k9++ooc=; b=LKA4KYagNbI29stKD1/ns0y20
	W1kxScT0aNlDAf+J726tHkPajLZLmaD6XSkkCrDi/BAXiydgSL4/BHRbh/P3AxtVRzWRN9fH1bdaC
	Z5u//dB3WoV5I8wY0pBFp6OTkl8i7/GnBwXgZt/2SvGX0wWFHHRi0c4XbWbDC9wxJuVx+e31D8xPV
	TqtH02jb5lgcng11Trep/kmZdrYR5Z1SC+npJHY57BXY+FtW3c6zbDKxHSyR1ahl34kwmNpLLUiCq
	0FlYpzQGQNpx/P/SkkCmaN11T4KaqSlmhcJLl0eJevREQgmEmscfpNvjEdrMMdEIzE/LimVd3o3a+
	P+ty4+zDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEtdZ-0002FP-1S; Wed, 24 Feb 2021 12:51:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEtdX-0002EF-82
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 12:51:28 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B48D564EDD;
 Wed, 24 Feb 2021 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614171086;
 bh=n2t/uc5ZxGBO0vRl39m8JivSlLwT/t9BtbiI+dqzzGA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WNfpHJmrvRnPTGnftJV+dPSCkfu0zdQnapL6zjhyerVgjpbs7p8VuNWOwxkZjNctX
 oPaXjNnufe/hmQlNYEblw8+yFOEl8QIYhnAYfvvrfASe9SmUHd59UIm65/DzJCwAn/
 XgJ0oirNdz2cIajXwWHST2shK/rv4+fJEfaMLL8FHtwJ3Zir3PFx/wvEMAuZ1tLzs/
 +KJafWij3WzrFEqTtU6W76fxa6iuyKSSeMpRBzxcz6N87O670icoIwgifZZXRG9WPD
 QCYXC41hkn1ED8Cz5kCHFH2If1EbGbTY4kSBBgM8eFDXbdGfEpqzOt7i7ux9I62pi3
 EGvXyVxUMBNCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 44/67] nvme-core: add cancel tagset helpers
Date: Wed, 24 Feb 2021 07:50:02 -0500
Message-Id: <20210224125026.481804-44-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125026.481804-1-sashal@kernel.org>
References: <20210224125026.481804-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_075127_406067_D8F40737 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

[ Upstream commit 2547906982e2e6a0d42f8957f55af5bb51a7e55f ]

Add nvme_cancel_tagset and nvme_cancel_admin_tagset for tear down and
reconnection error handling.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 20 ++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f13eb4ded95fa..129e2b6bd6d3f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -371,6 +371,26 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
 
+void nvme_cancel_tagset(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->tagset) {
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+				nvme_cancel_request, ctrl);
+		blk_mq_tagset_wait_completed_request(ctrl->tagset);
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
+
+void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->admin_tagset) {
+		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+				nvme_cancel_request, ctrl);
+		blk_mq_tagset_wait_completed_request(ctrl->admin_tagset);
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 88a6b97247f50..a72f071810910 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -576,6 +576,8 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 
 void nvme_complete_rq(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
+void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
+void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 bool nvme_wait_reset(struct nvme_ctrl *ctrl);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
