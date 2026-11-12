Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD3606A8A2
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aFyVT/z9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OwYUwF+T;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0mhjkOKZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OwYUwF+T;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0mhjkOKZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=; b=aFyVT/z9pnRU7aF66/8hek4HcH
	g7T4dZ9A+MuvnsDMLvffMHCyoR6bsi9xgBCnkwdA1iARKCYLN9hL8HDfkHXYygW8kJ18r3ATaGZfp
	x1kw5YIdNJe3KE7MKEzPPnznTRf3G5ur9CS2xxTJ7AhoWgteGrvKprX7wedm/NbEP9Guv+6NQ95eH
	Eu0ia50trr0gRXxQTsWiYD062uJBmwaGIst+lr3rpZ49y+4xnYU7XQbHRw6RmvT1MUuqqGRbEKRGt
	MJbKl3Aethe1/OqPeCuttUwmfxkRGExepa+BWTUqu0t/wxRmnbdJd9poLxDHESzW7wnaeXkv8k/oe
	RCieNt2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQoZ-00000009IrZ-2usf;
	Thu, 12 Nov 2026 09:09:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQoX-00000009Ir6-1Q4w
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 09:09:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3854B1F390;
	Thu, 12 Nov 2026 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794474587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=;
	b=OwYUwF+ThKZk+4PAeOfovoKumVG42D4uOCNPDwI5m+lj+VPAGvAGMjdZeHUTtkhReCXLGe
	ko3Xt9hw5UIVNwbUJ/oEZArmXoFj5JwlhMgkNcJTp8jQnkURJLUIZlol3nuGyIV9xsEINt
	wBnu2Gbf1dWUVjObsbyBCHGsEkQkMEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794474587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=;
	b=0mhjkOKZdj37Nev2rjX+G2XzkaBUF1DfkKh/T9yga2ENd3vdfgHoZDBspb1nBpWJCWT95Q
	r/bwQdrwYKi9ItCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OwYUwF+T;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0mhjkOKZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794474587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=;
	b=OwYUwF+ThKZk+4PAeOfovoKumVG42D4uOCNPDwI5m+lj+VPAGvAGMjdZeHUTtkhReCXLGe
	ko3Xt9hw5UIVNwbUJ/oEZArmXoFj5JwlhMgkNcJTp8jQnkURJLUIZlol3nuGyIV9xsEINt
	wBnu2Gbf1dWUVjObsbyBCHGsEkQkMEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794474587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCDrkEYxV2ULCH5YyNEcivwL1pA4Zyk7Fz79VpMLnvA=;
	b=0mhjkOKZdj37Nev2rjX+G2XzkaBUF1DfkKh/T9yga2ENd3vdfgHoZDBspb1nBpWJCWT95Q
	r/bwQdrwYKi9ItCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F216C134A0;
	Thu, 12 Nov 2026 09:09:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ejR1M1qC9WoocQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 12 Nov 2026 09:09:46 +0000
Date: Thu, 12 Nov 2026 10:09:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>, 
	Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Maurizio Lombardi <mlombard@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <a979c78b-40f9-4777-b76f-fb257120a93c@flourine.local>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 3854B1F390
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_010949_550006_F81230A9 
X-CRM114-Status: GOOD (  21.52  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 03:57:22PM +0100, Daniel Wagner wrote:
> blk_mq_alloc_request_hctx uses the first online CPU in hctx->cpumask to
> select the software context for a request.
> 
> Since commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> isolated CPUs"), hctx->cpumask excludes isolated CPUs. If a hardware
> context is mapped only to isolated CPUs, the mask is empty and
> blk_mq_alloc_request_hctx fails with -EXDEV.
> 
> The NVMe fabrics transports use blk_mq_alloc_request_hctx to allocate
> the Connect command for each I/O queue. As a result, connecting to a
> controller can fail when using isolcpus=domain or an isolated cpuset
> partition.
> 
> Passthrough requests bypass the software queues and go directly to
> hctx->dispatch. Their software context is only used to select the
> completion CPU and as a hint when freeing the tag.
> 
> Use the software context of an online housekeeping CPU for passthrough
> requests.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> Tested-by: Maurizio Lombardi <mlombard@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Connecting a fabrics controller fails when all CPUs of a hardware
> context are isolated with isolcpus=domain or an isolated cpuset
> partition. Since commit a46c27026da1 ("blk-mq: don't schedule block
> kworker on isolated CPUs") the CPU mask of such a hardware context is
> empty and blk_mq_alloc_request_hctx() fails the Connect command with
> -EXDEV. This patch lets passthrough requests use the software context
> of a housekeeping CPU instead.
> 
> The nvme fabrics fixes from v1 (patches 1 and 3-5) are in nvme-7.4, so
> only the blk-mq patch is left. The blktest for this patch is nvme/070,
> posted separately.

Keith, Jens: any chance to get this one picked up?

Thanks,
Daniel

