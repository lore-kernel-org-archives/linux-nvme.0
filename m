Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28B1C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 10:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1RccLVPeuDGJShj+itd22iKKYBOPrPLhet0mwFJk8h8=; b=dVJ1yTyN3t4hDiMV1o+nSH/sr1
	ppK8O7bWpOly8TAXaQ4jx6HBmrHYsOXbDRLSON1qD4tazHXK0qi6YsKUi8ZkDUIKFKw4HgdATirzP
	JTClT855K01ackUrwbSkftO4zyBGmdV9vIz5GEiVZt3s/exyrG39PoNJvxC6uW7tyVhVZthV9h1Sm
	oM3YpaAfRAnaWjBA4k4ai64wNtIhg6eZvK+J+BGJTS5LfhcMCnvjYmGBr+H3UUIgXlSUNj4cIRICY
	uCb5dkFn3wL79wL5pB22YbhBpvEIDdILIAKfkBdJIL+4ZqsZToBXsSzd+3TaTZQ31BcdTIwxrWJDU
	wg+pKT/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV7PW-00000002dPE-1Pjy;
	Wed, 31 Jan 2024 10:01:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6Kd-00000002FW4-391i
	for linux-nvme@bombadil.infradead.org;
	Wed, 31 Jan 2024 08:52:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1RccLVPeuDGJShj+itd22iKKYBOPrPLhet0mwFJk8h8=; b=bBGhwYxvQVZHXyr6Xv6DKw9y9W
	GxZXBe17QrpOHGmUH2nKsTZxwNEIPoVJr/05OOQ7LSkizfrC83tBjsGFZL6NVm1E9VO8lyuO/p0ih
	xfoAJl507bJKg7dsaqYtUlnVKvnBq6kcn12L5Gu2SwqkaBy0L+wsD7YAa65btgLy26/Bu+mgl3s40
	ok4Fp9tI4g2bhTl1sO24vxCp4n65WBy6dfwSKCUgMFB/iM3X1za7zPbFFFUWk7wZV4KIYasnrg8Ne
	Gx/8L32X3yxbcanzO1Ww+W3ocN/vpQMb+96ywqf5iQBosPm4i+EBWIncSFSCsjcbSIXSR3TOga9xm
	mPYNFgzQ==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6K1-00000008rBK-0d4q
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 08:52:17 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 409D02219B;
	Wed, 31 Jan 2024 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RccLVPeuDGJShj+itd22iKKYBOPrPLhet0mwFJk8h8=;
	b=BD6Uap8iGbTzE6Ba9pKHy63KcBEpLugprHgyNIg+6imuCoy5nPIQXWzNMl2cH6aM4/StXe
	ntqx4Xn0W69BB3Y0jCzlx3nDykywZIoRQ4P4nd385OqcaB2jv2w4G96jgzIRZjZXVZ9uPB
	p3NotjkWIJqiGPwynm2emqIAdxe5PnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RccLVPeuDGJShj+itd22iKKYBOPrPLhet0mwFJk8h8=;
	b=+yQqcfwlM5VeEIzObJr+Vn9YNpOBZ5P1Du4iYnX8B96PSbwwE5lu9DCaErMdXrd+Jr6gSf
	FjhQCAdk3sLqkqDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RccLVPeuDGJShj+itd22iKKYBOPrPLhet0mwFJk8h8=;
	b=BD6Uap8iGbTzE6Ba9pKHy63KcBEpLugprHgyNIg+6imuCoy5nPIQXWzNMl2cH6aM4/StXe
	ntqx4Xn0W69BB3Y0jCzlx3nDykywZIoRQ4P4nd385OqcaB2jv2w4G96jgzIRZjZXVZ9uPB
	p3NotjkWIJqiGPwynm2emqIAdxe5PnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RccLVPeuDGJShj+itd22iKKYBOPrPLhet0mwFJk8h8=;
	b=+yQqcfwlM5VeEIzObJr+Vn9YNpOBZ5P1Du4iYnX8B96PSbwwE5lu9DCaErMdXrd+Jr6gSf
	FjhQCAdk3sLqkqDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CCA4132FA;
	Wed, 31 Jan 2024 08:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ylF+CRAKumWdHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:28 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 11/12] nvmet-fc: take ref count on tgtport before delete assoc
Date: Wed, 31 Jan 2024 09:51:11 +0100
Message-ID: <20240131085112.21668-12-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BD6Uap8i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+yQqcfwl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.86 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLpnha4b14dfhn8rk8ih15dcuu)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.85)[99.34%]
X-Rspamd-Queue-Id: 409D02219B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_085208_652326_25330424 
X-CRM114-Status: GOOD (  11.92  )
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

We have to ensure that the tgtport is not going away
before be have remove all the associations.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3e0d391e631b..671d096745a5 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1090,13 +1090,28 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 }
 
 static void
-nvmet_fc_delete_assoc(struct work_struct *work)
+nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
+{
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
+}
+
+static void
+nvmet_fc_delete_assoc_work(struct work_struct *work)
 {
 	struct nvmet_fc_tgt_assoc *assoc =
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
+	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_target_assoc(assoc);
-	nvmet_fc_tgt_a_put(assoc);
+	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_tgtport_put(tgtport);
+}
+
+static void
+nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
+{
+	nvmet_fc_tgtport_get(assoc->tgtport);
+	queue_work(nvmet_wq, &assoc->del_work);
 }
 
 static struct nvmet_fc_tgt_assoc *
@@ -1127,7 +1142,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
-	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc);
+	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc_work);
 	atomic_set(&assoc->terminating, 0);
 
 	while (needrandom) {
@@ -1483,7 +1498,7 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		queue_work(nvmet_wq, &assoc->del_work);
+		nvmet_fc_schedule_delete_assoc(assoc);
 		nvmet_fc_tgt_a_put(assoc);
 	}
 	rcu_read_unlock();
@@ -1536,7 +1551,7 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			continue;
 		assoc->hostport->invalid = 1;
 		noassoc = false;
-		queue_work(nvmet_wq, &assoc->del_work);
+		nvmet_fc_schedule_delete_assoc(assoc);
 		nvmet_fc_tgt_a_put(assoc);
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1581,7 +1596,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			queue_work(nvmet_wq, &assoc->del_work);
+			nvmet_fc_schedule_delete_assoc(assoc);
 			nvmet_fc_tgt_a_put(assoc);
 			return;
 		}
@@ -1888,7 +1903,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
 	}
 
-	queue_work(nvmet_wq, &assoc->del_work);
+	nvmet_fc_schedule_delete_assoc(assoc);
 	nvmet_fc_tgt_a_put(assoc);
 
 	return false;
-- 
2.43.0


