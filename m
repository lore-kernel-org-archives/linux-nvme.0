Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C179606A329
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nvtW5JT6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbQuUcA+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WM8TGHpqWmigDZ+JoCcsGnxLIHubIXd+7QDDtmp3Tho=; b=nvtW5JT6GmyVlXgU8cOA/X40T6
	qRaf8CdrLqAAny7TBLFPOIB7uX4nob80qFcFgqTeB1KqWv2J9B4Z8PTQXLSe7QnHsJn5gC3pjP2xE
	4wgJu2zXGtV/mRkzV5lLZBFUb1rOic1XjSXCxrz8M3SM9iiUBHw1Dv0Wy8jbwjVggq0GuPEo7yAGl
	5RdhEXqPDvw45LGSAm5noF5PdmdUu0JKBfpYMpW4DKC1PTMSAHWG7e0e+vj7wYrHA93gFUVEuS9Lo
	XG2tav2dnI4RVdpO+uG8c96OEFMyNv4/5fwRdg5bgeKs0bcJX0WlJPdLaOYXjxaxXzLnqiDEvCeeB
	+YH/gnvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4Iy-0000000FETh-3cIp;
	Sat, 14 Nov 2026 03:19:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4Ix-0000000FETZ-29QX
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:19:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 87C6960DC9;
	Sat, 14 Nov 2026 03:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206D61F000C4;
	Sat, 14 Nov 2026 03:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626390;
	bh=WM8TGHpqWmigDZ+JoCcsGnxLIHubIXd+7QDDtmp3Tho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbQuUcA+ggdooQ28c0qIE1zNT9cyD3alUWO5Z6FshfQ1SMAkfGoOZxxkwUKPj1nBW
	 Tdsw0JMmHonniNe1tPNyRc63MWsOOuDRF60FTNKC7TnJtlu6mHICef5SvMmqakokmx
	 yYPoGAElN6OdREGmgmkUcmqxvMO87Uh4ZQ5x+2IzCph9FR5pLLTP3pZklWDD15s04A
	 0kxsPrdeyKdoKMJ7s6X5o8MXSd6hnFKgAnNMh8VfthmCUbneUxsQPRpjVuyvu17mfe
	 4avJXJ9xvJRC/8NBF8GsTQ9PcMxvYrKGzD9webBG6AZJ1WPqiX/ugU/HL5pCGkOKSj
	 u1rBmdAkF47hA==
Message-ID: <sashiko-outbox-214096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] configfs: fix use-after-free of default group in
 configfs_symlink()
To: "Izaac Chong" <izaacchong934@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114-configfs-symlink-uaf-v1-1-1446154abdda@gmail.com>
References: <20261114-configfs-symlink-uaf-v1-1-1446154abdda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:19:49 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] configfs: slab-use-after-free on target_item in
  configfs_symlink() [1]
--

commit 6dfc12fe3d6f7e5274806249ad0ae808c90eafd5
Author: Izaac Chong <izaacchong934@gmail.com>

configfs: fix use-after-free of default group in configfs_symlink()

This commit fixes a use-after-free of an embedded default group in
configfs_symlink() by dropping the parent_item reference before unlocking
dir and re-acquiring it after checking IS_DEADDIR(dir).

> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index 89178f5d371a6..1b2c9048a920b 100644
> --- a/fs/configfs/symlink.c
> +++ b/fs/configfs/symlink.c

[ ... ]

> @@ -200,7 +200,20 @@ int configfs_symlink(const struct mnt_idmap *idmap, =
struct inode *dir,
>  	ret =3D get_target(symname, &target_item, &target_sd, dentry->d_sb);
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
> +		ret =3D -ENOENT;
> +		goto out_put_target;
> +	}
> +	parent_item =3D configfs_get_config_item(dentry->d_parent);
> =20
>  	if (dentry->d_inode || d_unhashed(dentry))
>  		ret =3D -EEXIST;
> @@ -218,11 +231,10 @@ int configfs_symlink(const struct mnt_idmap *idmap,=
 struct inode *dir,
>  						     target_item);
>  	}
> =20
> +	config_item_put(parent_item);
> +out_put_target:
>  	configfs_put(target_sd);
>  	config_item_put(target_item);
> -
> -out_put:
> -	config_item_put(parent_item);
>  	return ret;
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can target_item suffer
from a similar use-after-free or NULL pointer dereference [1] if a
concurrent rmdir removes the target or an ancestor group after get_target()
returns?

CPU0                                CPU1
configfs_symlink()
  inode_unlock(dir)
  get_target()
    config_item_get(sd->s_element)
    configfs_get(sd)
                                    configfs_rmdir()
                                      ...
                                      unlink_group()
                                        unlink_obj()
                                          item->ci_group =3D NULL
                                          item->ci_parent =3D NULL
                                          config_item_put(item)
                                          config_group_put(group)
                                            // frees containing object
  inode_lock(dir)
  allow_link(..., target_item)  <-- use-after-free or NULL ci_parent
  config_item_put(target_item)  <-- use-after-free

get_target() grabs references to target_item and target_sd and drops the
path without holding any lock on the target directory or incrementing
target_sd->s_links (which happens later in create_link() under
configfs_symlink_mutex).  Because s_links is still 0, a concurrent
configfs_rmdir() can detach the target.  If target_item is a default group
embedded in a parent object without its own release callback, unlink_obj()
drops the parent group reference and frees the containing object while
target_item is still held; even for standalone items, unlink_obj() clears
ci_parent and ci_group before allow_link() runs.

[1] https://sashiko.dev/#/bug/linux-df6ae898-b1a6-4091-be3b-fbe4c177763f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-configfs-s=
ymlink-uaf-v1-1-1446154abdda@gmail.com?part=3D1

