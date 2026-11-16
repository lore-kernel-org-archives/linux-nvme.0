Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90347606A88A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c4/R3Ff+;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=w9UbCaXu;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2jwVNDcA;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=g4vMACQr;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=caRSVl6C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m+MSrAqEZVeGiRYWzVvdWVxYsWhCX93lP+R84odRzMg=; b=c4/R3Ff+sPf8ak29wm9ujBFB41
	jRBtBf1nq01BYA6+mYGIvlILUWbHTyooFuUrZfN12z8xrpyuUP73v4oVrW2Ahdaybo22pw3kwY1xx
	Iv7uItf8FFRztxT+m69skm8dYDM8vDjdUZW3H0aDCXJk4m934i+bDLNVFA6bjmMzyzBnG1az+fNF6
	IGhlqGgpGwBnZDet0Puk8Qglak+D5QD9MHjAhkJy3hCWtgeHkm5VeMXcXtzD7XrjBDY2TcXlXt9+I
	hMhb2WpJNcJgEm/y/IEGVxDjcIV6xRClOAgAmPCn31fe1ljdvgER5iZCC6U6QDdswYL3HG3ektogq
	YesclZHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvMq-00000002HHF-1753;
	Mon, 16 Nov 2026 11:59:24 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvMn-00000002HGW-3a34
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:59:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE0101FD69;
	Mon, 16 Nov 2026 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794830360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+MSrAqEZVeGiRYWzVvdWVxYsWhCX93lP+R84odRzMg=;
	b=w9UbCaXuysYMtCIxOa132sEBAfLLV3g9wdb1P7GKdWn/KBZf0xmX7OUV+ry36tyRgtBwUS
	4JPmU/S88K0Op27fmaA7V6goV7N2yNsSNSQIpoYQaj+dstfcE8cabCg3iBG0CJKceovJdZ
	Kkbrv96x3HQpafle84sXhPdn8ej/ry8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794830360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+MSrAqEZVeGiRYWzVvdWVxYsWhCX93lP+R84odRzMg=;
	b=2jwVNDcA0m8yAXkVNIaEcYrvMMOpVTPtYSZdQJ07T4BxiUwkJUf6TP91tqXL1n7+tEfQJH
	xqMjVZqR9XeIW3AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794830359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+MSrAqEZVeGiRYWzVvdWVxYsWhCX93lP+R84odRzMg=;
	b=g4vMACQr/XoNhb2D6Tfs8OcqkvXsZpLJDqPYvATm26ZFdE6vvhBB3vGbNqlOEgJ8uYa/la
	EjnuXJUwsQoDxaCQsQo8Ri2QffqhE6VsQot9a1SMyU2VlnjOVWNJ7nPTjn627vClCwaFSo
	Xhxkv9s8KDC8PybbLZk1gMZbBLRP4qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794830359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+MSrAqEZVeGiRYWzVvdWVxYsWhCX93lP+R84odRzMg=;
	b=caRSVl6Coo+XYxmVsbKV6C63GdJ2akNXbWZXWZfrt4t4jRCHnf+Y6z+dO/xYN8ZQi/I6AH
	3E8s8YYRMhGwO9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5405134B8;
	Mon, 16 Nov 2026 11:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NmvtJxfw+mreSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 11:59:19 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 6BADD24DD6; Mon, 16 Nov 2026 12:59:19 +0100 (CET)
Date: Mon, 16 Nov 2026 12:59:19 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 06/12] loop: take freeze protection for discard and write
 zeroes
Message-ID: <wpcg3f2t6onllwx4qd42n6epkqaw4huwhurwc5xf3hbnjjo43a@2fwxzz4khwxe>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-6-f5ae61c898b1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-work-fs-frozen_writes-v1-6-f5ae61c898b1@kernel.org>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_035922_036835_5A648F65 
X-CRM114-Status: GOOD (  18.88  )
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

On Sat 14-11-26 11:47:13, Christian Brauner wrote:
> Discard and write zeroes requests end up in lo_fallocate() which calls
> ->fallocate() of the backing file directly. That skips the freeze
> protection vfs_fallocate() would have taken. So they go straight
> through to a filesystem that is frozen. With the backing file on ext4:
> 
>   WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#3: kworker/u16:1/44
>   Workqueue: loop1 loop_rootcg_workfn
>   Call Trace:
>    <TASK>
>    __ext4_journal_start_sb+0x7a/0x470
>    ext4_dirty_inode+0xa1/0x120
>    __mark_inode_dirty+0x154/0x1110
>    file_update_time_flags+0x3ab/0x4b0
>    ext4_fallocate+0x286/0x3440
>    lo_fallocate+0x13e/0x290
>    loop_process_work+0x486/0xe70
>    process_one_work+0x946/0x1820
>    worker_thread+0x4f1/0xd60
>    kthread+0x364/0x460
>    ret_from_fork+0x525/0x770
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Take freeze protection around ->fallocate() like vfs_fallocate() does.
> 
> Fixes: dfaa2ef68e80 ("loop: add discard support for loop devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484a..77f0601475bb9 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -259,7 +259,9 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  	if (!bdev_max_discard_sectors(lo->lo_device))
>  		return -EOPNOTSUPP;
>  
> +	file_start_write(file);
>  	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
> +	file_end_write(file);
>  	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
>  		return -EIO;
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

