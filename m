Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4973CC6B2D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 07:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=93fUuD+RBsl4a1fQTBqHUJ5zmS67/SKmKYrMahKpKtA=; b=LlupBnzhea7tQWltG32/XlLwZ5
	ZHXliTNCFQXRrM8qgXTu8OBgcjDelN011MM+a/zvHoJGQx/l/F78HrOwbtg3yS+PpUBFClfxjEzZG
	UAXW7TCEB2pg5dZ0OrRmDDSpou7E9346MvOT8vmdNGLLAyVTCNWFoELNogAxErpzTTv8qNo3105Lj
	hybOAfI8slYQQqVkxk+j1ctbfy4oXut6uALWfmMLHD6RnjeeGIEVa4SAWRZsPh+0G/8mLiKKPk7eU
	ryUVPqvlhtvIg27DLXW1YTSfs6aaxn21PvJMfZcQEp2jKMtjR8lRb6grzwsR1ppMUU4GNe3/LerQZ
	XOec+91g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGthZ-0000000EngB-29CE;
	Wed, 14 Oct 2026 07:47:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGthW-0000000Endg-2BWq
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 07:47:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=93fUuD+RBsl4a1fQTBqHUJ5zmS67/SKmKYrMahKpKtA=; b=ggQZoIxe5dYGwCh94RYLX6jWmm
	kwU29BU5Nn9YtN3D9EcKSBGKpqnvXhCK5FB6BsofuzwZ8KVsQsxtmyFRO1ZFP2p5Tk5Q0JHLWe7rg
	Cz9pivE0JWuuC60LBvzwtUPEFi/kiZiDHkcVRlIMy0wDfK/TLga2ulqfUmM1wOoqARz7HzP2k0WBP
	rAgpM62iD/L3QauBmusIAJwB0K70BfuqjSqQdCSLePUf9r6HTSEQGJXCpdkK9+nnu/ntDR6UoaKpn
	wx5PxZdCCNn7N9jqARRlvYqupbr/A4IuKZggV1e7TsACytl1oX+CublLKyalt+DH/A2eF9DYsJT4K
	WgRKqyww==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGthT-0000000GSts-0v7j
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 07:47:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9DF31F8C3;
	Wed, 14 Oct 2026 07:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93fUuD+RBsl4a1fQTBqHUJ5zmS67/SKmKYrMahKpKtA=;
	b=N8ZhsNOhNrywn5EUiTBQAZHcOTufqiQcc2wXT2KAaAAGi7Okkn4HloRytqVaw/e7LRfjay
	rJ+RuMfRFcnP2+gwNVLGDUd14M8N3fmybdI4fk0BHuZEHMi18GGtnfOfTxV7rk2WL7Yz+R
	/PIIBnuCLospDYuwrGnwy7VrH8acHMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93fUuD+RBsl4a1fQTBqHUJ5zmS67/SKmKYrMahKpKtA=;
	b=K5p+qZ65YAda2kAZElc5rjQmHSYeApK5guMjcOmEvXhRAZ4acQCXLGnZ1XaF398knjdkwN
	d5pMNym3W0ATI0Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=N8ZhsNOh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K5p+qZ65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93fUuD+RBsl4a1fQTBqHUJ5zmS67/SKmKYrMahKpKtA=;
	b=N8ZhsNOhNrywn5EUiTBQAZHcOTufqiQcc2wXT2KAaAAGi7Okkn4HloRytqVaw/e7LRfjay
	rJ+RuMfRFcnP2+gwNVLGDUd14M8N3fmybdI4fk0BHuZEHMi18GGtnfOfTxV7rk2WL7Yz+R
	/PIIBnuCLospDYuwrGnwy7VrH8acHMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93fUuD+RBsl4a1fQTBqHUJ5zmS67/SKmKYrMahKpKtA=;
	b=K5p+qZ65YAda2kAZElc5rjQmHSYeApK5guMjcOmEvXhRAZ4acQCXLGnZ1XaF398knjdkwN
	d5pMNym3W0ATI0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80DBD133F1;
	Wed, 14 Oct 2026 07:46:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3ghiGXEzz2q2OQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:46:57 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:46:41 +0200
Subject: [PATCH 3/5] nvme-fabrics: reset io_queues before computing the
 queue mapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-fabrics-isolcpu-v1-3-355156be27b2@kernel.org>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A9DF31F8C3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_MATCH_TO(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RL71uuc3g3e76oxfn4mu5aogan)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_084659_673311_57FE2BA8 
X-CRM114-Status: GOOD (  14.22  )
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

nvmf_set_io_queues only sets the io_queues entries of the queue types it
hands out, but the array is reused on every reconnect.  When the
controller grants fewer queues on a reconnect, stale entries survive and
nvmf_map_queues maps CPUs to hardware contexts that don't exist anymore,
which crashes blk_mq_map_swqueue with a NULL pointer dereference.  E.g.
with nr_io_queues=8, nr_write_queues=8 and nr_poll_queues=8, 24 queues
are mapped 8/8/8 (default/read/poll).  If the controller grants only 16
queues on the reconnect, the poll map still starts at hardware context
16.

Clear the array before computing the new mapping.

Fixes: 6486199378a5 ("nvme-tcp: fix queue mapping when queue count is limited")
Fixes: 5651cd3c4336 ("nvme-rdma: fix queue mapping when queue count is limited")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 59f823dfbbcc..571de549fbaf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1125,6 +1125,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
 			u32 io_queues[HCTX_MAX_TYPES])
 {
+	memset(io_queues, 0, sizeof(*io_queues) * HCTX_MAX_TYPES);
+
 	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
 		/*
 		 * separate read/write queues

-- 
2.56.0


