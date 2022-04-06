Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1191AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tmluMSiPGupq4TJU3oDGVvJ1ProtwuojSdYuvl4csQE=; b=p3sk/8ZICX72A6fol9HrYjJIWk
	6FgYbn+IAMHqiZbKM47bPvrwUXGSkpoInqWwtootlfguVcoJ6nwfiVV3p0T/ruygQqjaD8rlbMsDH
	hnkdr6+6zdeAL+iCpC6oCx0kJX6tBeF3dxVPwVhWoJsB/I+8lqAcdlcBc7D9X1seWHsaKbw3Br1p+
	/DpGHhVJ4k6b7TEZIHp4dujqOpcqiWgReUaUOFQ7SLLrhebYDmrgytCthxMleR6a2AMMe9MBr3cQI
	aHhbNHwVWvgs8rC3TIjk3oFtHL2NBGI13DioGa5XQn1b2GL8WwOCv6+5Vamrp865u0knyNcCTsg2U
	1jqZbDOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc6Y9-006TRE-Uy; Wed, 06 Apr 2022 14:22:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc6Y6-006TOA-Qc
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 14:22:20 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 833FF2112B;
 Wed,  6 Apr 2022 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649254935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmluMSiPGupq4TJU3oDGVvJ1ProtwuojSdYuvl4csQE=;
 b=by78BBsugDddI1Qs7q0iXpJXwHQcDe6JdMeCc5AdyWQJbY7ZbJxzpVjEg1gVu6WWt8+Wt8
 OxPSKhFFNXyEWKJSIFQ8qLCNfy9on6HNP+Lxeu98wZy4xmts6la6pJfj13IvsktxFJxonV
 Js6biw1vgq0LihnT4Wiy9gcPkAea/j8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649254935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmluMSiPGupq4TJU3oDGVvJ1ProtwuojSdYuvl4csQE=;
 b=PaqgULU/AoJfiq50unN24niZo7gW6E4j1pcbG+HNM0Sx5Kt4TBzqNBzmpvI6v0cKCzCNzN
 0OHEoPQPDzV3lsAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 7DAB7A3B8A;
 Wed,  6 Apr 2022 14:22:15 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 6F58F5193BB0; Wed,  6 Apr 2022 16:22:15 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvmet: include all configured port in the discovery log
 page
Date: Wed,  6 Apr 2022 16:22:10 +0200
Message-Id: <20220406142210.71248-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220406142210.71248-1-hare@suse.de>
References: <20220406142210.71248-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_072219_068303_42FE8E1E 
X-CRM114-Status: GOOD (  16.29  )
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

When exposed discovery subsystems are enabled we should include
all configured ports in the discovery log page, not just those
through which the controller was connected.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/discovery.c | 72 ++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 13fda8f9d60c..d23353a750dd 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -172,6 +172,7 @@ static void nvmet_set_disc_traddr(struct nvmet_req *req, struct nvmet_port *port
 static size_t discovery_log_entries(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_subsys *disc_subsys = ctrl->subsys;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
 	size_t entries = 0;
@@ -179,10 +180,27 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	if (!nvmet_expose_discovery_subsys())
 		entries++;
 
-	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
-			continue;
-		entries++;
+	list_for_each_entry(r, nvmet_ports, global_entry) {
+		if (!nvmet_expose_discovery_subsys()) {
+			if (r != req->port)
+				continue;
+		} else {
+			bool linked = false;
+
+			list_for_each_entry(p, &r->subsystems, entry) {
+				if (p->subsys == disc_subsys) {
+					linked = true;
+					break;
+				}
+			}
+			if (!linked)
+				continue;
+		}
+		list_for_each_entry(p, &r->subsystems, entry) {
+			if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
+				continue;
+			entries++;
+		}
 	}
 	list_for_each_entry(r, &req->port->referrals, entry)
 		entries++;
@@ -193,6 +211,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 {
 	const int entry_size = sizeof(struct nvmf_disc_rsp_page_entry);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_subsys *disc_subsys = ctrl->subsys;
 	struct nvmf_disc_rsp_page_hdr *hdr;
 	u64 offset = nvmet_get_log_page_offset(req->cmd);
 	size_t data_len = nvmet_get_log_page_len(req->cmd);
@@ -246,14 +265,45 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		numrec++;
 	}
 
-	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
-			continue;
+	list_for_each_entry(r, nvmet_ports, global_entry) {
+		nvmet_set_disc_traddr(req, r, traddr);
+
+		if (!nvmet_expose_discovery_subsys()) {
+			/*
+			 * If the discovery subsystem is not exposed fall
+			 * back to the original design of only presenting
+			 * information about the port to which the controller
+			 * is connected.
+			 */
+			if (r != req->port)
+				continue;
+		} else {
+			bool linked = false;
+
+			/*
+			 * If the discovery subsystem is exposed present
+			 * information about all ports into which the
+			 * discovery subsystem is linked.
+			 */
+			list_for_each_entry(p, &r->subsystems, entry) {
+				if (p->subsys == disc_subsys) {
+					linked = true;
+					break;
+				}
+			}
+			if (!linked)
+				continue;
+		}
 
-		nvmet_format_discovery_entry(hdr, req->port,
-				p->subsys->subsysnqn, traddr,
-				p->subsys->type, numrec);
-		numrec++;
+		list_for_each_entry(p, &r->subsystems, entry) {
+			if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
+				continue;
+
+			nvmet_format_discovery_entry(hdr, r,
+					p->subsys->subsysnqn, traddr,
+					p->subsys->type, numrec);
+			numrec++;
+		}
 	}
 
 	list_for_each_entry(r, &req->port->referrals, entry) {
-- 
2.29.2


