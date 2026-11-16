Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED22606A89B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ee9r+Onl;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qsi2TCNY;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sPuHxUiF;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=G0qYdWpi;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iHmh5dIA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lTWHtPkfbVykhjqpLO1VySVvAD38nuNNKIznkJylwvU=; b=Ee9r+OnloDzl7mYXkf+ScF2gVh
	9V9Ed3CMBx+H74gaIjTj23sQz4JVGZZHylGfDtL9F3QKrVPibegu/ZsjK4t4rtb51+DDRDWAKZ43L
	kbszCZzRSpXDBrrm6xS9aWjDWs7Q1jW8c7lEts3lWzUO1XezL5Bdvy+5ydfWgRkDOcgnGpXasOYTq
	zTETbrxmOzkg4O3M5BgClU+zKP26ryhir8o5qiEiyJ2TIQtgwDPkRxqwAFX8NqPCkcK7b7UH0JjO6
	jP4dqWsWZDE50gEc9RExvhWzAHSo7VjQPqEq7p4UsKD75quOSSaOQ8kC+HQtvJQtmOHr1WRSCVrZR
	TLSZMr8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwZw-00000002Zto-2kQP;
	Mon, 16 Nov 2026 13:17:00 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwZv-00000002ZtG-01Wi
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 13:17:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2FAF1F7D2;
	Mon, 16 Nov 2026 13:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794835017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTWHtPkfbVykhjqpLO1VySVvAD38nuNNKIznkJylwvU=;
	b=qsi2TCNYjsGnplxchNmN3wBRWH2niNG5KnKKQoaZG6n4gEKjonz8TXCDDjZKhCqS/ShFCN
	5HXys5ra2q+Bp6O9OCgIrzz6fohusABreHzw8eGZ71fJOXNsy6QskFVlAAiJHcsb2KP89U
	4AB6Xsag8aiiBcEW2rPRXVFXICidbIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794835017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTWHtPkfbVykhjqpLO1VySVvAD38nuNNKIznkJylwvU=;
	b=sPuHxUiFGCjSIp0Vm+oFCrrpWmbjHl45ICax/gVjIdDJ4O2E/JKfxJPL2QA0sJF29SfRaD
	ZyWbZT+nSbSopLAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G0qYdWpi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iHmh5dIA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794835016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTWHtPkfbVykhjqpLO1VySVvAD38nuNNKIznkJylwvU=;
	b=G0qYdWpiUhhmF++tjYNWvuHVFW2mbK0GcGaTvYywn7KojG9EsNQZkOQk26yyYHQY3sbwGy
	N7cmGCnBM1j6VFsmNwf8QpSBCwTm3LfuIvy4sT2sqOHTtm4RXL0XbY3Pg4WMmiJUELQOUM
	kKSR26KfImG7xEmknWwFVbQ3QnX/Nvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794835016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTWHtPkfbVykhjqpLO1VySVvAD38nuNNKIznkJylwvU=;
	b=iHmh5dIApmfNgjjn0nNnxPyON95mel3ih2Op0PgAHE6WdEwPeTubOoS0Kqkdys7uHbGvw5
	z+7h8etg4tHXqoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D2C1334C;
	Mon, 16 Nov 2026 13:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gcsFJEgC+2oiHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 13:16:56 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 4764324E17; Mon, 16 Nov 2026 14:16:56 +0100 (CET)
Date: Mon, 16 Nov 2026 14:16:56 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 16/17] fs: use kiocb_write_iter() in
 vfs_iocb_iter_write()
Message-ID: <4s7yphneo2xw4pitednbhotih7ymlycv4gc65oistoa4pslfzd@dy5pe24utp3k>
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
 <20261116-work-fs-frozen_writes-v2-16-ecc4a2aac40e@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-work-fs-frozen_writes-v2-16-ecc4a2aac40e@kernel.org>
X-Rspamd-Queue-Id: E2FAF1F7D2
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -13.01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_051659_189584_29B08238 
X-CRM114-Status: GOOD (  20.65  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 16-11-26 12:03:56, Christian Brauner wrote:
> vfs_iocb_iter_write() open-codes what kiocb_write_iter() does. Use it.
> The kiocb is marked with IOCB_WRITE now so the caller can drop freeze
> protection with kiocb_end_write_iter().
> 
> This also means that an IOCB_NOWAIT write fails with -EAGAIN instead of
> waiting for a frozen filesystem. No caller passes IOCB_NOWAIT today.
> overlayfs and fuse passthrough don't set FMODE_NOWAIT and cachefiles
> and nfsd don't ask for it.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 6767283108991..eca0aa73e5a4d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -923,7 +923,7 @@ ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
>  EXPORT_SYMBOL(vfs_iter_read);
>  
>  /*
> - * Caller is responsible for calling kiocb_end_write() on completion
> + * Caller is responsible for calling kiocb_end_write_iter() on completion
>   * if async iocb was queued.
>   */
>  ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
> @@ -946,10 +946,7 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
>  	if (ret < 0)
>  		return ret;
>  
> -	kiocb_start_write(iocb);
> -	ret = file->f_op->write_iter(iocb, iter);
> -	if (ret != -EIOCBQUEUED)
> -		kiocb_end_write(iocb);
> +	ret = kiocb_write_iter(iocb, iter);
>  	if (ret > 0)
>  		fsnotify_modify(file);
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

