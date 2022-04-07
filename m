Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33D5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 10:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GZfKaSBUDDCWUFxAZUqnQzV00XxCjEBTZIBQc2QCclo=; b=tBGsrYd6F2oOTvnYVn0pVgFyiq
	yHSew8ur1lY1VcXASL/kksOe68dwlHt4wlhTakMYZ/g6k30fmlSU3n67olraoJFtlDs7O6AhYPrui
	YEr4IP+azG/WceAw/iwZdfcC/Lw/caa9Ns/5qcHmqHYHSqONt4T93uefaP95DCTxfe964f3flk6fx
	/eO5xzcnLNJdzdO17TXyVsS/XCqkZlg5ieky+HH+Nl6DAXPZCN9IvZKEeL0pFMpEO7z7MAMOHBy5n
	clqH88NfibdktasdFOHTycZQQrMAWPg9btz42zfbag8KqkCW0D/0jpzB0+4r8QQnvbxF67dsVtx9D
	iw5xu0pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncPnV-00BOcw-G7; Thu, 07 Apr 2022 10:55:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncPgT-00BLiy-MG
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 10:48:16 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 106C91F85D;
 Thu,  7 Apr 2022 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649328491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZfKaSBUDDCWUFxAZUqnQzV00XxCjEBTZIBQc2QCclo=;
 b=jNwT3IDiWDhjVDlJpAbSM7gxeeg64CBGjomvQt8Of27v7wsueCoyTRM4/WOKmXdm1XY0vA
 UnP0bDWouz7Iz0FY1DL8nnKVWtDioKcoI0z+nGiNLOwHmTX+xrJo3pBc2MzXZ2VqkiMCLo
 Pg+5LwYNvAd8JbtEwA9YkjTiefekDK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649328491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZfKaSBUDDCWUFxAZUqnQzV00XxCjEBTZIBQc2QCclo=;
 b=PQlfEFbVr5ig2WJ/WwamhPKQjGvvpfueWEu9qn2v4jCxFFlwkAlYk4QAuydPOUalN1K/Pf
 XI7FyGiWmWPBaIAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0616AA3B98;
 Thu,  7 Apr 2022 10:48:11 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id EA4675193BE9; Thu,  7 Apr 2022 12:48:10 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvmet: include all configured ports in the discovery log
 page
Date: Thu,  7 Apr 2022 12:48:08 +0200
Message-Id: <20220407104808.29007-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220407104808.29007-1-hare@suse.de>
References: <20220407104808.29007-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_034813_991177_27C30351 
X-CRM114-Status: GOOD (  13.35  )
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

When a per-port discovery subsystem is used we should include
all configured ports in the discovery log page, not just that one
through which the controller was connected.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/discovery.c | 52 ++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index e3d8cc407a94..6d414096d09a 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -152,10 +152,19 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	if (req->port->disc_subsys == nvmet_disc_subsys)
 		entries++;
 
-	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
-			continue;
-		entries++;
+	list_for_each_entry(r, nvmet_ports, global_entry) {
+		if (req->port->disc_subsys == nvmet_disc_subsys) {
+			if (r != req->port)
+				continue;
+		} else {
+			if (ctrl->subsys != r->disc_subsys)
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
@@ -219,14 +228,35 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		numrec++;
 	}
 
-	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
-			continue;
+	list_for_each_entry(r, nvmet_ports, global_entry) {
+		nvmet_set_disc_traddr(req, r, traddr);
 
-		nvmet_format_discovery_entry(hdr, req->port,
-				p->subsys->subsysnqn, traddr,
-				p->subsys->type, numrec);
-		numrec++;
+		if (req->port->disc_subsys == nvmet_disc_subsys) {
+			/*
+			 * Present information about the port to which
+			 * the controller is connected.
+			 */
+			if (r != req->port)
+				continue;
+		} else {
+			/*
+			 * If a per-port discovery subsystem is used present
+			 * information about all ports into which the
+			 * same discovery subsystem is linked.
+			 */
+			if (ctrl->subsys != r->disc_subsys)
+				continue;
+		}
+
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


