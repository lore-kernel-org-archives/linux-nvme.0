Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7FCC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s+wcnESLYU9HhNaOkniwhzmqLjKQKrV+1x/FjwBd1I4=; b=LYyBGoPbs0jIQECJGKcg3zg14J
	sC2TiBmOJ0XHyOexLVzqyeKQI0W078Z0/rUWOPzAzTqSrHE3bhc03R/h6Y5UcfL9VnIRSmCIG74Mv
	2mxqRIB4kM7dFVGxag5d1u1Q0gkX7MiaJjQE6tNZ8YjuQIpmGo7AQIeLFP3bzkpC1OtP6Clob3ljp
	fMHXodQv1eRp3lu0Z2I6BsNsIjGAUOjh1yCQ1NLTMDxY60nsiUS6dtEJb/+NmROe5wgkH7Me30Kn+
	VevGtk+I+l4c5BBuothgaSBKKHn0EdBCwlbwpW1Ins/atk6tt25Q9aJYYGbVJaf7eOCRO7GismWFz
	rofgGexw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDNI4-00ERF3-1b;
	Wed, 13 Dec 2023 11:20:36 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDNHy-00ERES-1x
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 11:20:32 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DFE5222C4;
	Wed, 13 Dec 2023 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702466427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+wcnESLYU9HhNaOkniwhzmqLjKQKrV+1x/FjwBd1I4=;
	b=PXiYiycNHBs4OBe/8nDEB8SJNvw8dJxOHmyPDJ+dgrJDqQe3apXh6PoK2dhEzhZ9P/CzO7
	NQqnGoQr72zNGTU8D4188xC1POrWSjibqFraYWBm24yAEmEmhMHigi2hHm2oEJcVaq0uIK
	LEhT6UgyMgWKTbdIUTAifUZufNDcpsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702466427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+wcnESLYU9HhNaOkniwhzmqLjKQKrV+1x/FjwBd1I4=;
	b=zVCLyiGwwrEGhLMywzjUCP20OIfFB6vB5teuBSMV930b801bP9H4YV8IQ5GLGKwhu137+y
	uj8AibVXWRujGBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702466427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+wcnESLYU9HhNaOkniwhzmqLjKQKrV+1x/FjwBd1I4=;
	b=PXiYiycNHBs4OBe/8nDEB8SJNvw8dJxOHmyPDJ+dgrJDqQe3apXh6PoK2dhEzhZ9P/CzO7
	NQqnGoQr72zNGTU8D4188xC1POrWSjibqFraYWBm24yAEmEmhMHigi2hHm2oEJcVaq0uIK
	LEhT6UgyMgWKTbdIUTAifUZufNDcpsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702466427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+wcnESLYU9HhNaOkniwhzmqLjKQKrV+1x/FjwBd1I4=;
	b=zVCLyiGwwrEGhLMywzjUCP20OIfFB6vB5teuBSMV930b801bP9H4YV8IQ5GLGKwhu137+y
	uj8AibVXWRujGBDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 82EE713240;
	Wed, 13 Dec 2023 11:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id j4LwH3uTeWXHBQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 13 Dec 2023 11:20:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDAAFA07E0; Wed, 13 Dec 2023 12:20:26 +0100 (CET)
Date: Wed, 13 Dec 2023 12:20:26 +0100
From: Jan Kara <jack@suse.cz>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 04/16] fs: Increase fmode_t size
Message-ID: <20231213112026.kkfcwtg64kiadhn5@quack3>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-5-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-5-john.g.garry@oracle.com>
X-Spamd-Bar: +++++
X-Rspamd-Queue-Id: 9DFE5222C4
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PXiYiycN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zVCLyiGw;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Result: default: False [5.99 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_032030_807788_58DCDF3F 
X-CRM114-Status: GOOD (  18.03  )
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

On Tue 12-12-23 11:08:32, John Garry wrote:
> Currently all bits are being used in fmode_t.
> 
> To allow for further expansion, increase from unsigned int to unsigned
> long.
> 
> Since the dma-buf driver prints the file->f_mode member, change the print
> as necessary to deal with the larger size.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Uh, Al has more experience with fmode_t changes so I'd defer final decision
to him but to me this seems dangerous. Firstly, this breaks packing of
struct file on 64-bit architectures and struct file is highly optimized for
cache efficiency (see the comment before the struct definition). Secondly
this will probably generate warnings on 32-bit architectures as there
sizeof(unsigned long) == sizeof(unsigned int) and so your new flags won't
fit anyway?

								Honza

> ---
>  drivers/dma-buf/dma-buf.c | 2 +-
>  include/linux/types.h     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 21916bba77d5..a5227ae3d637 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1628,7 +1628,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  
>  
>  		spin_lock(&buf_obj->name_lock);
> -		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\t%s\n",
> +		seq_printf(s, "%08zu\t%08x\t%08lx\t%08ld\t%s\t%08lu\t%s\n",
>  				buf_obj->size,
>  				buf_obj->file->f_flags, buf_obj->file->f_mode,
>  				file_count(buf_obj->file),
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 253168bb3fe1..49c754fde1d6 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -153,7 +153,7 @@ typedef u32 dma_addr_t;
>  
>  typedef unsigned int __bitwise gfp_t;
>  typedef unsigned int __bitwise slab_flags_t;
> -typedef unsigned int __bitwise fmode_t;
> +typedef unsigned long __bitwise fmode_t;
>  
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  typedef u64 phys_addr_t;
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

