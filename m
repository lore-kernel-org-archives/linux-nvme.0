Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177D606A8A0
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jkD+OSov;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cKZF/ZyB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CYpRWt71;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=jCp55ag1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=p54j3YyA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3rOHcYKDuCkzllIwgWTNHupYKEaBKVPW8ZfJ4jsjsnY=; b=jkD+OSovehsgNWiKn3mCkIEDsV
	mvPVg+Bcw3E92fWYqoegzi09E0Gn0ZVW2BOeU3EeLZeUkxixpVk6UQCb/VZkoRs/1ejUc5lkWNqTQ
	56m8sx6LizybyDfBvELor7Zh9ZA+U/jJ818S6gQACwpQaeLMrv53rObEpCtLjuvHVvbwzd2/acTfC
	rqS3nWIDdnFO9Q+P2vRXedsyAURxOU2h8r5+ybyR8sWX0IdAcXLcUZE02C/BsA0nvpt9smOWFggP6
	JrcXfzg+QIpeEwXBeDylgY9CmFJt2U2zCVS3YDPxHCV9z8WChXocYofAZDg/VzZDk6gAOUv4LDpVm
	vKw3rV+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwWN-00000002Yj0-0uVh;
	Mon, 16 Nov 2026 13:13:19 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwWK-00000002Yif-0Kr8
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 13:13:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B59E2227B;
	Mon, 16 Nov 2026 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794834794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rOHcYKDuCkzllIwgWTNHupYKEaBKVPW8ZfJ4jsjsnY=;
	b=cKZF/ZyBbJtt7UFcHcCTjKShsPHrX21DEM8i2T8cE7M9ckwnLGFyl/u1dkQaVjeua6ROhJ
	gPFn1bf1D0isbPidzsAbzb4OWFlkRHG0th0aC9Qq16NPeqaAG0uJ/5i61Q5+UCysFfUHxN
	N06r9wT0lmc5RC/YR/931fHQUPj+vg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794834794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rOHcYKDuCkzllIwgWTNHupYKEaBKVPW8ZfJ4jsjsnY=;
	b=CYpRWt71Adz8aH4s7dnF8T3DMbwBS0U+6ypL3ScgJtcDPKhzCMVRBaqqBWpqvGnPs8qMMP
	LmzJ1qVSl9GwwSBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jCp55ag1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p54j3YyA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794834793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rOHcYKDuCkzllIwgWTNHupYKEaBKVPW8ZfJ4jsjsnY=;
	b=jCp55ag1gZEGkX0JhYiXQzBajJbaPcJ2vqPElOKhfkyuQrRHDlb/o45ccZYcv0FcZDjOY9
	A532D2V+mUonBzk51vLsWu954m5PnQPs7HeIDzworG1DtqqlvixEVZ4fbnKDUuqlxpbnSN
	WLLRpjQ53YKrOOji8XWfa7/hhgYYZBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794834793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rOHcYKDuCkzllIwgWTNHupYKEaBKVPW8ZfJ4jsjsnY=;
	b=p54j3YyAIKs0HICegHM6DyMWk53ACB8JQsl7rKblCRzO4I9+kntb80qU2poX5vzyeQrK7y
	sg45YSSK8oBEmGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CCB01334C;
	Mon, 16 Nov 2026 13:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JrOpOGgB+2ruFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 13:13:13 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id B103224E0A; Mon, 16 Nov 2026 14:13:12 +0100 (CET)
Date: Mon, 16 Nov 2026 14:13:12 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 02/17] fs: add kiocb_write_iter() and
 kiocb_end_write_iter()
Message-ID: <pypknyxrb7k5faks3ygujfalm55c2diua5jqfvryawnhsi5iry@fahmwbeatcur>
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
 <20261116-work-fs-frozen_writes-v2-2-ecc4a2aac40e@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-work-fs-frozen_writes-v2-2-ecc4a2aac40e@kernel.org>
X-Rspamd-Queue-Id: 2B59E2227B
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
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_051316_540388_3C929B61 
X-CRM114-Status: GOOD (  32.92  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 16-11-26 12:03:42, Christian Brauner wrote:
> Calling ->write_iter() with a kiocb of your own means taking freeze
> protection, calling ->write_iter() and dropping freeze protection again
> unless the write was queued. The completion callback then has to know
> whether it completes a write that still holds freeze protection. loop
> open-codes this and keys the completion on the request op. zloop, the
> nvme target and target fileio need the same. Christoph pointed out that
> open-coding this everywhere is fragile (cf. [1]).
> 
> Add kiocb_write_iter(). It takes freeze protection, marks the kiocb
> with IOCB_WRITE like aio, io_uring and cachefiles do and calls
> ->write_iter(). If the write wasn't queued freeze protection is dropped
> right away. With IOCB_NOWAIT it only tries to get freeze protection and
> fails with -EAGAIN instead of waiting for the thaw.
> 
> kiocb_end_write_iter() drops freeze protection if the kiocb still holds
> it and clears IOCB_WRITE. So a completion callback can call it for any
> I/O. That matters for drivers that complete I/O that wasn't queued
> through the same callback and for drivers that reuse their kiocbs.
> 
> [1]: https://lore.kernel.org/r/20261116064654.GA2964@lst.de
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index eefc2c9d4af19..0b66a09fb686a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2840,6 +2840,54 @@ static inline void kiocb_end_write(struct kiocb *iocb)
>  	sb_end_write(inode->i_sb);
>  }
>  
> +/**
> + * kiocb_end_write_iter - drop write access after kiocb_write_iter()
> + * @iocb: the io context the write was submitted with
> + *
> + * Drop write access if @iocb still holds it and clear IOCB_WRITE. This
> + * does nothing for reads and for writes kiocb_write_iter() already
> + * finished. So the completion callback can call it for any I/O.
> + */
> +static inline void kiocb_end_write_iter(struct kiocb *iocb)
> +{
> +	if (!(iocb->ki_flags & IOCB_WRITE))
> +		return;
> +	iocb->ki_flags &= ~IOCB_WRITE;
> +	kiocb_end_write(iocb);
> +}
> +
> +/**
> + * kiocb_write_iter - submit a write with write access to the superblock
> + * @iocb: the io context to submit the write with
> + * @iter: the data to write
> + *
> + * Get write access, mark @iocb with IOCB_WRITE and call ->write_iter().
> + * A write that wasn't queued drops write access before this returns. A
> + * queued write keeps it until the completion callback calls
> + * kiocb_end_write_iter(). With IOCB_NOWAIT this fails with -EAGAIN
> + * instead of waiting for a frozen filesystem.
> + *
> + * Return: On success the number of bytes written or -EIOCBQUEUED is
> + *         returned. On failure a negative error code is returned.
> + */
> +static inline ssize_t kiocb_write_iter(struct kiocb *iocb,
> +				       struct iov_iter *iter)
> +{
> +	ssize_t ret;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!kiocb_start_write_trylock(iocb))
> +			return -EAGAIN;
> +	} else {
> +		kiocb_start_write(iocb);
> +	}
> +	iocb->ki_flags |= IOCB_WRITE;
> +	ret = iocb->ki_filp->f_op->write_iter(iocb, iter);
> +	if (ret != -EIOCBQUEUED)
> +		kiocb_end_write_iter(iocb);
> +	return ret;
> +}
> +
>  /*
>   * This is used for regular files where some users -- especially the
>   * currently executed binary in a process, previously handled via
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

