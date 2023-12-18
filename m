Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDD0C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 17:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jidSXu3GQu1D6ClvnkRcaqOionVtvrMNSab/YE86Yfw=; b=sX9tv1M9n7jua2xZ1rISL8Pbnj
	2y7HogePe7LS/LBm04q/m2EfqEfBo0EsWD39MdfE3bhofcs9m2mx9TvzZ30Geir87CE8Dc8izUvWi
	ok4J4EIjyZAnX19FS4w+NUXW3TxFo3rJqjL2zueQv0sEJPQCNXvS+V4gOM+AlEKfKaYFHfHMgK+UO
	CtLzAu2RumaNqYYWRHCGKZeqI67xVFf8lAuHc7OFRWG1TcsJAejrUD4JFyjaPTTiOlCfe+KzADbPh
	y+1wF/pFeUqXPqS9PcLT6OBbtuAdDxgnGv+qma1f3rYU3YMgL9a8uu0OzjHsTYQsAlbPmJW6J/M6e
	aEpqRliA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGyQ-00BXzO-1B;
	Mon, 18 Dec 2023 17:00:10 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGyK-00BXwV-0s
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 17:00:06 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF65921F1E;
	Mon, 18 Dec 2023 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jidSXu3GQu1D6ClvnkRcaqOionVtvrMNSab/YE86Yfw=;
	b=IrzfwQZDhBJ05hQgk53dxDNlzcyp8MYam4FK0GXq0NsG7l6oO7K65J7y2MNi1o1VcqRf3p
	UkNjR5KvGVxQhBkq4/nxuf+USc6+Otm2CjHaF1+1KWOlchzNKmewQk7xCvbtBW7HL7YYBX
	SBkRFqXCeIun8B41SMjq7sokBBUDQoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jidSXu3GQu1D6ClvnkRcaqOionVtvrMNSab/YE86Yfw=;
	b=hi9dbJO2dKzBDZlomQJ1oCYUcD2sbAAuPwogTqH4z9wd2MxEzJv72EJT68ZWUYB+kd0Qto
	jskf0K9+PrJokNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702918802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jidSXu3GQu1D6ClvnkRcaqOionVtvrMNSab/YE86Yfw=;
	b=Ge0+QLJe5+xal/2d9aT5SX2h+vAzworrENiFFS48UU7GWzIq68ZotDgfLumNENF2yyZCoU
	DT9hi29edQ9nQGuOjhde+Sm9M+85z8UNETrW1Peat91dH4wfr92ilAjrvr7ufD/UnaARNc
	CZ8zcagAoeP7xU6qwoNfumN6UEZ6vBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702918802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jidSXu3GQu1D6ClvnkRcaqOionVtvrMNSab/YE86Yfw=;
	b=YL5KHqSiRyHzOqIfm5r2PugeOtcnjh3Umhe9BuhvHakjgluX1z4T/9Diae4IEGLGs0UXzi
	rbrEJp7iUFSTw7Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E15C113927;
	Mon, 18 Dec 2023 17:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4GQONpJ6gGVrDwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 17:00:02 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 6/6] nvme: repack struct nvme_ns_head
Date: Mon, 18 Dec 2023 17:59:54 +0100
Message-ID: <20231218165954.29652-7-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218165954.29652-1-dwagner@suse.de>
References: <20231218165954.29652-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLzwqma61bu69hpd6dkgm7pq7m)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.68%]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_090004_735770_A1EA7C6E 
X-CRM114-Status: GOOD (  11.05  )
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

ns_id, lba_shift and ms are always accessed for every read/write I/O in
nvme_setup_rw. By grouping these variables into one cacheline we can
safe some cycles.

4k sequential reads:

           baseline   patched
Bandwidth: 1620       1634
IOPs       66345579   66910939

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/nvme.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6211f18c53c7..3dbd187896d8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -440,21 +440,21 @@ struct nvme_ns_head {
 	struct list_head	list;
 	struct srcu_struct      srcu;
 	struct nvme_subsystem	*subsys;
-	unsigned		ns_id;
 	struct nvme_ns_ids	ids;
 	struct list_head	entry;
 	struct kref		ref;
 	bool			shared;
 	int			instance;
 	struct nvme_effects_log *effects;
+	u64			nuse;
+	unsigned		ns_id;
 	int			lba_shift;
 	u16			ms;
 	u16			pi_size;
-	u16			sgs;
-	u32			sws;
-	u64			nuse;
 	u8			pi_type;
 	u8			guard_type;
+	u16			sgs;
+	u32			sws;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64			zsze;
 #endif
-- 
2.43.0


