Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C878606A324
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RjDKJUcE;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tSFQYWyR;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V1tJ5Byu;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tSFQYWyR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V1tJ5Byu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8ydl7Tmlsy6sB/5DKTtOnjnkkw2YCPYFk9bjL7BuvBI=; b=RjDKJUcEESqLdq+7zVO6ogH6gq
	KSheppLdKJvREtifGOX11ZL8RmkE5jPHge+cUYAg0gRt5JyQKc/ZPjLiY86tlJTnDHAo++ysNTjdX
	ukzkni+Yc83SC0qqESfcbpVhD8COwi/fGvb59zR0HAvvxLA1azRj44T1xWrJcQQrBP0WbNQIjqYSo
	Vx/xvos0ntKMu9ka8D7OZNsx2JJ5jX3yz6vYZ4lsentk7GyMZ1RgAEJDqq53M27cggVGFjMzSlaDN
	WRek6FRc72xBXpkbJ8TPbzO6L3Ud1H/EvlQBo+p854BpfM1zatVFL1QvQvGnjtenNPT7TP2lC+DaX
	V+tT+blA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhe-00000007ku6-0H01;
	Wed, 11 Nov 2026 21:17:58 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlPG-00000003w8D-2aWc
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 12:56:59 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10FD721F68;
	Tue, 10 Nov 2026 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794315417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ydl7Tmlsy6sB/5DKTtOnjnkkw2YCPYFk9bjL7BuvBI=;
	b=tSFQYWyRwwv+kHYE8YhpOGU4Ki3HgKpsjkr+3bnlJF4cyRVZi+z6dmRnLVspPlNWBQ97T6
	CjWhI8INKAvD/P6E+SsUzIAB++2Mfn4yUQshTJILp/aD0y+vMUsCGK8B/SvT9SJxrm+lD6
	OfAmAtDkJMnT/TjtT42JjMJHwAmLTYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794315417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ydl7Tmlsy6sB/5DKTtOnjnkkw2YCPYFk9bjL7BuvBI=;
	b=V1tJ5Byu2B6p1tefK4YDbMgOvwybp9VjU+aSU5c9lZUhOg8WFHNH3DAT2n59zkgMTRqYSW
	vjk8sfZwK3dN1ECg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794315417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ydl7Tmlsy6sB/5DKTtOnjnkkw2YCPYFk9bjL7BuvBI=;
	b=tSFQYWyRwwv+kHYE8YhpOGU4Ki3HgKpsjkr+3bnlJF4cyRVZi+z6dmRnLVspPlNWBQ97T6
	CjWhI8INKAvD/P6E+SsUzIAB++2Mfn4yUQshTJILp/aD0y+vMUsCGK8B/SvT9SJxrm+lD6
	OfAmAtDkJMnT/TjtT42JjMJHwAmLTYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794315417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ydl7Tmlsy6sB/5DKTtOnjnkkw2YCPYFk9bjL7BuvBI=;
	b=V1tJ5Byu2B6p1tefK4YDbMgOvwybp9VjU+aSU5c9lZUhOg8WFHNH3DAT2n59zkgMTRqYSW
	vjk8sfZwK3dN1ECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E25DE1339F;
	Tue, 10 Nov 2026 12:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6y7vMJgU82poRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 12:56:56 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 8D370224E9; Tue, 10 Nov 2026 13:56:56 +0100 (CET)
Date: Tue, 10 Nov 2026 13:56:56 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 07/41] binfmt_misc: use fc_init_pseudo()
Message-ID: <pgygyhsa4yghzrnta5qgeqehqixklm4tzdjz76ro7j6zy5r5ib@2xq25urai24i>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-16.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLdu9otajk16idfrkma9mbkf9b)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,toxicpanda.com,lst.de,lists.infradead.org,zeniv.linux.org.uk,suse.cz,lists.linux.dev,kvack.org,lists.ubuntu.com,lists.xenproject.org,lists.ozlabs.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -16.80
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_045658_802370_5A47173E 
X-CRM114-Status: GOOD (  19.41  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:02 -0800
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 10-11-26 10:14:23, Christian Brauner wrote:
> Initialize binfmt_misc as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/binfmt_misc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index d945b4f6e158..7dc233becd98 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -22,6 +22,7 @@
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/init.h>
>  #include <linux/kstrtox.h>
>  #include <linux/limits.h>
> @@ -1575,8 +1576,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (user_ns != current_user_ns())
>  		return -EINVAL;
>  
> -	/* Never exec off this instance and never let anything stack on it. */
> -	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
> +	/* Never let anything stack on this instance. */
>  	sb->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
>  
>  	/*
> @@ -1660,6 +1660,7 @@ static void bm_kill_sb(struct super_block *sb)
>  
>  static int bm_init_fs_context(struct fs_context *fc)
>  {
> +	fc_init_pseudo(fc);
>  	fc->ops = &bm_context_ops;
>  	return 0;
>  }
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

