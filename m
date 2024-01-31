Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAB4C48285
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=; b=GzgIHUjkkInQKRfK0RzKypBYna
	kLkNkEkyBrez7XGalzCVTbsw6tCDi8ETnjmn+rhTqowkfTjfasZbA1vCqTfSDzNSd6ZpAGpIDJm8/
	aD9IceWT1poBy92kTfQ7Fm5LNlsDOjhS/7g5TpU0EZqBLlykoRx7re/b9jOAvS5psDon9m7i09E98
	M7UQNUkorGF/xGkVgfSDEAzLxwQgWDayPmEdoeOk7mQ7hZawiqC/RI6PD1nfWc4K0fX/QxxsOKb1Y
	bL2qvLXBDvl0kcSXkoRb78eXcuM+J7bxJrT7fX8NsnaIJYxoyiwnO5veuANhpTmuXCQ5XbB5ADT5S
	5fs+G2/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV7PS-00000002dLW-0pGy;
	Wed, 31 Jan 2024 10:01:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6Jv-00000002FA6-2G11
	for linux-nvme@bombadil.infradead.org;
	Wed, 31 Jan 2024 08:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=; b=gaJ8Mj5i3ZrqsDX3mezKon1dUx
	0/lHTLvaKvUxPuRZhOwyGIw+86ky2QwO/J5XQQ1O2lST7FJNR0RX6AZeBazFZOP/tDsSrH3JSjZnS
	kdgS81GKslGYqhxMHOCQ4OKtIkzMmMrhC0/nO0b2js6R6HENQ4xXRR+BgT3GxlwsJNZ3JCYykXJx0
	/T1wfJ5l/C7b2FqiYQAqQ/wrgf/0YBM7cbytUDgyd8U0aLbcmO8LTinew/lFfCeWPvU6GUxnfyfew
	77n8dNIc+6bIT/1uGev5tIU3pt0XtlrIsSBsOW+7VLKJHNd6yKxD1HRfcPrzx+xrIxguF6fZJcY9U
	Nm2F0kWA==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6Jf-00000008r3u-0woy
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 08:51:40 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB16C1FD0B;
	Wed, 31 Jan 2024 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=;
	b=OBXC8oQPr6ZF0lYYOWW6O0jhMCGW57QX750Z990q/UulyRcUaIKSe40O09i53JAPsYJ77u
	Z2r/MqGPjzBDi7FGkkdEEstlGHwxATon3cPcFRtRKNvvPH0OrovLIdI4pRiZg/an4Sr+Cm
	ERoozcOyGvyKLvucAuvDktLqKIEA/Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=;
	b=6obWJHviNgPTc5jV/mxydkQyiR4M9kuwUWGO7nG1tgF5cy5rF5tFgg0TOvx9WYmza1mE9N
	vgUnqp0mQaL5wKCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=;
	b=OBXC8oQPr6ZF0lYYOWW6O0jhMCGW57QX750Z990q/UulyRcUaIKSe40O09i53JAPsYJ77u
	Z2r/MqGPjzBDi7FGkkdEEstlGHwxATon3cPcFRtRKNvvPH0OrovLIdI4pRiZg/an4Sr+Cm
	ERoozcOyGvyKLvucAuvDktLqKIEA/Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=;
	b=6obWJHviNgPTc5jV/mxydkQyiR4M9kuwUWGO7nG1tgF5cy5rF5tFgg0TOvx9WYmza1mE9N
	vgUnqp0mQaL5wKCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C90DA132FA;
	Wed, 31 Jan 2024 08:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dtunLxAKumWfHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:28 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 12/12] nvmet-fc: use RCU list iterator for assoc_list
Date: Wed, 31 Jan 2024 09:51:12 +0100
Message-ID: <20240131085112.21668-13-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.44)[91.26%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_085132_768576_560CA0AE 
X-CRM114-Status: GOOD (  12.30  )
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

The assoc_list is a RCU protected list, thus use the RCU flavor of list
functions.

Let's use this opportunity and refactor this code and move the lookup
into a helper and give it a descriptive name.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 671d096745a5..fd229f310c93 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1114,14 +1114,27 @@ nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	queue_work(nvmet_wq, &assoc->del_work);
 }
 
+static bool
+nvmet_fc_assoc_exits(struct nvmet_fc_tgtport *tgtport, u64 association_id)
+{
+	struct nvmet_fc_tgt_assoc *a;
+
+	list_for_each_entry_rcu(a, &tgtport->assoc_list, a_list) {
+		if (association_id == a->association_id)
+			return true;
+	}
+
+	return false;
+}
+
 static struct nvmet_fc_tgt_assoc *
 nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 {
-	struct nvmet_fc_tgt_assoc *assoc, *tmpassoc;
+	struct nvmet_fc_tgt_assoc *assoc;
 	unsigned long flags;
+	bool done;
 	u64 ran;
 	int idx;
-	bool needrandom = true;
 
 	if (!tgtport->pe)
 		return NULL;
@@ -1145,24 +1158,21 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc_work);
 	atomic_set(&assoc->terminating, 0);
 
-	while (needrandom) {
+	done = false;
+	do {
 		get_random_bytes(&ran, sizeof(ran) - BYTES_FOR_QID);
 		ran = ran << BYTES_FOR_QID_SHIFT;
 
 		spin_lock_irqsave(&tgtport->lock, flags);
-		needrandom = false;
-		list_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list) {
-			if (ran == tmpassoc->association_id) {
-				needrandom = true;
-				break;
-			}
-		}
-		if (!needrandom) {
+		rcu_read_lock();
+		if (!nvmet_fc_assoc_exits(tgtport, ran)) {
 			assoc->association_id = ran;
 			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
+			done = true;
 		}
+		rcu_read_unlock();
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-	}
+	} while (!done);
 
 	return assoc;
 
-- 
2.43.0


