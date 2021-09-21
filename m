Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56219C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 17:43:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2222561166
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 17:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2222561166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BKPqu/VaaSHMmKt0Y0lPChru8qh265QcD+5pxii5kAA=; b=G/ngAu43LHaKBB
	m2epftqT5bJKvmmlJWXwtypPWUl46GgtLTgygfKjYyzriAhj5l06RvpqhBixG92jOmTAdP2dLe1z9
	hZb1thlfcMt+bjvbVIU60Im9z8Y0IEIm8azCJbiaa9h1ol3hMmBjoKKW9xo3th7ou2+WQPpGmHByW
	FZL8o35PD+2V+LOJQJcybiaofWqgya76lpkEiBLCJfr1GUMpm3Pw/cjmVfbi2fC0Y5LgEu/C2oCx9
	cM4Srhyvm/RdT1qkEzVlKSS8jdQ95Rcy7pp+nXW53FaTLDPML1VBdIIaOc3r4STtQ5JRHnrmUIUh2
	V+rIrSrL1eQ0wfnEDe4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSjnh-005MNm-8u; Tue, 21 Sep 2021 17:43:25 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSjmz-005M6I-3A
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 17:42:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 27DB6221E5;
 Tue, 21 Sep 2021 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632246159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlZ62pfvjCNeKVIBxmlc+Vwk3tLBeXktgH7BU+PLV5A=;
 b=DFsUz3YKpG5eZnEfFcI6DF3H0hHGd6DLk4oQ8EWJP4bAlcR2tjWdP+dhbbycu/LB8d/UeX
 nlUTibKV8Pz18Rl6Rkf7kx6fxwDDWt0MAXYqp3y31vDyjEKfyYG49ojT80X04DjXcRC1Jz
 E4hDlxlENZg+xVJ0Cs0U55sMgn0lJS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632246159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlZ62pfvjCNeKVIBxmlc+Vwk3tLBeXktgH7BU+PLV5A=;
 b=h2NPWq4mbbcc8oHcVvI5pOllmhtyqt96Le4QKz7UJ9u/hsnr86tlhR9bVem/oy9pwjoHD6
 gkSIvPbfUMt90OAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id ECC36A3B88;
 Tue, 21 Sep 2021 17:42:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id D89EB518EAA5; Tue, 21 Sep 2021 19:42:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvmet: switch check for subsystem type
Date: Tue, 21 Sep 2021 19:42:28 +0200
Message-Id: <20210921174230.30552-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210921174230.30552-1-hare@suse.de>
References: <20210921174230.30552-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_104241_347595_D31BC7B7 
X-CRM114-Status: GOOD (  14.60  )
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

Invert the check for discovery subsystem type to allow for additional
discovery subsystem types.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/admin-cmd.c   | 4 ++--
 drivers/nvme/target/core.c        | 6 +++---
 drivers/nvme/target/fabrics-cmd.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8546bae5244d..e98f3e277571 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -374,7 +374,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->rab = 6;
 
-	id->cntrltype = ctrl->subsys->type == NVME_NQN_DISC ?
+	id->cntrltype = ctrl->subsys->type != NVME_NQN_NVME ?
 		NVME_CTRL_DISC : NVME_CTRL_IO;
 
 	/*
@@ -1011,7 +1011,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_cmd(req);
-	if (nvmet_req_subsys(req)->type == NVME_NQN_DISC)
+	if (nvmet_req_subsys(req)->type != NVME_NQN_NVME)
 		return nvmet_parse_discovery_cmd(req);
 
 	ret = nvmet_check_ctrl_status(req);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 88ed746c675f..873b02d8c31c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1140,7 +1140,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	 * should verify iosqes,iocqes are zeroed, however that
 	 * would break backwards compatibility, so don't enforce it.
 	 */
-	if (ctrl->subsys->type != NVME_NQN_DISC &&
+	if (ctrl->subsys->type == NVME_NQN_NVME &&
 	    (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
 	     nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES)) {
 		ctrl->csts = NVME_CSTS_CFS;
@@ -1278,7 +1278,7 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
 	if (subsys->allow_any_host)
 		return true;
 
-	if (subsys->type == NVME_NQN_DISC) /* allow all access to disc subsys */
+	if (subsys->type != NVME_NQN_NVME) /* allow all access to disc subsys */
 		return true;
 
 	list_for_each_entry(p, &subsys->hosts, entry) {
@@ -1411,7 +1411,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	 * Discovery controllers may use some arbitrary high value
 	 * in order to cleanup stale discovery sessions
 	 */
-	if ((ctrl->subsys->type == NVME_NQN_DISC) && !kato)
+	if ((ctrl->subsys->type != NVME_NQN_NVME) && !kato)
 		kato = NVMET_DISC_KATO_MS;
 
 	/* keep-alive timeout in seconds */
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 822601103f29..d1e179959768 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -222,7 +222,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	}
 
 	pr_info("creating %s controller %d for subsystem %s for NQN %s%s.\n",
-		ctrl->subsys->type == NVME_NQN_DISC ? "discovery" : "nvm",
+		ctrl->subsys->type != NVME_NQN_NVME ? "discovery" : "nvm",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
 		ctrl->pi_support ? " T10-PI is enabled" : "");
 	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
