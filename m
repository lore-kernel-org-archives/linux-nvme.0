Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306F3C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 17:43:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB65861166
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 17:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB65861166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IwbSs301HTvtSBvNvgRvbEOzRAlVFKSdiBm/AKON0lk=; b=RC7N4fc9N7g6d0
	DypUmiXe0FeBFUYl2Ak8+wHSHklx4HGLdw7PMxpgK6vJdU+lCwML+f0NRAIg/UInmc2jZHbH8Qn4w
	85Oi0KexM/OuvVi6UNJz0X+1radknngiape1spAJe5qw0gCeeJohhICJymekWEoAcFTRAOiOmyOby
	n+s0JMneJcuC8xQzhZuWj1TsmYN0VTjH43R3Qw1ehenRITcZnfIUsKQpFONPsTOwWm4XdJthdJW1z
	ovYKq6LK4QiU6VsXhYhFlh4JBWBA6tmINW6UVeIK/HZNY5bMxvKmmu+1W1YSscdUKbchluMWPjNAM
	OuEcMyXb7HLC65TshmDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSjnC-005MAM-8n; Tue, 21 Sep 2021 17:42:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSjmz-005M6K-39
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 17:42:42 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 23C42221E3;
 Tue, 21 Sep 2021 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632246159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XKSVlCJEax8DuE5jE1AwYrgereTz8nJTQ4X8QWRRKQ=;
 b=kmHuDPPHxmSNsKIKhs0UOu1b4PP2FPXl7UHnNmWjAQ05fXTP9PWMJIXFwe9/h2OEM7yN17
 NbUTatCjQiYI9Su+ldgbiSJW4XFQBhhoBbZk35Rnwl73PuRcXG9ZcJxr2zKCvSP/Ho+Y0/
 xH/0Lxo7gbtP38il5gRX4aL+3VGg8rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632246159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XKSVlCJEax8DuE5jE1AwYrgereTz8nJTQ4X8QWRRKQ=;
 b=pxOBIy31KoJUOBCEkIEv8RWE8asSVJrJW32zjRg0hd3ZpSl6qGLMJmSTwaPOd0oF7t1428
 5IA1ogOftbCN1ICQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 011E2A3B90;
 Tue, 21 Sep 2021 17:42:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id E51B3518EAA9; Tue, 21 Sep 2021 19:42:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvmet: register discovery subsystem as 'current'
Date: Tue, 21 Sep 2021 19:42:30 +0200
Message-Id: <20210921174230.30552-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210921174230.30552-1-hare@suse.de>
References: <20210921174230.30552-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_104241_345772_3054A961 
X-CRM114-Status: GOOD (  12.64  )
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

Register the discovery subsystem as the 'current' discovery subsystem,
and add a new discovery log page entry for this.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/core.c      |  2 ++
 drivers/nvme/target/discovery.c | 13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 873b02d8c31c..0e3de8670a27 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1539,6 +1539,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
