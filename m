Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E11FC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 06:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Spumwhr9CsGMhuJ5lPsGFhdpgU7cDu28K0nioDIf3Y8=; b=pyPs0Qcsfx0uD5+BmuW4k6Y27e
	Qv3D/vjo9PMLg4WEm+tp/7saHSjOru+liGgpjFH1U+xqshEK5twHVDIm5waOHlNBQlKlNP+C/m+gP
	Z5g5jDcWCIcX9nG79EpobxZIO3ZX7pM/yOLXhC9vST0b3gid0Wow35qzcMeVpLTBZsyaFGVpAwkw6
	frrof1aRM339On7wAJpY8YZ9qsffnWvY1ZnM3sIn7qcd5VlR87/Ed1ES33qMyDcUvcjuN4Rf3jwpT
	ut8sFtGue0Ea19RKBXX/LNOcyPW0adVnmD/xnE+2Kw8X2rEWfEqh391oC/QlOnwH+pux2kt02c0p2
	CIqYsiog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncib0-00FNz1-PA; Fri, 08 Apr 2022 06:59:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncian-00FNue-Ui
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 06:59:40 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A089321601;
 Fri,  8 Apr 2022 06:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649401175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Spumwhr9CsGMhuJ5lPsGFhdpgU7cDu28K0nioDIf3Y8=;
 b=MpKq8Ib6ZeF6smc893fSv59yp8Ou3IsWz7DnjUZvbnkmw16S0bvt20lfnsD2V73UDnsm3A
 0o9gtCmUwmQOQ0gjQa5WE/iOAH0PI66dr+qDJITgiqTqg2SUUcMS2xUg8i29qj5TRr2r5K
 Fm46dGEJthn4G54OdFqg0reRXr5LPoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649401175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Spumwhr9CsGMhuJ5lPsGFhdpgU7cDu28K0nioDIf3Y8=;
 b=kK5+l/Ym6nf/OLygtmhxMofIw//7kdgfYTk811dExVdOg7kSCxJRA6wYgu+p+x0hyrspVb
 BIur1GJUle2g/kAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 94A15A3B8A;
 Fri,  8 Apr 2022 06:59:34 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id C2E6B5193C0B; Fri,  8 Apr 2022 08:59:34 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvmet: include all configured ports in the discovery log
 page
Date: Fri,  8 Apr 2022 08:59:30 +0200
Message-Id: <20220408065930.123015-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220408065930.123015-1-hare@suse.de>
References: <20220408065930.123015-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_235938_250152_E1FA6EF4 
X-CRM114-Status: GOOD (  15.57  )
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

- /
  o- ports
  | o- 1 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=8009]
  | | o- subsystems
  | |   o- nqn.discovery
  | o- 2 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4420]
  | | o- subsystems
  | |   o- nqn.discovery
  | |   o- nqn.io-1
  | o- 3 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4421]
  |   o- subsystems
  |     o- nqn.io-2
  o- subsystems
    o- nqn.discovery
    o- nqn.io-1
    | o- namespaces
    o- nqn.io-2
      o- namespaces

A discovery on port 8009 will return information about
- nqn.discovery at port 8009
- nqn.discovery at port 4420
- nqn.io-1 at port 4420
A discovery on port 4420 will return the same information.
A discovery on port 4421 will return information about
- standard discovery subsystem on port 4421
- nqn.io-2 on port 4421

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/discovery.c | 53 +++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 6b8aa6c4e752..ea8fce538342 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -149,6 +149,30 @@ static void nvmet_set_disc_traddr(struct nvmet_req *req, struct nvmet_port *port
 		memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
 }
 
+/*
+ * discovery_port_match - filter eligible ports for discovery log page
+ *
+ * If the port through which the controller is connected has no discovery
+ * subsystem linked, use the original behaviour of just including information
+ * about that port in the discovery log page.
+ * Otherwise include information about all ports into which the specified
+ * discovery subsystem is linked.
+ */
+
+static bool discovery_port_match(struct nvmet_req *req, struct nvmet_port *r)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+
+	if (!req->port->disc_subsys) {
+		if (r != req->port)
+			return false;
+	} else {
+		if (ctrl->subsys != r->disc_subsys)
+			return false;
+	}
+	return true;
+}
+
 static size_t discovery_log_entries(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -159,10 +183,14 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	if (!req->port->disc_subsys)
 		entries++;
 
-	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
+	list_for_each_entry(r, nvmet_ports, global_entry) {
+		if (!discovery_port_match(req, r))
 			continue;
-		entries++;
+		list_for_each_entry(p, &r->subsystems, entry) {
+			if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
+				continue;
+			entries++;
+		}
 	}
 	list_for_each_entry(r, &req->port->referrals, entry)
 		entries++;
@@ -226,14 +254,21 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		numrec++;
 	}
 
-	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
+	list_for_each_entry(r, nvmet_ports, global_entry) {
+		nvmet_set_disc_traddr(req, r, traddr);
+
+		if (!discovery_port_match(req, r))
 			continue;
 
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


