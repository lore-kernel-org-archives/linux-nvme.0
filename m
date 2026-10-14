Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74B7CC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=; b=GzrtcgB5IO+CVAH1f0Ra5zyZC9
	Ex8bA4Qu1s1G1K0ZmVBB6uY3DCyM90ebALItV9UhYbcMbKKt3I6zSn8S5j8OWG7NGJlLX6JF5RqCH
	Ob3+W8+cGvz5Jdc8SQ3uN22K52UH74SfoxWj8IuiM+DWwokLGvt1ubvlWcnNuFNlS/glxpUkD1WnR
	a8gXLT9zcEDz0IpEU9AJ6XFZjJhAsjyD4ErzNbeQEvw4MLdg2SC9MeNq0jLtLZhl4D+XLnaaFMjyg
	dBalhEHChB129G7IrCCrFUdsd6FOnfujzRyxfREKFNyzlQXkx0ufKrVwLIUcqfYJWiSKzr+Xhc2+c
	m+E8yE6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGthZ-0000000Enfz-1LXs;
	Wed, 14 Oct 2026 07:47:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGthW-0000000Endf-29SG
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 07:47:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=; b=SnzYb0jamvonVrNb4CGfYnG54d
	q4tRQFdsEgJvKJ5j9d+Rp8XGq+64XyoE7oQqFCFolff9VY/V9mQLRJ8CLW/QivxiaHJOTsmvvmjtH
	uQh5OSf1dYKnXzT1GETfB+462VWXZ6kbHd4BTL8sV7uLCpjzBHgDzre3SJkiiyGBEpwlUuyDkO4cY
	fmDQdJK+NPdFjvcZvdtCnSztpyyBjSAAVSgaAwTlA7YQcKIFQWmlTOuZg2vJUuSPdoXmmizlz1kso
	frADbe9q68oU9495NvWZZpyZbgA88luyRINuxm4Z7tjS6Yvj6sft+lzNa2knuYoJ0RjREu1siV6z0
	zRJmW6cw==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGthT-0000000GSto-0vrL
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 07:47:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEF1E1F7C9;
	Wed, 14 Oct 2026 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=;
	b=1rKGJwfLGtGUtPKk7PG1ULitToQnzBBj5E2n40XaDTjMG37x5oXj10u8q3AymyafFuziel
	+QBHDSFBTlJWBpu8EYyDBDt61mzAn3BiiuMCwtEw/HcYlmxmCzxbI6NBSknY3Kk01wNskp
	70bADXAfFnf2JAMOYv8a5ryOc7/B/CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=;
	b=itqyUvXdYVJce8n7XuWNC8k1ho6fD/j2YyFx6uQpCC0Pz8ZzNJFmicdFYSusHW1LHU9k4h
	P++Rm69CjHGXWtAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=;
	b=1rKGJwfLGtGUtPKk7PG1ULitToQnzBBj5E2n40XaDTjMG37x5oXj10u8q3AymyafFuziel
	+QBHDSFBTlJWBpu8EYyDBDt61mzAn3BiiuMCwtEw/HcYlmxmCzxbI6NBSknY3Kk01wNskp
	70bADXAfFnf2JAMOYv8a5ryOc7/B/CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgfewhS/Qo0qSoCFFBIIYpTqvWeEcsQsEgvekjT+eA=;
	b=itqyUvXdYVJce8n7XuWNC8k1ho6fD/j2YyFx6uQpCC0Pz8ZzNJFmicdFYSusHW1LHU9k4h
	P++Rm69CjHGXWtAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0958133F1;
	Wed, 14 Oct 2026 07:46:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Gk6JXAzz2qyOQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:46:56 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 14 Oct 2026 09:46:40 +0200
Subject: [PATCH 2/5] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-fabrics-isolcpu-v1-2-355156be27b2@kernel.org>
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
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_MATCH_TO(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL67935bhfdkbndpbo95z3ogoo)];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_084659_664410_4496C171 
X-CRM114-Status: GOOD (  19.58  )
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

Since commit a46c27026da1 ("blk-mq: don't schedule block kworker on
isolated CPUs") isolated CPUs are removed from hctx->cpumask.  That
commit assumed the mask is only used for kworker placement and CPU
offline handling, but blk_mq_alloc_request_hctx uses it to pick the
software context of the request.  If only isolated CPUs are mapped to a
hardware context, the mask is empty and blk_mq_alloc_request_hctx fails
with -EXDEV, although the isolated CPUs still submit I/O to it.

The nvme fabrics transports allocate the Connect command for every I/O
queue this way, so connecting a controller fails with isolcpus=domain
or an isolated cpuset partition as soon as a hardware context only has
isolated CPUs.

Passthrough requests are inserted directly into hctx->dispatch, so
their software context only selects the CPU the completion runs on and
the hint for freeing the tag.  Use the software context of an online CPU
which is neither isolated from the scheduler domains nor from managed
interrupts for them.  Other requests and inactive hardware contexts
still fail.

Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..79fb08400c48 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -697,6 +697,25 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
+/*
+ * Return an online CPU which is neither isolated from the scheduler domains
+ * nor from managed interrupts, or nr_cpu_ids if there is none.
+ */
+static unsigned int blk_mq_housekeeping_cpu(void)
+{
+	unsigned int cpu;
+
+	rcu_read_lock();
+	for_each_online_cpu(cpu) {
+		if (!cpu_is_isolated(cpu) &&
+		    housekeeping_test_cpu(cpu, HK_TYPE_MANAGED_IRQ))
+			break;
+	}
+	rcu_read_unlock();
+
+	return cpu;
+}
+
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	blk_opf_t opf, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
@@ -747,8 +766,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids)
-		goto out_queue_exit;
+	if (cpu >= nr_cpu_ids) {
+		/*
+		 * Isolated CPUs are not part of hctx->cpumask, so it can be
+		 * empty although online CPUs are mapped to this hardware
+		 * context.  Passthrough requests are inserted directly into
+		 * hctx->dispatch, so use the software context of a
+		 * housekeeping CPU for them.  Inactive hardware contexts have
+		 * no online CPU left.
+		 */
+		if (!blk_op_is_passthrough(opf) ||
+		    test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state))
+			goto out_queue_exit;
+		cpu = blk_mq_housekeeping_cpu();
+		if (cpu >= nr_cpu_ids)
+			goto out_queue_exit;
+	}
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (q->elevator)

-- 
2.56.0


