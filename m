Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877E606A331
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s9z2awvQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtA9LyX1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DO/pcsGH2E70PyxeObnmbVUNA7RxRjcw0EQOKMlsdEM=; b=s9z2awvQ8MnlcsNvphG+FQ26E+
	AM0Wck2PaM91+1B3SLSxlDAv6tuI4jXqbE7PvihMRJZEJ068K7H/uVbg27r7kgqY7QuoAk3qCPsJT
	VfHa4AuYmdXlGS8UspHxv9DO2/TPOlMSsVeOPkly1++aVKUnoNHJ9X/TXihYDdIqFvDNFjd8L5llw
	NIdHz4GsgqrRexscrK/dG5vsrCPZFkil9vbT7xMSCscbLxLTNma8oQmRQNYHz1NkBKTExFLibk8dv
	rqwt5YkQkiA24Ipc63xJqJTUtTkqaOD+fN/cbAJtrY6f76MWVOwvWOjKWm/XRUBYSUpKUPUqGUjVm
	KVPuHVKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDzK-0000000G8aT-0noX;
	Sat, 14 Nov 2026 13:40:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDzI-0000000G8aH-3bSF
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:40:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5DB6943AF7;
	Sat, 14 Nov 2026 13:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EE71F000C4;
	Sat, 14 Nov 2026 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663612;
	bh=DO/pcsGH2E70PyxeObnmbVUNA7RxRjcw0EQOKMlsdEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EtA9LyX1DQPmqIivWqEued4cucJAK1+nJOQ/GGvKipbsSCBQuo+oZ3kPO9RKq7oYC
	 zIcaqW85WuT+78yc6J4OdCXsw3apCSEsQ7sYevNDP5gzBcxQY0m3Hv+1Ms0/aVZ7H8
	 CDlb2C/w82i3kqyY8BfiXhGvlQIigUINjN/hsFCRLIaM2Ubpq32rCz1dM2EFAIdocF
	 nG9Yz57EvfILKbQDtDytbmBzQCS6+NOxq3b2IHcbiz+ugsNkMobp3XIkLgDnxk7t1p
	 F4jXXVsDKS5hVcmfN7uciWAYXm2W6m4JRPhYfmt9AfelqpBckVtT7QDcKzpdjQSs7B
	 YV7fH2wGKn7Ug==
Message-ID: <sashiko-outbox-214581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jann Horn" <jannh@google.com>, "Chris Mason" <mason@kernel.org>, "Josef
 Bacik" <josef@toxicpanda.com>, "Christoph Hellwig" <hch@lst.de>, linux-nvme@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Amir
 Goldstein" <amir73il@gmail.com>, "Chuck Lever" <cel@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:40:10 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] fs: unverified overlayfs O_PATH d_real_inode() call in
  file_check_backing()
--

commit 12b4c886c3329cc29a995a96a698923b0df5e8e2
Author: Christian Brauner <brauner@kernel.org>

fs: add file_check_backing()

This commit adds file_check_backing() to validate whether a userspace
file can be used as backing storage by checking its open mode, file type,
pseudo-filesystem status, and read/write iterator operations.

> diff --git a/fs/read_write.c b/fs/read_write.c
> index 6767283108991..cedbe654add65 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -866,6 +866,54 @@ static ssize_t do_loop_readv_writev(struct file *fil=
p, struct iov_iter *iter,
>  	return ret;
>  }
> =20
[ ... ]
> +int file_check_backing(const struct file *file, fmode_t mode, umode_t ty=
pe)
> +{
> +	fmode_t io =3D mode & (FMODE_READ | FMODE_WRITE);
> +	/* Drivers may point ->f_mapping at something else. */
> +	umode_t fmt =3D file_inode(file)->i_mode & S_IFMT;
> +
> +	/* O_PATH files are only fine for callers that just use the path. */
> +	if ((file->f_mode & FMODE_PATH) && !(mode & FMODE_PATH))
> +		return -EBADF;
> +
> +	if ((file->f_mode & io) !=3D io)
> +		return -EBADF;
> +
> +	if (fmt !=3D S_IFREG && !(type =3D=3D S_IFBLK && fmt =3D=3D S_IFBLK))
> +		return -EINVAL;
> +
> +	/* Look through stacking filesystems at the inode with the data. */
> +	if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
> +		return -EINVAL;

[Severity: Medium]
Can calling d_real_inode() on an O_PATH overlayfs file trigger a WARN(1)
in ovl_d_real() and bypass the SB_I_PSEUDO check?

When a file is opened with O_PATH, do_dentry_open() returns before calling
f->f_op->open(), so ovl_open() -> ovl_verify_lowerdata() has not run yet.
When file_check_backing() is called with FMODE_PATH, d_real_inode()
invokes ovl_d_real(dentry, D_REAL_DATA):

fs/overlayfs/super.c:ovl_d_real() {
    ...
	err =3D ovl_verify_lowerdata(dentry);
	if (err)
		goto bug;
	lower =3D ovl_dentry_lowerdata(dentry);
	if (!lower)
		goto bug;

real_lower:
	/* Handle recursion into stacked lower fs */
	return d_real(lower, type);

bug:
	WARN(1, "%s(%pd4, %d): real dentry not found\n", __func__, dentry, type);
	return dentry;
}

On an overlayfs mount using data-only lower layers or metacopy verity
validation, ovl_verify_lowerdata() takes the inode lock interruptibly via
ovl_inode_lock_interruptible() and performs lazy lowerdata lookup or
verity checks.  If that fails (for instance with -EINTR from a pending
signal, or -ENOENT / -EIO), ovl_d_real() fires WARN(1) and returns the
overlayfs dentry itself.  Because the overlayfs superblock does not set
SB_I_PSEUDO, the check here passes even if the underlying data layer is a
pseudo filesystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D33

