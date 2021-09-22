Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95432C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:38:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5435C60EC0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5435C60EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y2vQSK/wMkUHDXjhI+hk+x2jhrDtyDf1gXeMH4qBgZE=; b=4ecXnZII8NizFL
	elB7vEVmGfpZkJDGQS41/Jkq9nGrl9WwZD7ZVPweOVleoQuw37kYouKWIg7eOyNFm7+KqEQ/Ho6R3
	UuNUcbkLz+ghe9b6osaHElWJ0yzUJXlodQZe84b7ZOaEHEvNUFRtILT87wvVOpaIHTJCiL30+CFsA
	Y7kjGEve93y+6TWIwUBkMnSKiGD5ctYJu5qXDhXgepT6CaocIxhk2F30P1j2eWwa4SdbQcvWa32di
	5B6bo1PdvTrE0AizHbj2cGcuE6V6zeSeatocbM9QAHNcx2UxjezEMWYISi0oPkfO31/ziJ/WflF4C
	C+06BU1YaQrnm/R1mj2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSvtB-0076Lq-CD; Wed, 22 Sep 2021 06:37:53 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSvqq-0075bE-Ry
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 06:35:32 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 591FA200E3;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632292527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9p1c6dYuFtzRxNppudupZ125DDB+CspOrSdTGjjYxXU=;
 b=aBRVTbw6XMy+yUqNVWxCHehaPXZjKnU2oBqsNpzzAuRmPv43X0xsMnkISP1nyzSZR0+wNn
 hyB0iq8isic4ANsXItApXxe+18luJhvd535qVOhDUxQGmFZDFMQJm+kzCb3bYNNpfgQUV0
 UAgFwsBeEwb/krsUa/ODeNY6x5B19pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632292527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9p1c6dYuFtzRxNppudupZ125DDB+CspOrSdTGjjYxXU=;
 b=dxHfG2RMEqONrXgpmSRwZzDagRudFaD7hnJgRsdFTxp2wMkKhwGHjNHgA7VyYq9B658mZd
 z3v/F+vymbcxLwCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0AE8BA3B9D;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id ECC4E518EAF2; Wed, 22 Sep 2021 08:35:26 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/7] nvmet: add nvmet_is_disc_subsys() helper
Date: Wed, 22 Sep 2021 08:35:21 +0200
Message-Id: <20210922063525.143045-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922063525.143045-1-hare@suse.de>
References: <20210922063525.143045-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_233529_156200_213551BC 
X-CRM114-Status: GOOD (  15.33  )
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

Add a helper function to determine if a given subsystem is a discovery
subsystem.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/core.c      | 6 +++---
 drivers/nvme/target/nvmet.h     | 5 +++++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index aa6d84d8848e..b653ea4244fe 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1008,7 +1008,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_cmd(req);
-	if (nvmet_req_subsys(req)->type == NVME_NQN_DISC)
+	if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
 		return nvmet_parse_discovery_cmd(req);
 
 	ret = nvmet_check_ctrl_status(req);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 88ed746c675f..61ceb42717f1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1140,7 +1140,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	 * should verify iosqes,iocqes are zeroed, however that
 	 * would break backwards compatibility, so don't enforce it.
 	 */
-	if (ctrl->subsys->type != NVME_NQN_DISC &&
+	if (!nvmet_is_disc_subsys(ctrl->subsys) &&
 	    (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
 	     nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES)) {
 		ctrl->csts = NVME_CSTS_CFS;
@@ -1278,7 +1278,7 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
 	if (subsys->allow_any_host)
 		return true;
 
-	if (subsys->type == NVME_NQN_DISC) /* allow all access to disc subsys */
+	if (nvmet_is_disc_subsys(subsys)) /* allow all access to disc subsys */
 		return true;
 
 	list_for_each_entry(p, &subsys->hosts, entry) {
@@ -1411,7 +1411,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	 * Discovery controllers may use some arbitrary high value
 	 * in order to cleanup stale discovery sessions
 	 */
-	if ((ctrl->subsys->type == NVME_NQN_DISC) && !kato)
+	if (nvmet_is_disc_subsys(ctrl->subsys) && !kato)
 		kato = NVMET_DISC_KATO_MS;
 
 	/* keep-alive timeout in seconds */
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7143c7fa7464..93a86d6053ef 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -576,6 +576,11 @@ static inline struct nvmet_subsys *nvmet_req_subsys(struct nvmet_req *req)
 	return req->sq->ctrl->subsys;
 }
 
+static inline bool nvmet_is_disc_subsys(struct nvmet_subsys *subsys)
+{
+    return subsys->type == NVME_NQN_DISC;
+}
+
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
