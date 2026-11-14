Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50642606A330
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cvl/L5IZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:In-Reply-To:Date:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ZX3hv8Xu6gI8ftkTSINp/a2fIZMdPBfuTiZKelaDOTc=; b=cvl/L5IZV9TCb14w/XWZFeqdQc
	cK6FuarmVH8VLCgp9lA27oAIP34fWajNzCvNrStWGR0n2PnghHi4lUy0JVS/7LcbalI/uAKub4iF9
	ZY+K1sg5B9GCOeJG/t/d6q0K3VUhNicfAYrL/hjUxgcqK/b4D4VRLwI28wkanV0Y8dqcMJgZ5cnHn
	y06p+N8SOxyq8nOdilRLFfsfcFiI/u+cwRfN/uO77/c3idywsb6/7x3Q3B1fhqnZXXjuB4cBUSZa7
	gjSL1MWjfXeStuBkP4KGaA6nCWN3L/xPjqqq0WgEB3xrNTqF6iJxoDNQmmu4HT6LDpc0nctY6fSBM
	qSqMffdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS3Bg-0000000F6O5-1r3p;
	Sat, 14 Nov 2026 02:08:16 +0000
Received: from mail-oi1-f198.google.com ([209.85.167.198])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS3Bd-0000000F6Nd-2kWj
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 02:08:15 +0000
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a45b3f0bdfso2106248b6e.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 18:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794622092; x=1795226892;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZX3hv8Xu6gI8ftkTSINp/a2fIZMdPBfuTiZKelaDOTc=;
        b=AOl9UETEIlg8x9tOnmafFE1C5Nq7fjry8Aa1jAFVAzJsPU/FbmrbuGpi4/SpMmDnyF
         EqDJqUsD8Vcqlo8ovOR1z9HT8qGKn37jYTKdl4yULorE0ussLtK7yXlaPlXxIITmYavq
         83D2taiOkFxsZQ9X7KXVhVrFCx6twBSBaKt/jZzQZdtreu3JL36eTTRNinNCXf1eSMMZ
         ZnDicyXORhqclV7RsCO1+tycS0qG01idq5py6tGkk06/qHtXrLVagxJ9lbbEO1O8VPjs
         StchpLKtKqalf9WrCibrEGoL9RytQ2+19pvjHUtChDJclizgTsz163eqDzysquuqtJ03
         Uv+A==
X-Forwarded-Encrypted: i=1; AL+hErFEyl9TwPuFEnX/q1UAxUWacQHA4TOfs6bMigrKar55odlkGmU8HUAHPYm46Eq29VhmiR2jqdF/NycY@lists.infradead.org
X-Gm-Message-State: APuU4Z9BdpMGQ76NKT3Zx1c42mD/hpfalbVyTgyYsY9JS6mNswXtx7Db
	cH3ZRPu+DxWtwjlUujhpcDOyn9QNJQrlXJQeq0VvrTGViAubTE3+JSpBvCSxA/i6clQW64QxNz6
	twzIHR+2OM8z8uo3DKnESg4fQ+nBHVJnlK+v5d5BaVpO1a54IhFAYP+JYSvI=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1590:b0:4b9:e65b:8c36 with SMTP id
 5614622812f47-56e648eb2b4mr3859324b6e.36.1794622092112; Fri, 13 Nov 2026
 18:08:12 -0800 (PST)
Date: Fri, 13 Nov 2026 18:08:12 -0800
In-Reply-To: <20261114020731.49877-1-izaacchong934@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af7c28c.0a97acdb.ae7e9.000b.GAE@google.com>
Subject: Re: [PATCH] configfs: fix use-after-free of default group in configfs_symlink()
From: syzbot <syzbot+b0996ac2197dd7420c3e@syzkaller.appspotmail.com>
To: izaacchong934@gmail.com
Cc: izaacchong934@gmail.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_180813_704148_52A17C29 
X-CRM114-Status: GOOD (  23.58  )
X-Spam-Score: -0.7 (/)
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Patch testing via #syz test is temporarily disabled.
See https://github.com/google/syzkaller/issues/8122 for details.

>
> configfs_symlink() drops the parent directory's inode lock while it
> resolves the link target, and keeps a reference to parent_item across
> that window. When the parent is a default group, such as
> ports/<n>/subsystems/ in the NVMe target, parent_item is embedded in
> the containing object (struct nvmet_port). A reference on the embedded
> item does not keep the containing object alive, so a concurrent rmdir of
> the port can free it. allow_link() and the final config_item_put() then
> touch freed memory:
>
>   BUG: KASAN: slab-use-after-free in nvmet_port_subsys_allow_link+0x41/0x2e0
>   Call Trace:
>    nvmet_port_subsys_allow_link+0x41/0x2e0 drivers/nvme/target/configfs.c:1059
>    configfs_symlink+0x59a/0x1030 fs/configfs/symlink.c:196
>    vfs_symlink+0x18b/0x330 fs/namei.c:5794
>
> detach_groups() marks a default group's directory S_DEAD while holding
> that directory's inode lock, before the containing object can be freed.
> So drop the parent_item reference before unlocking dir, and after
> re-taking the lock return -ENOENT if dir is dead. Otherwise look
> parent_item up again, which is safe while dir is locked and alive.
>
> Fixes: 351e5d869e5a ("configfs: fix a deadlock in configfs_symlink()")
> Reported-by: syzbot+b0996ac2197dd7420c3e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b0996ac2197dd7420c3e
> Cc: linux-nvme@lists.infradead.org
> Signed-off-by: Izaac Chong <izaacchong934@gmail.com>
> ---
>  fs/configfs/symlink.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index 89178f5d371a..1b2c9048a920 100644
> --- a/fs/configfs/symlink.c
> +++ b/fs/configfs/symlink.c
> @@ -166,11 +166,11 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
>  
>  	parent_item = configfs_get_config_item(dentry->d_parent);
>  	type = parent_item->ci_type;
> +	config_item_put(parent_item);
>  
> -	ret = -EPERM;
>  	if (!type || !type->ct_item_ops ||
>  	    !type->ct_item_ops->allow_link)
> -		goto out_put;
> +		return -EPERM;
>  
>  	/*
>  	 * This is really sick.  What they wanted was a hybrid of
> @@ -200,7 +200,20 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
>  	ret = get_target(symname, &target_item, &target_sd, dentry->d_sb);
>  	inode_lock(dir);
>  	if (ret)
> -		goto out_put;
> +		return ret;
> +
> +	/*
> +	 * parent_item may be a default group embedded in an object that a
> +	 * concurrent rmdir freed while dir was unlocked, so we dropped our
> +	 * reference above.  detach_groups() marks dir S_DEAD under its inode
> +	 * lock before the containing object can go away, so it is safe to
> +	 * look parent_item up again only if dir is still alive.
> +	 */
> +	if (IS_DEADDIR(dir)) {
> +		ret = -ENOENT;
> +		goto out_put_target;
> +	}
> +	parent_item = configfs_get_config_item(dentry->d_parent);
>  
>  	if (dentry->d_inode || d_unhashed(dentry))
>  		ret = -EEXIST;
> @@ -218,11 +231,10 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
>  						     target_item);
>  	}
>  
> +	config_item_put(parent_item);
> +out_put_target:
>  	configfs_put(target_sd);
>  	config_item_put(target_item);
> -
> -out_put:
> -	config_item_put(parent_item);
>  	return ret;
>  }
>  
> -- 
> 2.39.2 (Apple Git-143)
>

