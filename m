Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0E606A31B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GXxkWDdN;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AtXUaZHV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jhdASn89;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AtXUaZHV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jhdASn89
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KkdOQF0m+VfCrOGlCq2herx/7lAkHYLAIwNn9wrEEEM=; b=GXxkWDdNAszLfYtzG7Si3eh9bY
	YlDCwqWzBGS/84Z1OToxQlrW1J5KvSSSGClz76LD7scxkucJCxHgoqSvev4Moxa8EG4JOt8G9cJae
	H8Nhvy9N9nMKsVrSaflmK7KSJ+0sKSoxUI+P9JZmQVGYPWn5W2I/eOuMhkuVZNCJpkFdr9p/ziH8p
	vlCKJXeoO3iHnwdoG7TQGE3QZI0KWPVdsTZhxY8eF1ZIBtblqm+6btC7/uQXlgVun7/nCUxcEB8Dn
	KtQlba/EASAVcvfYVoHpkDMKDcAtl6VbZktLS6ore7jirluPqB7J8ou9tUWeqtAufT2d/X+WtA831
	JIuvTwpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8r4-00000009ee4-43yb;
	Tue, 20 Oct 2026 12:22:10 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8r2-00000009edh-0CSD
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 12:22:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB6EE21C13;
	Tue, 20 Oct 2026 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792498924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkdOQF0m+VfCrOGlCq2herx/7lAkHYLAIwNn9wrEEEM=;
	b=AtXUaZHVbjvFx/np1/j9/VTGr0IopTQ2XXR3qiwy9WQNdGorBP59AmoTxJJ8LHSsSU16JN
	SdwAcffH/+cK8b62XwG0tcV05DR5xG7AT3+/UioS44pMoyAOJaC7FsIKJvPzGD7v6/0w+d
	JxcUsOP6S3/k/yRdwGgYbL/WLvjCAg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792498924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkdOQF0m+VfCrOGlCq2herx/7lAkHYLAIwNn9wrEEEM=;
	b=jhdASn89S2lCXY1P00Y6QutuRJylGB7WSBYACwCBk+JPWOr+pk2UmBCko+qgSUmLg85iqH
	P/+dan8VS8LOYcBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792498924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkdOQF0m+VfCrOGlCq2herx/7lAkHYLAIwNn9wrEEEM=;
	b=AtXUaZHVbjvFx/np1/j9/VTGr0IopTQ2XXR3qiwy9WQNdGorBP59AmoTxJJ8LHSsSU16JN
	SdwAcffH/+cK8b62XwG0tcV05DR5xG7AT3+/UioS44pMoyAOJaC7FsIKJvPzGD7v6/0w+d
	JxcUsOP6S3/k/yRdwGgYbL/WLvjCAg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792498924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkdOQF0m+VfCrOGlCq2herx/7lAkHYLAIwNn9wrEEEM=;
	b=jhdASn89S2lCXY1P00Y6QutuRJylGB7WSBYACwCBk+JPWOr+pk2UmBCko+qgSUmLg85iqH
	P/+dan8VS8LOYcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EA9D136CC;
	Tue, 20 Oct 2026 12:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RSgUGuxc12oiOQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 12:22:04 +0000
Date: Tue, 20 Oct 2026 14:21:59 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/18] nvme-fc: Hold inflight requests while in
 FENCING state
Message-ID: <d9563967-9ddb-4cd7-9149-d1f37522e1fa@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-16-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920182936.2317916-16-mkhalfella@purestorage.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_052208_231074_3BD09A85 
X-CRM114-Status: GOOD (  15.85  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Sep 20, 2026 at 11:28:13AM -0700, Mohamed Khalfella wrote:
>  static void
> -nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
> +__nvme_fc_teardown_association(struct nvme_fc_ctrl *ctrl)
>  {
>  	struct nvmefc_ls_rcv_op *disls = NULL;
>  	unsigned long flags;
>  
> -	if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
> -		return;
> -
>  	spin_lock_irqsave(&ctrl->lock, flags);
>  	set_bit(FCCTRL_TERMIO, &ctrl->flags);
> -	ctrl->iocnt = 0;
> +	atomic_set(&ctrl->iocnt, 0);
>  	spin_unlock_irqrestore(&ctrl->lock, flags);
>  
>  	__nvme_fc_abort_outstanding_ios(ctrl, false);
> @@ -3287,11 +3328,18 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>  	nvme_fc_abort_aen_ops(ctrl);
>  
>  	/* wait for all io that had to be aborted */
> +	wait_event(ctrl->ioabort_wait, atomic_read(&ctrl->iocnt) == 0);
>  	spin_lock_irq(&ctrl->lock);
> -	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
>  	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
>  	spin_unlock_irq(&ctrl->lock);
>  
> +	/*
> +	 * Wait for a started nvme_fc_fcpio_done() to complete before we
> +	 * proceed with cancelling inflight requests. This guarantees a
> +	 * request is completed by one of the two codepaths, not both.
> +	 */
> +	synchronize_rcu();
> +

The synchronize_rcu() protects against nvme_cancel_tagset() racing with
an fcpio_done() for an op that completed normally and therefore wasn't
counted in iocnt. Wouldn't it be clearer to make the hold explicit in
op->state (e.g. FCPOP_STATE_HELD) and only complete held ops in
nvme_fc_flush_held_requests(), instead of using RCU as a barrier for
running callbacks?

