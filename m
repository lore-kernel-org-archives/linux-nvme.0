Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54235C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 15:22:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243CF60EE3
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 15:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 243CF60EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8e5gq3PKXlKMfEqOqPkCSRg3qfVHtYbl//OykjQ3S8=; b=NMUMUUX5A7zypLbPt1xArnK/S2
	l9dSzzWVPL3LCBT6/24BIhtNFl6h72C3fK2UM/XaT3t4J0LLgVFLzf/XDBRA/rdBda2SZ+69TbL5u
	AxCamMxwU/ceLh932diAI57jK1jHcxWM4e+rexGqHuSJOjkLFajnB1ZrnUtlfCGiU0W6k0Vlgr7w+
	i/v0SPNZ564+9jfulJRBRLKtAh0f1FF2Q8dZStvUV0eiBXhGpHVnBGgQuMsmNK1aMsghmIKNQWxps
	a+8jw9JIy0W0VxlOQxRL8DaJ3JZa7hurRvqvJ5YHx5zfxt83Rsfa18Bwxj5bx8yAOmJv57QPDfQn7
	9+1cquFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcUSv-00GHrj-KS; Mon, 18 Oct 2021 15:22:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcUSM-00GHeV-Vs
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 15:21:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6A57C1FD6D;
 Mon, 18 Oct 2021 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634570499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8e5gq3PKXlKMfEqOqPkCSRg3qfVHtYbl//OykjQ3S8=;
 b=1HqMm4WDr8npwUcbFYVd9k7Wtmq7INP4PnM8kH9b/rs6zh1KYlgzmSl+Twv/x72fhgMaiE
 xGB0RU5bSzrnKv9aExlLRaVg7e8RB6KVb7ejYUIEBrS2SHXKX2dTnAU3LBmejr9KItI/WH
 a7hf39i9/aC4d/lpJoSpX9UPIMO9l30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634570499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8e5gq3PKXlKMfEqOqPkCSRg3qfVHtYbl//OykjQ3S8=;
 b=3M/5GEC+2tL1iASLzk0YcPkDYg3Vt2Fxbm+EVI7Yt7SOgIwwlu3O8rbAAq5RNkrMCkDqRf
 CCbo1B3fXNta1nAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 43143A3B94;
 Mon, 18 Oct 2021 15:21:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 2AD86518FBC3; Mon, 18 Oct 2021 17:21:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvmet: register discovery subsystem as 'current'
Date: Mon, 18 Oct 2021 17:21:38 +0200
Message-Id: <20211018152138.2128-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211018152138.2128-1-hare@suse.de>
References: <20211018152138.2128-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_082143_216305_41F581CA 
X-CRM114-Status: GOOD (  12.43  )
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

Register the discovery subsystem as the 'current' discovery subsystem,
and add a new discovery log page entry for it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/core.c      |  2 ++
 drivers/nvme/target/discovery.c | 13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d844fb9ef2eb..fd3d01b4b3d1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1541,6 +1541,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		subsys->max_qid = NVMET_NR_QUEUES;
 		break;
 	case NVME_NQN_DISC:
+		fallthrough;
+	case NVME_NQN_CURR:
 		subsys->max_qid = 0;
 		break;
 	default:
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 7b360f8d07e9..a2f08c49f07c 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -146,7 +146,7 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
-	size_t entries = 0;
+	size_t entries = 1;
 
 	list_for_each_entry(p, &req->port->subsystems, entry) {
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
@@ -171,6 +171,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	u32 numrec = 0;
 	u16 status = 0;
 	void *buffer;
+	char traddr[NVMF_TRADDR_SIZE];
 
 	if (!nvmet_check_transfer_len(req, data_len))
 		return;
@@ -204,14 +205,16 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		goto out;
 	}
 
+	nvmet_set_disc_traddr(req, req->port, traddr);
 	hdr = buffer;
+	nvmet_format_discovery_entry(hdr, req->port,
+				     nvmet_disc_subsys->subsysnqn,
+				     traddr, NVME_NQN_CURR, numrec);
+	numrec++;
 	list_for_each_entry(p, &req->port->subsystems, entry) {
-		char traddr[NVMF_TRADDR_SIZE];
-
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
 			continue;
 
-		nvmet_set_disc_traddr(req, req->port, traddr);
 		nvmet_format_discovery_entry(hdr, req->port,
 				p->subsys->subsysnqn, traddr,
 				NVME_NQN_NVME, numrec);
@@ -389,7 +392,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 int __init nvmet_init_discovery(void)
 {
 	nvmet_disc_subsys =
-		nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME, NVME_NQN_DISC);
+		nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME, NVME_NQN_CURR);
 	return PTR_ERR_OR_ZERO(nvmet_disc_subsys);
 }
 
-- 
2.29.2


