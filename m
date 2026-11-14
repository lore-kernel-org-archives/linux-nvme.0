Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCEA606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X9ntpTva;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwtfAMpN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cbYuMu4WUsUGCQIH0/sc2YzB04reRDp9xUgMuHbaCn4=; b=X9ntpTvaFqgs4/BoH3c4UWpWql
	6mcTZW6brBqzVEIAn1l51Hu6z54fN2HtX+9RyrDsgPNxZi9VQ6SCwhb4GWW9uM4FcIfYoGSaIFIKb
	jDMGSn+AewEHkot9ZD/eaCz5anaFj0IntmcKfFkwbNvJlRJWjUix2yDDyh0NCo0ruISh+31XWymED
	2Obqo0u22Q71Ux/54TqrSKLzxnzqopbwbSko4a1b3zM+aMALXTopOeUGwbSRZChEpBO75PiylPNO/
	7ULVF6mt95Wu+HDDKPeRasewfeR0BBHnCs+PI5XI9zjCHjc5scxBMnxODfwLY6168ZwaHqyKYHD1E
	geENs7ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBfX-0000000FsON-0oFX;
	Sat, 14 Nov 2026 11:11:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBfV-0000000FsOE-3lBF
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 11:11:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 58D7761EE1
	for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 11:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9140B1F000C4;
	Sat, 14 Nov 2026 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794654697;
	bh=cbYuMu4WUsUGCQIH0/sc2YzB04reRDp9xUgMuHbaCn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UwtfAMpNar/KTN/dBePsvZFv6Goco8vT84PD0R/pMySX0mLppPWXfXODhwxF4L/An
	 M4unY+1vSs6uWiWq7701SFv+PcIH3RxEI5xYlORneMEdkh2/s8gaLIAqqej+PN431x
	 CyoDIRM8scltxaItI4WpC1+D4ms5FM80ne8ff/GdVaB+qvenDZaCF+ggofzW901Rqv
	 +dNsGwox2idCyxE7GBqvwM1Zq+dzVdLpITUx14SOj2GX8C7aRzpWxfWuyusLoCqyIH
	 hO0UNwzpMGfZlk7d2wrzvN5byLxISdn06W/3pBh+yKRFsmf/1icXCyNkEkBvBHAXRE
	 k4+BEspOnWkaA==
Message-ID: <sashiko-outbox-214394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] bpf: fs/xattr: take freeze protection in the
 xattr kfuncs
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, bpf@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261114-work-fs-frozen_writes-v1-11-f5ae61c898b1@kernel.org>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-11-f5ae61c898b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 11:11:36 +0000
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
- [High] bpf: deadlock in bpf_set_dentry_xattr() via
  bpf_lsm_inode_need_killpriv() [1]
--

commit 486e046b7935f74b8ef238345d31e9322cf39132
Author: Christian Brauner <brauner@kernel.org>

bpf: fs/xattr: take freeze protection in the xattr kfuncs

This commit takes superblock freeze protection via
sb_start_write_trylock() in bpf_set_dentry_xattr() and
bpf_remove_dentry_xattr() so that BPF LSM programs cannot modify a frozen
filesystem.

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 35ccd98a4de64..7f61e2efa08ba 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -295,9 +295,13 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *=
dentry, const char *name__st
>  	if (!inode)
>  		return -EINVAL;
> =20
> +	/* The hook may hold locks or freeze protection already. */
> +	if (!sb_start_write_trylock(inode->i_sb))
> +		return -EBUSY;
>  	inode_lock(inode);
>  	ret =3D bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);
>  	inode_unlock(inode);
> +	sb_end_write(inode->i_sb);
>  	return ret;
>  }

[Severity: High]
This problem wasn't introduced by this patch, but can calling
bpf_set_dentry_xattr() or bpf_remove_dentry_xattr() from
bpf_lsm_inode_need_killpriv() deadlock on inode_lock(inode) [1]?

During file writes, callers of file_remove_privs_flags() ->
dentry_needs_remove_privs() -> security_inode_need_killpriv() already hold
inode_lock(inode).  Because bpf_lsm_inode_need_killpriv is missing from
d_inode_locked_hooks, the verifier routes xattr kfunc calls from that hook
to the unlocked variants instead of the _locked ones, causing the thread
to self-deadlock on inode->i_rwsem.

[1] https://sashiko.dev/#/bug/linux-8b38dfb7-78dd-457e-8674-7955f142df39

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-fs-fr=
ozen_writes-v1-0-f5ae61c898b1@kernel.org?part=3D11

