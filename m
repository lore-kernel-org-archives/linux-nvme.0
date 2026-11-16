Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2C606A329
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BEVXHooc;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=I8euH6Il;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qwmTbebB;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pSgqltap;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BfFSlZfG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aPB7W49SWsBu17qqGr8ORha9SlgtVrvHW1dZhYH+JXU=; b=BEVXHooc7o3ufbdyCfeppuamnS
	rKl9gIDIpJCtwocmkx/xIb8icFfiaj8vVFNJfTGVachDpY2VRosY+8f+tAt5LrhAnWWVKME9a/tz/
	FZPS3RSO598FXGfwKij6a2WENZAnEnvr1Bxnmn23GNBH9KNrgKp1BgqOeycREjekO+V3AdDl28qjP
	p7QHjN45FtBzYuMORjZRtEdvDx2MJKkdjse0wxeoIoIMOEV6AS0HIZn+Q6RwUlTIj2CBZOF1JoHc4
	DI8a0KukBCuX1sAlex8XdbiEzUnLpUy/e4AApSCl7nfF1pKuJPUW3yd3DZRAs9bOqstvqJOSHJE3e
	7aM2tg2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwUm-00000002YYW-3POR;
	Mon, 16 Nov 2026 13:11:40 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwUj-00000002YXg-0kxb
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 13:11:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F84D1F7E2;
	Mon, 16 Nov 2026 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794834695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPB7W49SWsBu17qqGr8ORha9SlgtVrvHW1dZhYH+JXU=;
	b=I8euH6IlQMpNAUEBl1FpKwvTnQyWvu1d5+pITe3P72DU+tp+gRy3yicid9gtfdxU+lTbso
	Rrz3qgHiixhF9J8sjk7Kr6zIsO6GAfI+Kit/XpLmeD6+To5mA70BV+ae75eUL4PIOtGDas
	ID7BPgofKV5nJHkFndl5+q+9Dx4f4mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794834695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPB7W49SWsBu17qqGr8ORha9SlgtVrvHW1dZhYH+JXU=;
	b=qwmTbebBt6+Ox2iRA4n3FoLPk+UPdfPnrf/tIxR6+SCZLGOy4hZrC4IuRMoNCFiEItFAZJ
	A2HXJbkHSifMqdAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794834694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPB7W49SWsBu17qqGr8ORha9SlgtVrvHW1dZhYH+JXU=;
	b=pSgqltapJr03XTCLjGW//WA6uIDKKTGVD3CwoLmHAZISAvGZkIdxS1Xl7gNXhUqPhRDYbY
	e4aTeNazuxGRaY74LPU14CkzuSlRplbk6TElZmtmOEZ9MpDAKMCHU97HrSaGKjNVYHBctK
	+97v9dTWy3e7emRU/5RPEMzMl2O0quM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794834694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPB7W49SWsBu17qqGr8ORha9SlgtVrvHW1dZhYH+JXU=;
	b=BfFSlZfGF/FsSOuZel6GvoytLZpzlS/wgikjcS8HGyKwKUTr9Vci7wNDJUSW5lawF9m1by
	w3iqpct4CYOGmGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E91841334C;
	Mon, 16 Nov 2026 13:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cqV9MAUB+2rHFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 13:11:33 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 7A8AA24E08; Mon, 16 Nov 2026 14:11:33 +0100 (CET)
Date: Mon, 16 Nov 2026 14:11:33 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 01/17] fs: add kiocb_start_write_trylock()
Message-ID: <6dnk35xcsruinjvqrgi2tfl3i63rbfs7bs3qxodw2joumqu6vn@zewmqpvkbbwk>
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
 <20261116-work-fs-frozen_writes-v2-1-ecc4a2aac40e@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-work-fs-frozen_writes-v2-1-ecc4a2aac40e@kernel.org>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_051137_513238_01004C33 
X-CRM114-Status: GOOD (  27.19  )
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

On Mon 16-11-26 12:03:41, Christian Brauner wrote:
> kiocb_start_write() waits until a frozen filesystem is thawed. A
> nonblocking submission can't use it. io_uring open-codes the trylock
> variant for its IOCB_NOWAIT writes.
> 
> Add kiocb_start_write_trylock() next to kiocb_start_write() and use it
> in io_uring. kiocb_write_iter() is going to need it as well.
> 
> No functional changes.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 22 ++++++++++++++++++++++
>  io_uring/rw.c      |  9 +--------
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c4..eefc2c9d4af19 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2801,6 +2801,28 @@ static inline void kiocb_start_write(struct kiocb *iocb)
>  	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
>  }
>  
> +/**
> + * kiocb_start_write_trylock - try to get write access to a superblock for
> + *			       async file io
> + * @iocb: the io context we want to submit the write with
> + *
> + * This is kiocb_start_write() for a submission that must not wait until a
> + * frozen filesystem is thawed. Should be matched with a call to
> + * kiocb_end_write() if it succeeds.
> + *
> + * Return: true if write access was acquired, false if it wasn't.
> + */
> +static inline bool kiocb_start_write_trylock(struct kiocb *iocb)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (!sb_start_write_trylock(inode->i_sb))
> +		return false;
> +	/* Fool lockdep just like kiocb_start_write() does. */
> +	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
> +	return true;
> +}
> +
>  /**
>   * kiocb_end_write - drop write access to a superblock after async file io
>   * @iocb: the io context we sumbitted the write with
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 3a8559ff4dc66..a0a16fc521455 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -1095,9 +1095,6 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
>  
>  static bool io_kiocb_start_write(struct io_kiocb *req, struct kiocb *kiocb)
>  {
> -	struct inode *inode;
> -	bool ret;
> -
>  	if (!(req->flags & REQ_F_ISREG))
>  		return true;
>  	if (!(kiocb->ki_flags & IOCB_NOWAIT)) {
> @@ -1105,11 +1102,7 @@ static bool io_kiocb_start_write(struct io_kiocb *req, struct kiocb *kiocb)
>  		return true;
>  	}
>  
> -	inode = file_inode(kiocb->ki_filp);
> -	ret = sb_start_write_trylock(inode->i_sb);
> -	if (ret)
> -		__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
> -	return ret;
> +	return kiocb_start_write_trylock(kiocb);
>  }
>  
>  int io_write(struct io_kiocb *req, unsigned int issue_flags)
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

