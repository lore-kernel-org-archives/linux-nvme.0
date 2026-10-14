Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE015CC6B2C
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 07:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jY5uDs5ZYhzEMmozgqStfId9AG+h5B7c2v3Gd0MW/+A=; b=IOt/V49BIJrkTLPeUU+rPf5q78
	tLEhjvEgMiOkQW6SVMadE5oq5nMqEA8kVT4dzRsnl1E3MeSmVYUY/t4BxlR8SYAHqdbDXoXRlXcOR
	zA7w82sQ8FjloR3q6BqYZcWO0qE5CAL/bpWS1mjdW6snxK3/JfSzU8lUJYykBjsdkWUvPk0rL3uQK
	hWDyqLOv3dn21ivErh8oIUG0f6p0EWleMHr/3Y1c55FrjMTprHFJIxKiLxz+YUgngI5VfCIURle3a
	/gP4s3XvKaF9T1Jc+08wv0C580uuRx0qLwhmk7rX7eCjLSTPFk2o0bxPNKklJlRzOUA4B93wjeWgM
	DAOAB9/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGtha-0000000EnhH-1nxM;
	Wed, 14 Oct 2026 07:47:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGthY-0000000EneA-1g5O
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 07:47:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=jY5uDs5ZYhzEMmozgqStfId9AG+h5B7c2v3Gd0MW/+A=; b=YRAT2fC9NHc2IOHGGVVOK+6LQs
	zDhQLdSiAwO6tVcppTbe7O63rafqKTTTziKuOd8c/cfwVBpLqj/M/l2x91jM/1FkLFAELZ/1ZPyWt
	y3BwvqCcotoF/tJ+ixNoE5LZmNobDQw2VgR2zxsZYdox6S+vLG8IZ+beZnWYnm8xfDslNzRmzX6jU
	ZWHpJSJBo+7bZupodlDyaeorFXtSrUdXOqCRbLPmB4j5ry2Db1eQ9/RV/KiOsQ5YrLoIGvRmEq1r2
	LOr9mWtD9aI/VFpoC0IVVHnbxJ3TJfVYUgipRJJvECisldmqvdcE8it+Q/1mwat9gBkothyqdI7dM
	1s790d5g==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGthV-0000000GSuo-2H5r
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 07:47:03 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DE7F2210A;
	Wed, 14 Oct 2026 07:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jY5uDs5ZYhzEMmozgqStfId9AG+h5B7c2v3Gd0MW/+A=;
	b=WoGoHmWJnI+6kzfwl/E0FHJU+eTCu+pnLgU1Ok1mwBC+WnbKbrRQDZTSuYC76YmbVPcRyZ
	j1b4Jptwc93vfne5+tnEFyyE7c7dCsgcAuyeNEqeM4MmSwPsxgQag5wg7Mgxd3GdRWgYTe
	0BjJOqRP+tu0jYeq0SaD+yKz1cGM7UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jY5uDs5ZYhzEMmozgqStfId9AG+h5B7c2v3Gd0MW/+A=;
	b=raGNwvTopKDH9qU+gA5p444Xie7lvVChefJPII2wYy8m/dzFMstcEcuECmyt9rYvgySrf0
	PhnFct9wCzxEcrAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WoGoHmWJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=raGNwvTo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jY5uDs5ZYhzEMmozgqStfId9AG+h5B7c2v3Gd0MW/+A=;
	b=WoGoHmWJnI+6kzfwl/E0FHJU+eTCu+pnLgU1Ok1mwBC+WnbKbrRQDZTSuYC76YmbVPcRyZ
	j1b4Jptwc93vfne5+tnEFyyE7c7dCsgcAuyeNEqeM4MmSwPsxgQag5wg7Mgxd3GdRWgYTe
	0BjJOqRP+tu0jYeq0SaD+yKz1cGM7UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jY5uDs5ZYhzEMmozgqStfId9AG+h5B7c2v3Gd0MW/+A=;
	b=raGNwvTopKDH9qU+gA5p444Xie7lvVChefJPII2wYy8m/dzFMstcEcuECmyt9rYvgySrf0
	PhnFct9wCzxEcrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FEFE133F1;
	Wed, 14 Oct 2026 07:47:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HCq5BHQzz2q9OQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:47:00 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:46:43 +0200
Subject: [PATCH 5/5] nvme-fabrics: clear the poll map if no poll queues are
 mapped
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-fabrics-isolcpu-v1-5-355156be27b2@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>, 
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Aaron Tomlin <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.16.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_MATCH_TO(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL71uuc3g3e76oxfn4mu5aogan)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5DE7F2210A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_084701_909616_EBE988F1 
X-CRM114-Status: GOOD (  15.17  )
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

From: Daniel Wagner <wagi@kernel.org>

blk_mq_alloc_tag_set sets the nr_queues of every map to nr_hw_queues.
When nr_poll_queues is set but no queues are left for polling,
nvmf_map_queues skips the poll map and leaves it this way, with all CPUs
mapped to hctx 0.  The queue then claims poll support, polled I/O ends
up on hctx 0, which isn't a poll queue, and hctx 0 is marked as a poll
hctx, so even the Connect command of the first I/O queue is marked as
polled.

Clear the poll map when no poll queues are mapped, so polled I/O is
rejected with -EOPNOTSUPP.

Fixes: 1a9460cef571 ("nvme-tcp: support simple polling")
Fixes: 5651cd3c4336 ("nvme-rdma: fix queue mapping when queue count is limited")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fabrics.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 27a8ce51d2b3..3d7ad86c1955 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1199,6 +1199,13 @@ void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
 			io_queues[HCTX_TYPE_DEFAULT] +
 			io_queues[HCTX_TYPE_READ];
 		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
+	} else {
+		/*
+		 * blk_mq_alloc_tag_set sets nr_queues of all maps to
+		 * nr_hw_queues.  Clear the poll map, otherwise the queue claims
+		 * poll support and polled I/O ends up on hctx 0.
+		 */
+		set->map[HCTX_TYPE_POLL].nr_queues = 0;
 	}
 
 	dev_info(ctrl->device,

-- 
2.56.0


