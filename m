Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B194DC25B79
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 05:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mk7IbOQ2z2ScQCdXdR0G2Et52UE3AWqwsDGwJhY4YxE=; b=R8noILjuJO5O0DagkaT+tQbRF/
	tg9AgQkNFtjcPnDT2wT4ov+8krA1L5dk2qjfqT56wbKwRXDILjOPK7i7+t9WFhMoAA+pAzfkzHlt1
	0W6HNiyXJKgfYXvAf5ZHm4/BIGo8VSfUmVM5hc8MJeOKEezbvJv+WFtTx1Ih83Fl08fzX81r+fPfY
	+3fYKt304MnulFTgd+yut/kauWJzKuftjcbWYkl7AQIavTq2GPtfIaOvUentTZIF2VSGk6IvVj0mj
	IioHF7zbY1a5Pyz3MFdLZLqgRfOraTot47lutsF3iAp8ubidFfLgrfnFzVVrgpgateRysyjrsswkK
	2z6dfTBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSiI-0000000DoZO-0d55;
	Mon, 27 May 2024 05:16:02 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSi7-0000000DoUx-1fYY
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 05:16:00 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9180321C49;
	Mon, 27 May 2024 05:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk7IbOQ2z2ScQCdXdR0G2Et52UE3AWqwsDGwJhY4YxE=;
	b=TAW6XjvD8YP9fmdfnGYbVt9iRYXyFNAtO0BxuxORCyXhEI1Tk48JLHtouZFEBuyJV9ELRR
	zOxkGownpd4/fMj5GGb/TPc9/mjFEbbNQNHeMBwhWujVn6JTQd/vPm3oOddsJ1P5/VWDBs
	vQHT6KhYYYVPCW4SKVDRE4mz0jsoOvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk7IbOQ2z2ScQCdXdR0G2Et52UE3AWqwsDGwJhY4YxE=;
	b=7xwOHorf24v4LbySBs29xi7jwgfTn2SrCqvRXIqhs21cXNDDbqQcwGXtm0SUREU8dp079S
	KIe5BB9Ktbhin7Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk7IbOQ2z2ScQCdXdR0G2Et52UE3AWqwsDGwJhY4YxE=;
	b=TAW6XjvD8YP9fmdfnGYbVt9iRYXyFNAtO0BxuxORCyXhEI1Tk48JLHtouZFEBuyJV9ELRR
	zOxkGownpd4/fMj5GGb/TPc9/mjFEbbNQNHeMBwhWujVn6JTQd/vPm3oOddsJ1P5/VWDBs
	vQHT6KhYYYVPCW4SKVDRE4mz0jsoOvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk7IbOQ2z2ScQCdXdR0G2Et52UE3AWqwsDGwJhY4YxE=;
	b=7xwOHorf24v4LbySBs29xi7jwgfTn2SrCqvRXIqhs21cXNDDbqQcwGXtm0SUREU8dp079S
	KIe5BB9Ktbhin7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CDAC13A6B;
	Mon, 27 May 2024 05:15:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T6K9HAAXVGZxYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 05:15:44 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 5/7] nvmet-fc: implement host_traddr()
Date: Mon, 27 May 2024 07:15:23 +0200
Message-ID: <20240527051525.762-6-dwagner@suse.de>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527051525.762-1-dwagner@suse.de>
References: <20240527051525.762-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_221551_927982_4F11118F 
X-CRM114-Status: GOOD (  15.85  )
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

From: Hannes Reinecke <hare@kernel.org>

Implement callback to display the host transport address by
adding a callback 'host_traddr' for nvmet_fc_target_template.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c       | 33 +++++++++++++++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fd229f310c93..b4706a8a9837 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2931,6 +2931,38 @@ nvmet_fc_discovery_chg(struct nvmet_port *port)
 		tgtport->ops->discovery_event(&tgtport->fc_target_port);
 }
 
+static ssize_t
+nvmet_fc_host_traddr(struct nvmet_ctrl *ctrl,
+		char *traddr, size_t traddr_size)
+{
+	struct nvmet_sq *sq = ctrl->sqs[0];
+	struct nvmet_fc_tgt_queue *queue =
+		container_of(sq, struct nvmet_fc_tgt_queue, nvme_sq);
+	struct nvmet_fc_tgtport *tgtport = queue->assoc ? queue->assoc->tgtport : NULL;
+	struct nvmet_fc_hostport *hostport = queue->assoc ? queue->assoc->hostport : NULL;
+	u64 wwnn, wwpn;
+	ssize_t ret = 0;
+
+	if (!tgtport || !nvmet_fc_tgtport_get(tgtport))
+		return -ENODEV;
+	if (!hostport || !nvmet_fc_hostport_get(hostport)) {
+		ret = -ENODEV;
+		goto out_put;
+	}
+
+	if (tgtport->ops->host_traddr) {
+		ret = tgtport->ops->host_traddr(hostport->hosthandle, &wwnn, &wwpn);
+		if (ret)
+			goto out_put_host;
+		ret = snprintf(traddr, traddr_size, "nn-0x%llx:pn-0x%llx", wwnn, wwpn);
+	}
+out_put_host:
+	nvmet_fc_hostport_put(hostport);
+out_put:
+	nvmet_fc_tgtport_put(tgtport);
+	return ret;
+}
+
 static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_FC,
@@ -2940,6 +2972,7 @@ static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.queue_response		= nvmet_fc_fcp_nvme_cmd_done,
 	.delete_ctrl		= nvmet_fc_delete_ctrl,
 	.discovery_chg		= nvmet_fc_discovery_chg,
+	.host_traddr		= nvmet_fc_host_traddr,
 };
 
 static int __init nvmet_fc_init_module(void)
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 4109f1bd6128..89ea1ebd975a 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -920,6 +920,9 @@ struct nvmet_fc_target_port {
  *       further references to hosthandle.
  *       Entrypoint is Mandatory if the lldd calls nvmet_fc_invalidate_host().
  *
+ * @host_traddr: called by the transport to retrieve the node name and
+ *       port name of the host port address.
+ *
  * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
  *       supports for cpu affinitization.
  *       Value is Mandatory. Must be at least 1.
@@ -975,6 +978,7 @@ struct nvmet_fc_target_template {
 	void (*ls_abort)(struct nvmet_fc_target_port *targetport,
 				void *hosthandle, struct nvmefc_ls_req *lsreq);
 	void (*host_release)(void *hosthandle);
+	int (*host_traddr)(void *hosthandle, u64 *wwnn, u64 *wwpn);
 
 	u32	max_hw_queues;
 	u16	max_sgl_segments;
-- 
2.45.1


