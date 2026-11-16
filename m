Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8960A2609
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O6MYf0Mv;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=k6AeJWlG;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=InXG/Gt7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=k6AeJWlG;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=InXG/Gt7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SbQMvuUAaUCJxCyLbgVgjkEvS9uHHmg+wODL5Pb6qqI=; b=O6MYf0Mv5MUuKiS9TQtoW98BfP
	AQkGYClulZ7x4L67ww7J7hRfKvHW2GhOtBqPeeTRgF8TwJD/nrVVlt9dsOWR0FL8x2VHhPOXoyp3u
	qxLB8sUoB/S5d0sOpWm+d+PNNjjzphri4+J98X4Z0xOQMTgtEsnKPB5iOjlMQLUZYmHTJxbWrcqdz
	TprKI1wk+fI0gECqAJAOtYOe+BjP0qJjce8/8PDAnDPGzyhTdPMCLzOO/7zPba9HlcAIlw6o2jidh
	MgsSu0/f3UO/v87EhqGh8Y3WLQNKIJLQ3sg6I918K8JFrqYdFo7IdA736Y9TsuDNZvVtDtprPquXV
	Vnx2t1Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwYK-00000002ZPD-0dgJ;
	Mon, 16 Nov 2026 13:15:20 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwYG-00000002ZNN-3UvP
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 13:15:18 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AEF61F823;
	Mon, 16 Nov 2026 13:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794834915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbQMvuUAaUCJxCyLbgVgjkEvS9uHHmg+wODL5Pb6qqI=;
	b=k6AeJWlGuKY+PJ9SVs/2oQA7jMWAzIoTo9As9NadFRLFkf3Q1YR6EZRGRyT7Xx9zLVfKb/
	KBAb1HvUI8FAWLlb7kRciTf7zcnzB1Zrlw0KNhtadAxoCD5cYgoHC9ATZYBaUOF5x6YSJh
	ejrO2temGndMpnvYLmXBy5eptIoCfDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794834915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbQMvuUAaUCJxCyLbgVgjkEvS9uHHmg+wODL5Pb6qqI=;
	b=InXG/Gt7mYuLY+QU/TrCSUyjU6J4SWiLdcnqru3iCszinM7w44qjjuoNww5nmj6MIg38oa
	SVn9a3itcvaURNAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794834915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbQMvuUAaUCJxCyLbgVgjkEvS9uHHmg+wODL5Pb6qqI=;
	b=k6AeJWlGuKY+PJ9SVs/2oQA7jMWAzIoTo9As9NadFRLFkf3Q1YR6EZRGRyT7Xx9zLVfKb/
	KBAb1HvUI8FAWLlb7kRciTf7zcnzB1Zrlw0KNhtadAxoCD5cYgoHC9ATZYBaUOF5x6YSJh
	ejrO2temGndMpnvYLmXBy5eptIoCfDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794834915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbQMvuUAaUCJxCyLbgVgjkEvS9uHHmg+wODL5Pb6qqI=;
	b=InXG/Gt7mYuLY+QU/TrCSUyjU6J4SWiLdcnqru3iCszinM7w44qjjuoNww5nmj6MIg38oa
	SVn9a3itcvaURNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E85051334C;
	Mon, 16 Nov 2026 13:15:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VfayMOIB+2rcGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 13:15:14 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 8DB2C24E10; Mon, 16 Nov 2026 14:15:10 +0100 (CET)
Date: Mon, 16 Nov 2026 14:15:10 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 15/17] loop: use kiocb_write_iter()
Message-ID: <n2q74w47baqlgngqsmdhodjp4qbkdcaxomjcjpkxojybg6zfhv@qy7ksqfo2z3h>
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
 <20261116-work-fs-frozen_writes-v2-15-ecc4a2aac40e@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-work-fs-frozen_writes-v2-15-ecc4a2aac40e@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_051517_056528_4275FD47 
X-CRM114-Status: GOOD (  20.01  )
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

On Mon 16-11-26 12:03:55, Christian Brauner wrote:
> Use the new helpers instead of open-coding freeze protection for writes
> to the backing file.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d2f29aadabcc1..872d78006b131 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -325,8 +325,7 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>  		return;
>  	kfree(cmd->bvec);
>  	cmd->bvec = NULL;
> -	if (req_op(rq) == REQ_OP_WRITE)
> -		kiocb_end_write(&cmd->iocb);
> +	kiocb_end_write_iter(&cmd->iocb);
>  	if (likely(!blk_should_fake_timeout(rq->q)))
>  		blk_mq_complete_request(rq);
>  }
> @@ -395,10 +394,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  		cmd->iocb.ki_flags = 0;
>  	}
>  
> -	if (rw == ITER_SOURCE) {
> -		kiocb_start_write(&cmd->iocb);
> -		ret = file->f_op->write_iter(&cmd->iocb, &iter);
> -	} else
> +	if (rw == ITER_SOURCE)
> +		ret = kiocb_write_iter(&cmd->iocb, &iter);
> +	else
>  		ret = file->f_op->read_iter(&cmd->iocb, &iter);
>  
>  	lo_rw_aio_do_completion(cmd);
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

