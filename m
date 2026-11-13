Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBA606A327
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rViQIi80;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a40WMXuN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=; b=rViQIi801OB4FIza6ar9y33cCT
	qDIVArqSvitTN6ruvgJXR08BkPnvvPBoD+W5Wwi3SyO9lYSPkvOouGnBjrxNKEa1pkeKbDDkZELSj
	UR5u0vcfCqiKHfhNefyVmhZ/LPZuL7JRzpGudjuA3KLYimOrIubhKJ2vMAwrPKtQWURjPJ/PxCKPU
	4I8y/SaNkqR5IVwb+AaP+x/U2snFjFSxIewmzbRhC2Ad1PhBmnaOUAwUH+CS5ArQs5yPVZzcIwaWj
	p9A00G84Q0lINPQcUY+bZLsCvfrjrPXxbK3XDyK7/J4Bzki+xtP2HUEeJvmlZFG0KNUQhUryQBmM1
	/N5dzhcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3c-0000000EDHW-0V4O;
	Fri, 13 Nov 2026 19:35:32 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoJS-0000000CK8A-45HL
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:15:20 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so5469175e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564917; x=1795169717; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=a40WMXuNAUZh4N7TI7r9yn5afBeV2oV8xbXD6+hUy+0loiXDSgtM6w8KlriWpt+FKh
         ZHb5sPFThc4KhyoQjlw8/T+kfT2KqjEe981q5OUsLVs7X+FoyrKgWnQeGE3IgyUrWUg0
         dG0EL0njDpDQVyqwkWZRdGXBItW/1wOVNDNMD0PWtpskeXbPGKkLWDyG8j4/biiUY6RG
         Y/e2e8HLz5J5GWMHPduS+m0C9vY56Uljx2IpSIcOmmDIbwIvxCfayMEfVXykLayLg0mT
         oarGUIgAXXW+UOAF4mATX1ZSRyRWyBY2gZ38MKC/4SmKWqC6u0w+b/q9RD0SU0IyLZqY
         yUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564917; x=1795169717;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=aMk8hNrfOMXf7CZCl7/baja3ddUbUC3v/UK1VrTVi4TPRk1UEU3OM41wJFnb+aShWz
         HHuinwSFQWsaNcIZDh5DpUkm/NGrx23/2gIIcxcklJjVj19WIgJjfb5F7+AA/24obPkA
         xIBk86U1CVjOmB/ymZzfAGshzJ2FlbsrE/+nT/F9RJ8RhcpVRrIv5xyMOiNsq4UKb2ET
         tjDnuIhS00w7Wsh6IGWEF32AvN5qW4rIziwPmv57Pf+4vdqZq5t/QHHn08r+Agqb9Hah
         XY9ZQg27xgAaih/cQM0Bv6p5llmv8BIDspgWvoBezi2OpNzQxHNdd32dv3r8HVSgKZJG
         5z4w==
X-Forwarded-Encrypted: i=1; AL+hErGOh/ZMVQ4sBzZ/iASEdLVdMgQ6ufoYhKhqkFr+W57T9MrOnEOUqO3q93yWMAZl5hJkFj4pIgaJRlah@lists.infradead.org
X-Gm-Message-State: APuU4Z/9EEhyCvVXcTx7cEMc5tQsXg7aJluiq6oAT33jjl30bffgZ/w9
	+G7Sgal2sWPNICjnoutDc/Cw2WhC5j4kkp7/KtkEK+f7GK1gQcQpwfmVTzp5DggnKriA
X-Gm-Gg: AYBFou0HJsIO9mgISNykwzhtcqRVcRNGu9Xj3qWNbi2wrwJRZzZhSOv8XQfJtS8a8xU
	ZH3Tsr5Psd6lhe+/LPxb7RrdPfFe7rkH4IxfdEtRy23cIKhvffv42efdEJ7zv1mRBO3AruYvyln
	F6AIP/GUbrxT/WuKEdRlYsy+YxPb5mtcGRsaHQDIeuUdGulZqHWSkQeDFSRJNJag2yEZPNAsNgf
	J4kydensf2YBzNIFANJP3a5UiL4q2f3ogzl2j/lOHqmj0rDcu03Exqvw6O3GO5l4FNMagX2tVGE
	tntH8gUOVnLsJ4hgXlEiSa2G7KAIkm7fLNgBIMsCbaDnNqzrtEcZlihelJFSeoxN00mmPFtd6Tp
	z6uliPcrGurNge9vP9ZY6Z0xfHQJckCcSDngMbQ936wzE7yDDXGwBbQaCUYO0lKVdSqsTfFdEGk
	ptKOzzU3x3VJcjrkkPy+iB8/0roP2hybZ+13MjtDmrcjRUMhfJEuTn4W+s5O09MklBBU23icfHs
	IXUhg9ZcNAPrhmImdMpHKZ4JJ9KDoiCJ9C6nc34GCJh2rAehNP/UzFBBtytdr//BjsqMb4prA52
	5aQPdF3Kb1/nGNIgdZD92OQklGvV9rDyNrL4wgl0aMBTYIn1idKefeL+7HeBKbU=
X-Received: by 2002:a05:600c:4f84:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4bb5599ade1mr43492835e9.0.1794564916955;
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56680ea9sm31982365e9.0.2026.11.13.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Message-ID: <e2edfa06d185acd86b46945622b6eb6dff97b307.camel@amutable.com>
Subject: Re: [PATCH RFC 33/41] fs: add file_is_pseudo()
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
Date: Fri, 13 Nov 2026 11:15:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021519_031019_21A5B580 
X-CRM114-Status: GOOD (  18.14  )
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
> Add a helper to check whether a file is a regular file on a pseudo
> filesystem. Only regular files count. Device nodes on pseudo
> filesystems
> such as devpts, binderfs or the block devices on bdevfs are what they
> are.
>=20
> Look at the inode that actually provides the data via d_real_inode().
> overlayfs accepts sysfs, cgroup2, debugfs, tracefs, configfs and
> securityfs as lower layers and reads of such an overlayfs file are
> served by the file on the pseudo filesystem. Checking the overlayfs
> inode would miss that.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0include/linux/fs.h | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c..407ffb6342ec 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2553,6 +2553,18 @@ static inline const struct inode
> *file_user_inode(const struct file *f)
> =C2=A0	return file_inode(f);
> =C2=A0}
> =C2=A0
> +/*
> + * Regular files on pseudo filesystems are kernel interfaces and
> must not be
> + * used as storage. Look through stacking filesystems at the inode
> that
> + * provides the data.
> + */
> +static inline bool file_is_pseudo(const struct file *file)
> +{
> +	const struct inode *inode =3D d_real_inode(file-
> >f_path.dentry);
> +
> +	return S_ISREG(inode->i_mode) && (inode->i_sb->s_iflags &
> SB_I_PSEUDO);
> +}
> +
> =C2=A0static inline struct file *file_clone_open(struct file *file)
> =C2=A0{
> =C2=A0	return dentry_open(&file->f_path, file->f_flags, file-
> >f_cred);

