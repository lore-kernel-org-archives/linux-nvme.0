Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F062C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r99rVTmaXp3PLbfDNxganSpUb1DQiRb6MbvQzK+q+Ro=; b=bssDcfB80mRIUHWTSmB3RFdAQt
	1Ru+BbH0lvu8HmKWeLEdI2XWSNLRM1KmAzadgb6RthAL+nYQrliu+AGTorKR5oUq+ooRs8gxxqqX2
	DMtQ/iRfwLv3LGUunuNM90naFLGagqBTAkrWQh9qNvxxqupR3mMmaS7d26WynlewmcAym6lswU5Hu
	Oyvq8vKr72OMqwtFzG6qwLxKTdw9KA4YLSHc15LDunxt7NNahgF9jVSYawQL9jJiZVLT5q9+4cbt+
	Ot52jrLSeOpqPUgpDKwI1hxYxLUkMhg0Lm4OTaoeVychpyqGuLIzbHUiDyRSygsl+Fhkxh9pLb3jZ
	oR+vawDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFeu-00BEHG-33;
	Mon, 18 Dec 2023 15:35:56 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFep-00BEF1-06
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 15:35:54 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35F5E1F37E;
	Mon, 18 Dec 2023 15:35:49 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2455E13BC8;
	Mon, 18 Dec 2023 15:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id unYoCNVmgGUTfQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 15:35:49 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 01/16] nvmet: report ioccsz and iorcsz for disc ctrl
Date: Mon, 18 Dec 2023 16:30:49 +0100
Message-ID: <20231218153105.12717-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
References: <20231218153105.12717-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: 35F5E1F37E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_073551_231854_1BB25E53 
X-CRM114-Status: GOOD (  12.09  )
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

The host started to verify the ioccsz and iorcsz values. I/O controllers
return valid values but not the discovery controllers. Use the same
values as for I/O controllers.

Fixes: 2fcd3ab39826 ("nvme-fabrics: check ioccsz and iorcsz")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/discovery.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 668d257fa986..e3c4d247dd23 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
+	u32 cmd_capsule_size;
 	u16 status = 0;
 
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -294,6 +295,18 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 
 	strscpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
 
+	/*
+	 * Max command capsule size is sqe + in-capsule data size.
+	 * Disable in-capsule data for Metadata capable controllers.
+	 */
+	cmd_capsule_size = sizeof(struct nvme_command);
+	if (!ctrl->pi_support)
+		cmd_capsule_size += req->port->inline_data_size;
+	id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
+
+	/* Max response capsule size is cqe */
+	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
-- 
2.43.0


