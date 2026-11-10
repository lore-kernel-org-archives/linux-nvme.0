Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A94606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RqeVeAlE;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=u1B+HDke;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s5Vry7Gw;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=u1B+HDke;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s5Vry7Gw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tdoiUJdd+iiYf5DPNh/N+wqKlHvGCKXVkvS18tLeyxA=; b=RqeVeAlEQv7K91dbZn6m6kBigg
	CRQ4b9vaFjHKjqwe9L/H3KuvijZfOOn9JVi/LNDIO4AMs5eb6/wsOBBnJskEPYFXk4MBN8H5tv2nS
	+FFlt3ByxM1sdYZrb2Haa5R+0Kw1iGIQ8vDf5v7jjbssdXGZH5kOo4Hkttgx1vcmic2mQ+r+lk2Zg
	FeLHc+Rshe9WVK7gDGi8pY8mvbPsufCNiUVzw7bsblPIfKzJbDMfP0+iFs3n1ZAdoB+UCKBJLQ4B1
	bFUe94dCUVfXlG5GzfyPwR1fxYwx2ja+qoNQDh/1a2LbWjtYANiW51cgvBq2reOAP0IDtgjI8bLae
	P9ecDGMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhb-00000007km0-0Q9q;
	Wed, 11 Nov 2026 21:17:55 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlNo-00000003vh8-0L0I
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 12:55:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 433A51F7E1;
	Tue, 10 Nov 2026 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794315326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdoiUJdd+iiYf5DPNh/N+wqKlHvGCKXVkvS18tLeyxA=;
	b=u1B+HDke0hpMTlvQS4vtx71OgG/jW66cq5t3mKyddBwSs3IYmIVxUedNECKYU2Wn3gjDNT
	XUqmAOVAzpAAoCLHSQwmjBDhumXbbOHNTsIcqDMxum8byZPrO4ABQMzvGZfY065Bc2x/zH
	mOiuGvCf5UFir5w37V75pl3/j+OZOdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794315326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdoiUJdd+iiYf5DPNh/N+wqKlHvGCKXVkvS18tLeyxA=;
	b=s5Vry7GwYW6iUbLBXO4qDI4lvuxved+sj/wAa+gp1aCB2Ie0NTZRQTOaGDvuboGj3hVbu8
	2o09Y6CHNOgJe5BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794315326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdoiUJdd+iiYf5DPNh/N+wqKlHvGCKXVkvS18tLeyxA=;
	b=u1B+HDke0hpMTlvQS4vtx71OgG/jW66cq5t3mKyddBwSs3IYmIVxUedNECKYU2Wn3gjDNT
	XUqmAOVAzpAAoCLHSQwmjBDhumXbbOHNTsIcqDMxum8byZPrO4ABQMzvGZfY065Bc2x/zH
	mOiuGvCf5UFir5w37V75pl3/j+OZOdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794315326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdoiUJdd+iiYf5DPNh/N+wqKlHvGCKXVkvS18tLeyxA=;
	b=s5Vry7GwYW6iUbLBXO4qDI4lvuxved+sj/wAa+gp1aCB2Ie0NTZRQTOaGDvuboGj3hVbu8
	2o09Y6CHNOgJe5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 188A2134F4;
	Tue, 10 Nov 2026 12:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bVLYOj0U82rFQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 12:55:26 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id B1F3D224DE; Tue, 10 Nov 2026 13:55:21 +0100 (CET)
Date: Tue, 10 Nov 2026 13:55:21 +0100
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
Subject: Re: [PATCH RFC 04/41] fs: add SB_I_PSEUDO
Message-ID: <mdy4v37mrp7rfwt3bwiiu63ztgdlcqtahyiqj6vw66zo2dl3cz@rd3m2b6sf77x>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_045528_274406_E70155BD 
X-CRM114-Status: GOOD (  31.87  )
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

On Tue 10-11-26 10:14:20, Christian Brauner wrote:
> Currently, there's no way to tell whether the files of a filesystem
> store data or whether they are kernel interfaces. Files on pseudo
> filesystems such as procfs or sysfs generate their contents when they're
> read and writes to them are commands to the kernel.
> 
> But a few places in the kernel take an arbitrary file and use it as
> storage: loop, zloop, the nvme target's file backend, the scsi target's
> fileio backend, fuse passthrough, the usb mass storage gadget and erofs
> file-backed mounts. At most they check the file type and whether the
> file implements ->read_iter() and ->write_iter(). That's not enough.
> kernfs provides both for every sysfs attribute for example.
> 
> Add SB_I_PSEUDO so a filesystem can state that its regular files are
> kernel interfaces and must not be used as storage.
> 
> Pseudo filesystems also never hold executables or device nodes. But
> currently each of them decides on its own whether to raise SB_I_NOEXEC
> and SB_I_NODEV. Some do, most don't. Add fc_init_pseudo() as the common
> initialization point for all pseudo filesystems that raises all three
> flags and switch init_pseudo() over to it. The following patches
> convert the mountable pseudo filesystems.
> 
> Nothing checks SB_I_PSEUDO yet so no functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c                     |  2 +-
>  include/linux/fs/super_types.h |  1 +
>  include/linux/pseudo_fs.h      | 11 +++++++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 96a6e9b1535f..8c8789489fdf 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -735,7 +735,7 @@ struct pseudo_fs_context *init_pseudo(struct fs_context *fc,
>  		fc->fs_private = ctx;
>  		fc->ops = &pseudo_fs_context_ops;
>  		fc->sb_flags |= SB_NOUSER;
> -		fc->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
> +		fc_init_pseudo(fc);
>  		fc->global = true;
>  	}
>  	return ctx;
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
> index 72f4288e16c5..472200bdf081 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -359,5 +359,6 @@ struct super_block {
>  #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
>  #define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
>  #define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee data persistence on sync */
> +#define SB_I_PSEUDO	0x00010000	/* regular files are kernel interfaces, not storage */
>  
>  #endif /* _LINUX_FS_SUPER_TYPES_H */
> diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
> index a651e60d9410..0ca408aa60af 100644
> --- a/include/linux/pseudo_fs.h
> +++ b/include/linux/pseudo_fs.h
> @@ -2,6 +2,7 @@
>  #define __LINUX_PSEUDO_FS__
>  
>  #include <linux/fs_context.h>
> +#include <linux/fs/super_types.h>
>  
>  struct pseudo_fs_context {
>  	const struct super_operations *ops;
> @@ -15,4 +16,14 @@ struct pseudo_fs_context {
>  struct pseudo_fs_context *init_pseudo(struct fs_context *fc,
>  				      unsigned long magic);
>  
> +/*
> + * Common initialization for all pseudo filesystems, mountable or not. Their
> + * regular files are kernel interfaces. They don't store data and pseudo
> + * filesystems never hold executables or device nodes.
> + */
> +static inline void fc_init_pseudo(struct fs_context *fc)
> +{
> +	fc->s_iflags |= SB_I_PSEUDO | SB_I_NOEXEC | SB_I_NODEV;
> +}
> +
>  #endif
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

