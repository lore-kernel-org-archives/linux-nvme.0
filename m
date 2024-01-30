Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF89C47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LBhSlwz3AB0ajCmtnMnq+5bz4kW5cELOvagoWwjrYtM=; b=XLXPAu0Bkvlfk29VUCpeyRPljt
	lx4BgHhe9n+L6+0Q6YsCkcSjJvqWrD85Ek+IM5pyXPutplcTcu8m7kYKYBHmucwxEDqDcsCJIaqDb
	DDoesWf/vnm1IZg0QyfdLgQrlZHWuuGJVu4bKUC1/c2jaqSwn5E1tB6AKAQQQroOkrUIXtHjqyWVL
	gqwrf9QlbE11g9yAHDfQAfZ8NuTHqb04Rlw622+XWSjdIHOw7PO1nTSUUThrDupddVuhkyMmLOb4B
	JzXx7g4S48W0OMoWrcoCBMMhLiBeK/GqAAP+9gk+WjourEsoHHmBFM2E5CSB5MAu3jO0XcOSyt5Cm
	V7qESl6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUklT-0000000G1Vu-3Bs3;
	Tue, 30 Jan 2024 09:50:47 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUkkk-0000000G10m-1Vj1
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 09:50:40 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BFC021FBC;
	Tue, 30 Jan 2024 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBhSlwz3AB0ajCmtnMnq+5bz4kW5cELOvagoWwjrYtM=;
	b=oQ2Mz5KK8Hm8cTq6JIDP3ucb8DjETD2xzytgiDe0+mhMtTl3tZGBKJyn4zPyY81nsqyAnq
	8TMrh1PU+ZvrF7nAa7lqKlmM5aFvSH5SRLyWX0Y5/nDoSYEqVlo62rWXotUXLKMy4UYWHt
	XnjQOdi4XwIRnFe2GdSwk6I9uGKb9kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBhSlwz3AB0ajCmtnMnq+5bz4kW5cELOvagoWwjrYtM=;
	b=T6CtLH/WAgliFsMQtpfhv2UJDZSXhtvAFlotxenj46M29yJfI12gecosBHvCYBDs5dHpxT
	FOqhSL68x8BX5iCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBhSlwz3AB0ajCmtnMnq+5bz4kW5cELOvagoWwjrYtM=;
	b=oQ2Mz5KK8Hm8cTq6JIDP3ucb8DjETD2xzytgiDe0+mhMtTl3tZGBKJyn4zPyY81nsqyAnq
	8TMrh1PU+ZvrF7nAa7lqKlmM5aFvSH5SRLyWX0Y5/nDoSYEqVlo62rWXotUXLKMy4UYWHt
	XnjQOdi4XwIRnFe2GdSwk6I9uGKb9kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBhSlwz3AB0ajCmtnMnq+5bz4kW5cELOvagoWwjrYtM=;
	b=T6CtLH/WAgliFsMQtpfhv2UJDZSXhtvAFlotxenj46M29yJfI12gecosBHvCYBDs5dHpxT
	FOqhSL68x8BX5iCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 88DF913462;
	Tue, 30 Jan 2024 09:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Wqn3H0PGuGWlbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 30 Jan 2024 09:49:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 12/12] nvmet-fc: use RCU list iterator for assoc_list
Date: Tue, 30 Jan 2024 10:49:38 +0100
Message-ID: <20240130094938.1575-13-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130094938.1575-1-dwagner@suse.de>
References: <20240130094938.1575-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.88%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_015002_609828_1C1DAE21 
X-CRM114-Status: GOOD (  12.11  )
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

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 671d096745a5..b8d3e30f2ddb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1151,7 +1151,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 		spin_lock_irqsave(&tgtport->lock, flags);
 		needrandom = false;
-		list_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(tmpassoc, &tgtport->assoc_list, a_list) {
+
 			if (ran == tmpassoc->association_id) {
 				needrandom = true;
 				break;
@@ -1161,6 +1163,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 			assoc->association_id = ran;
 			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
 		}
+		rcu_read_unlock();
 		spin_unlock_irqrestore(&tgtport->lock, flags);
 	}
 
-- 
2.43.0


