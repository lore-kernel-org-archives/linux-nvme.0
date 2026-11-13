Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A16606A333
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tmxK8BLu;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tucbZtD4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=; b=tmxK8BLuFIotDZnL5dL9CubP1S
	GhTxO5XkGotMXYFxxMBUtEG81itzOir3OPogcyQQBjEE14V005zvl6ByypiyuTSpAr5ImYdI/1jAP
	r9kGUE5Bgcdvcg+ojRU16K29TkKhVMXQrf8WsFBgdVPauLSUtQeH9GDrfnLOgIsnLD/lOyBWBoSDL
	mW2FlSZAG1G9uKJD3PNPzpnZ46AKHbOqNKB7JTuh+RaCtCHaXRunb7DP71s6IRiSXq2RmlOLnR5Hu
	h/uQbIf5/GBSDci/MKxtk2uMKcgwJvDTFc8OApfhlbuMBaTZ3IlvGkQiLYUy1yNA+IgNX4uczbBkN
	NstWBRVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3g-0000000EDU1-3ukE;
	Fri, 13 Nov 2026 19:35:36 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoVE-0000000CMa8-2ra1
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:27:29 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a215e64962so13250445e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565647; x=1795170447; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=tucbZtD4QhJ5OJK+oMEvNuVS+EZ1UJ+MhsvNQ+Tv4X16IyWiwlU344Op9ZDEb4I4pm
         XBP9GwCcW3bheUFIxS7qbSORlcjowaVN9oglrCwM52ip4RB9sJM2sw0jPgbRF4LXDi2Q
         QMKyXYyYDksPiBZTVOeTGKz5gOfnKzgSHVM6DcF3HCgKsghqoXcux/1dhmJ6vxRbXbZr
         xFD06J45oE8WtTfL2I9L2U7YjS33FMdKSQuyELN4Wz4OfF8gkaYRgn9sD1uN3rpHOQVN
         6rRFsl9dIDC6N/mQXsFQ7vUfYWGN9Kz7Wle7mP7E6ZVI+uUf3tNiAwlKxT9rVe7LM/1J
         l+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565647; x=1795170447;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=04z6Ht20rARlpC4SWf7vQyD/l62NCw8iKegFSZrf4WVWZrp4QsCn47g6g5HV8+fUQ2
         XPFcsDsxbqA+iyEm2omYWVPjk87RFLeJzqI/zt4HJWSYhTdFIgzMlRTFjIKmP2mlCvdo
         trsIL0rj2kZS+HGgyZ6ErvmYYzOT9461um5114/7XW5Ih63zpvuM0oyYH2eFPdC/7UFg
         cCPdlE+weMJY7F2FzKFjBwm1dJRVPeX8pVMwWQkXjW+MlScxi+uNgFl13hSKVIWBqGGm
         BgRVmAkPDNT6BqpOmLtEr+w+DuRAhsDJwdIdT/sQr+x8rCOFksJb2J6m2JWu8/F3dbWv
         veOw==
X-Forwarded-Encrypted: i=1; AL+hErHOJsOoeKrc/4kShnRTCz6ktgi2MmH+C4v6yUoNKgOBJBGLNhn9CnjpMLGTMgW9lLRnOuwz/Y4P6Jq7@lists.infradead.org
X-Gm-Message-State: APuU4Z+sttO31xgxPCOQ9cE9wZj7th9AWensV3uWVF9SJokt5vM6nMYc
	9sRW1Cm0UQzEZB4iBOHgJT4e0MfDG8bEDDbBZBeCWgwDWSWcg5azTpx3jlBph/LyLBrT
X-Gm-Gg: AYBFou04tYivl9tbw3uYOJ+BzT6PW/cCUHr4FpIHn9mMX4pwwDha7wxa3IiUvUibJv4
	YgpZ3cHDB0TMsuy1kB4ILRpo5SncSd6IleZYViUk0IG/c/z5DAdbDUo3I7APozxgN2Nn8UwIj1d
	nigTVM2cBLgCP1ixNhkDrcQ43b9V9mkejn6qFCnNZti8RY8iiaOyC6oMTFqwkzGzQMSCnRtMr4Z
	+NQGq+9mStJ8FbN5IOfc+BRSPvV5lj+YoUsp3iniWWAfCM8PzvCX1uD5LjKFDk5v89KeXL7Ed9z
	SInR9VQJAiSdib2f+U2o5SRlbwiTfExu2tAMDfA6XWXHCoyDt5ZtcOpa1t0zErvBA0+yeJAB0XH
	ttIuu8SAz/aArnaRQk3fzTU+nO72nwvbsKpiAOTE5MJW6WullBhcSi6mOUecZKt+lXH3/m04rXu
	piINA3+bZy97SkEc2x/EGpunHEtqaX4sXKBCNJUXpBvZ+5AoqxL98OUO8ItsN8ZVB7F+92iEwgb
	nH1eDqFAuEkNHcUYHLz/8JhinLCNQ4WbjLIF2r2dswLUMCA/zPy6aAX51tJRv/xZEl4Ju8xJy6L
	H8L1IQtYqCidTMqsSxh4QtKBOC+LTUxRkY9EuOS2AuRLIrWypPS4ThmIVVCS1ao=
X-Received: by 2002:a05:6000:4707:b0:498:c419:3728 with SMTP id ffacd0b85a97d-49c713ae367mr4463557f8f.22.1794565646661;
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm5077482f8f.0.2026.11.13.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Message-ID: <0c109a58804a2d782e549af6ad13e89532d9f9d2.camel@amutable.com>
Subject: Re: [PATCH RFC 40/41] erofs: refuse files on pseudo filesystems as
 backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:27:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_022728_739080_534C32AD 
X-CRM114-Status: GOOD (  16.44  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> File-backed mounts take any regular file as the image and the same
> goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the
> mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/erofs/super.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index ce05557bd998..980d5fc2b576 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -158,7 +158,8 @@ static int erofs_init_device(struct erofs_buf
> *buf, struct super_block *sb,
> =C2=A0		if (!erofs_is_fileio_mode(sbi)) {
> =C2=A0			dif->dax_dev =3D
> fs_dax_get_by_bdev(file_bdev(file),
> =C2=A0					&dif->dax_part_off, NULL,
> NULL);
> -		} else if (!S_ISREG(file_inode(file)->i_mode)) {
> +		} else if (!S_ISREG(file_inode(file)->i_mode) ||
> +			=C2=A0=C2=A0 file_is_pseudo(file)) {
> =C2=A0			fput(file);
> =C2=A0			return -EINVAL;
> =C2=A0		}
> @@ -835,6 +836,9 @@ static int erofs_file_get_tree(struct fs_context
> *fc)
> =C2=A0{
> =C2=A0	struct erofs_sb_info *sbi =3D fc->s_fs_info;
> =C2=A0
> +	if (file_is_pseudo(sbi->dif0.file))
> +		return invalfc(fc, "source is on a pseudo
> filesystem");
> +
> =C2=A0	if (!test_opt(&sbi->opt, SUPERBLOCK_SHARE))
> =C2=A0		return get_tree_nodev(fc, erofs_fc_fill_super);
> =C2=A0

