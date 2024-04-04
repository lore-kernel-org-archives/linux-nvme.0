Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948C5CD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3iFg5EznOnzNIdBZVMrMb3Gm6rtmi64SkeL4Z8CmSo8=; b=opCracsrG0trJd97PV3FUKgPKX
	NRbGkF0YkepQuBZ7ZFZzfWIZiasL/Nltx2h/DXH0ClajjMwdaWQ8xJ7xAJv6CHIfdRbgnEMEZyRtR
	UbBg+FU84nWExeY46v8tMO7LGYvQtjFYXb99Z5kkrRm707HXmfK3DfpT8J+uLtZlphQXhyvZQsc4q
	UALWV2CbFYc/JfDjxQYz559b0PwBLarWdbQkP0HsvmElbnx0K23o9Naso7yyMZMLjxRwvcZ09vtvh
	Qq75EkDoRZk8rn64lAT6uQt6m9gLiWJciKtqGkIzDXm+44LrFsxgEXUH2k37t3+T2xsG2XVDVlMhZ
	iLA2zo2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOHk-000000034kj-2nRL;
	Thu, 04 Apr 2024 14:41:48 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOHd-000000034hr-0sPA
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 14:41:45 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E54665F805;
	Thu,  4 Apr 2024 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iFg5EznOnzNIdBZVMrMb3Gm6rtmi64SkeL4Z8CmSo8=;
	b=E9g4IS5S7mVLdxH2uBRmUh9zs2+O46PoavWofXNE7v5o5H4Pym/S9gDp+0oEdVFJTdFSkf
	f01zUL57PDVf4C7QICJ3LiiQ676T4Ts4qHgTVLJRam/NN6yh85pmjBIDzDmNxd/xzVblAx
	DW8BrAWxpQ+n3kiqVH/AOvrpNpIKKlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iFg5EznOnzNIdBZVMrMb3Gm6rtmi64SkeL4Z8CmSo8=;
	b=QmghPWp3qhXdU+tzE/LMLl4Vw6ZFNoP0fAX7ZWzJg5/3OUHHxPuZbtclVXFXutdaBsNVl5
	55+Vli/5Rim/2TCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iFg5EznOnzNIdBZVMrMb3Gm6rtmi64SkeL4Z8CmSo8=;
	b=E9g4IS5S7mVLdxH2uBRmUh9zs2+O46PoavWofXNE7v5o5H4Pym/S9gDp+0oEdVFJTdFSkf
	f01zUL57PDVf4C7QICJ3LiiQ676T4Ts4qHgTVLJRam/NN6yh85pmjBIDzDmNxd/xzVblAx
	DW8BrAWxpQ+n3kiqVH/AOvrpNpIKKlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iFg5EznOnzNIdBZVMrMb3Gm6rtmi64SkeL4Z8CmSo8=;
	b=QmghPWp3qhXdU+tzE/LMLl4Vw6ZFNoP0fAX7ZWzJg5/3OUHHxPuZbtclVXFXutdaBsNVl5
	55+Vli/5Rim/2TCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C875F13298;
	Thu,  4 Apr 2024 14:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /J97LyG8DmZqDQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 14:41:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 1/2] nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
Date: Thu,  4 Apr 2024 16:41:30 +0200
Message-ID: <20240404144131.17988-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404144131.17988-1-dwagner@suse.de>
References: <20240404144131.17988-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.97 / 50.00];
	BAYES_HAM(-1.17)[88.89%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_074141_424083_64CBAC9F 
X-CRM114-Status: GOOD (  13.14  )
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

The RCU lock is only needed for the lookup loop and not for
list_ad_tail_rcu call. Thus move it down the call chain into
nvmet_fc_assoc_exists.

While at it also fix the name typo of the function.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index b4706a8a9837..a8fb89da7281 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1115,16 +1115,21 @@ nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 }
 
 static bool
-nvmet_fc_assoc_exits(struct nvmet_fc_tgtport *tgtport, u64 association_id)
+nvmet_fc_assoc_exists(struct nvmet_fc_tgtport *tgtport, u64 association_id)
 {
 	struct nvmet_fc_tgt_assoc *a;
+	bool found = false;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(a, &tgtport->assoc_list, a_list) {
-		if (association_id == a->association_id)
-			return true;
+		if (association_id == a->association_id) {
+			found = true;
+			break;
+		}
 	}
+	rcu_read_unlock();
 
-	return false;
+	return found;
 }
 
 static struct nvmet_fc_tgt_assoc *
@@ -1164,13 +1169,11 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		ran = ran << BYTES_FOR_QID_SHIFT;
 
 		spin_lock_irqsave(&tgtport->lock, flags);
-		rcu_read_lock();
-		if (!nvmet_fc_assoc_exits(tgtport, ran)) {
+		if (!nvmet_fc_assoc_exists(tgtport, ran)) {
 			assoc->association_id = ran;
 			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
 			done = true;
 		}
-		rcu_read_unlock();
 		spin_unlock_irqrestore(&tgtport->lock, flags);
 	} while (!done);
 
-- 
2.44.0


