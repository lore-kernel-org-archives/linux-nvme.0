Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D448AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Mar 2022 13:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y5b537b4Yg+sW/PC7Y5qCEju6gJr94gI5OxbQIGlV6k=; b=gL7xIwEESMDmOu8zTedi6CJDIB
	Ynvozth56YaZO9BVyQmkzHUSPG/XOsUScYGcq0L2tK1BR7S7aGMH3epe1Mb8fQ88voZKxb4gdJUV0
	sXZxwurEXxDaKPkuGWLj6hvRA+HK2pixPfh6lHNTY7w+BPSToMJieIMqGX59Y0Sqzd8ZdbnSSSX9n
	IL3d6gvCaVSNfPHjG/ayZfZaHtf3OpcrLCiW9+8c3vxcATLvpRljAYliCfzKA1WnM6+nGXNqbCTZy
	UMoRMVfjXtB4PsI/SZVA1s5vDiykR89juRFXPAvycr7IUBFrFdUjNvkDlXQUUmJ0tkkRwFtBFFPnk
	OX682lYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUq1m-00GDci-1J; Thu, 17 Mar 2022 13:18:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUq1c-00GDZx-4q
 for linux-nvme@lists.infradead.org; Thu, 17 Mar 2022 13:18:46 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0D0D81F391;
 Thu, 17 Mar 2022 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647523121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5b537b4Yg+sW/PC7Y5qCEju6gJr94gI5OxbQIGlV6k=;
 b=t6yDSiepB+l4LkjyVsqbnkym3m5de0qNqVPyJ9EKzdA6Ee9s1xg3shALinZjRKE0W1Arqd
 fanXFK7Wxl4vqKpR4oKL0eC+tWXnjxquXnCyCOBqudbBvhf/kd2ozRBavVBKmeCiSHTYPC
 sWKIruG/R9zrVfCZMKdhz3JU0t1iGcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647523121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5b537b4Yg+sW/PC7Y5qCEju6gJr94gI5OxbQIGlV6k=;
 b=S4/UhwsdAHEuPgjnkt4z3kqXPEpIxcpQye/3/wQ1LOTTx13Gd96H4z3bq8P+3LfCAkxITA
 6sQyvG6W5u6L9XCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id AD5CEA3B98;
 Thu, 17 Mar 2022 13:18:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 9BEB75193761; Thu, 17 Mar 2022 14:18:40 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvmet: include all configured ports in discovery log page
 for unique discover controller
Date: Thu, 17 Mar 2022 14:18:33 +0100
Message-Id: <20220317131833.37068-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220317131833.37068-1-hare@suse.de>
References: <20220317131833.37068-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_061844_388596_F423BB44 
X-CRM114-Status: GOOD (  11.56  )
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

When an unique discovery controller is configured we should be reporting
all configured ports, and not just those which are reachable from the
current port.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/discovery.c | 69 ++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index bceeec00099a..6cefd4f60f9f 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -160,12 +160,24 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
-	size_t entries = 1;
-
-	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
-			continue;
+	size_t entries = 0;
+
+	if (nvmet_has_unique_disc_subsys()) {
+		list_for_each_entry(r, nvmet_ports, global_entry) {
+			list_for_each_entry(p, &r->subsystems, entry) {
+				if (!nvmet_host_allowed(p->subsys,
+							ctrl->hostnqn))
+					continue;
+				entries++;
+			}
+		}
+	} else {
 		entries++;
+		list_for_each_entry(p, &req->port->subsystems, entry) {
+			if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
+				continue;
+			entries++;
+		}
 	}
 	list_for_each_entry(r, &req->port->referrals, entry)
 		entries++;
@@ -220,23 +232,44 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	}
 	hdr = buffer;
 
-	nvmet_set_disc_traddr(req, req->port, traddr);
-
-	nvmet_format_discovery_entry(hdr, req->port,
-				     nvmet_disc_subsys->subsysnqn,
-				     traddr, NVME_NQN_CURR, numrec);
-	numrec++;
-
-	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
-			continue;
+	if (!nvmet_has_unique_disc_subsys()) {
+		nvmet_set_disc_traddr(req, req->port, traddr);
 
 		nvmet_format_discovery_entry(hdr, req->port,
-				p->subsys->subsysnqn, traddr,
-				NVME_NQN_NVME, numrec);
+					     nvmet_disc_subsys->subsysnqn,
+					     traddr, NVME_NQN_CURR, numrec);
 		numrec++;
-	}
 
+		list_for_each_entry(p, &req->port->subsystems, entry) {
+			if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
+				continue;
+
+			nvmet_format_discovery_entry(hdr, req->port,
+					p->subsys->subsysnqn, traddr,
+					NVME_NQN_NVME, numrec);
+			numrec++;
+		}
+	} else {
+		list_for_each_entry(p, &req->port->subsystems, entry) {
+			list_for_each_entry(r, nvmet_ports, global_entry) {
+				struct nvmet_subsys_link *l;
+
+				nvmet_set_disc_traddr(req, r, traddr);
+
+				list_for_each_entry(l, &r->subsystems, entry) {
+					if (p->subsys != l->subsys)
+						continue;
+					if (!nvmet_host_allowed(l->subsys,
+							ctrl->hostnqn))
+						continue;
+					nvmet_format_discovery_entry(hdr, r,
+						l->subsys->subsysnqn, traddr,
+						l->subsys->type, numrec);
+					numrec++;
+				}
+			}
+		}
+	}
 	list_for_each_entry(r, &req->port->referrals, entry) {
 		nvmet_format_discovery_entry(hdr, r,
 				NVME_DISC_SUBSYS_NAME,
-- 
2.29.2


