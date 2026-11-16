Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3C606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=h1rStkUp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnZy2toz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gm216H5g8yPIS0hPFinwHy6mVVrhGulY+53WmPc6rN0=; b=h1rStkUp9S5mf33R2/pVxqMh0w
	QbG+Tw+CIG+xqeG6MDzkqUzL1DGsWoBHqPDA/WGUusI2fJ7CrzWu0XNPIXz4m+OTra77ANTdw0Gpl
	3BpKnf5Soyqe0iieelytuAU9EtoRxAdxKbuVdZvuyBBaHwST5lbMGJkZFQVpWK8lhmD5GvXTymvtK
	9AJHyDYL10HJ49oYudRBWwliGG+crj+BzwBVPF0+AX9nBq/XpzFADW4M0da0WZgENDn/7V0wu4UcZ
	sq6gu0N/woWD4eDS7rKsHMnZk3p8XUY6oDeZmxMk50vLRWuZh8Jq8P7KFzxYDr6O13XuBJAuASwNt
	9uVEfuPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSw03-00000002PKh-2FgD;
	Mon, 16 Nov 2026 12:39:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvNh-00000002HQf-0dUd
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 12:00:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 86E6662928;
	Mon, 16 Nov 2026 12:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04FD1F000C4;
	Mon, 16 Nov 2026 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794830416;
	bh=gm216H5g8yPIS0hPFinwHy6mVVrhGulY+53WmPc6rN0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hnZy2tozWrqXpWLl+o5+qP9GJB7maIdtKambAdlwVeTUYSiv1MRn2/JyDHmnbWh9z
	 9WDgZMPWzEFJyZJLu9/wsHqC4IslySPV7y2m6l1l6Pr8NgVibCFxmyKogUiorVMDDs
	 oSUXCyKp79VfkW+5dB+6SUIEC6UIXRKMD5lFDe0TpDOweWXRS/8hWTozfLGQIQW1P3
	 PpqAtsruCxsT/ZGQgn4L2ujm+ycdGpwnf6KZ9ATazwCNfMJ3LvW1RLCzk2tHDAf+iS
	 l45B1JKOto718M05wX+oTkpRye0x56eTuMcf1pJlfnKjWSS9tECKCjPVeZoo9oaT6o
	 l+RQ5GFUaEe7w==
Content-Type: multipart/mixed; boundary="===============5220694122544816000=="
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <cb28f09c85a473a23f14c9bd6ef135950197c9fbf966c1f7055d791977d29286@mail.kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-38-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-38-8cbbea1cf34f@kernel.org>
Subject: Re: [PATCH RFC v3 38/44] nvmet: refuse files on pseudo filesystems as namespace backing files
From: bot+bpf-ci@kernel.org
To: brauner@kernel.org,linux-fsdevel@vger.kernel.org
Cc: jannh@google.com,mason@kernel.org,josef@toxicpanda.com,hch@lst.de,linux-block@vger.kernel.org,linux-kernel@vger.kernel.org,linux-nvme@lists.infradead.org,viro@zeniv.linux.org.uk,jack@suse.cz,linux-scsi@vger.kernel.org,target-devel@vger.kernel.org,driver-core@lists.linux.dev,linux-mm@kvack.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,selinux@vger.kernel.org,apparmor@lists.ubuntu.com,linux-nfs@vger.kernel.org,netdev@vger.kernel.org,fuse-devel@lists.linux.dev,linux-efi@vger.kernel.org,xen-devel@lists.xenproject.org,ocfs2-devel@lists.linux.dev,linux-s390@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-usb@vger.kernel.org,amir73il@gmail.com,linux-erofs@lists.ozlabs.org,linux-kselftest@vger.kernel.org,brauner@kernel.org,chris@chrisdown.name,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 12:00:14 +0000 (UTC)
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:39:20 -0800
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5220694122544816000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> nvmet: refuse files on pseudo filesystems as namespace backing files

TL;DR: The series may not build: file_check_backing() in fs/read_write.c calls
d_real_data_inode(), which seems undefined anywhere in the tree, so a
prerequisite patch may be missing.

> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -47,10 +47,9 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  		return ret;
>  	}
>  
> -	if (!ns->file->f_op->read_iter || !ns->file->f_op->write_iter) {
> -		ret = -EINVAL;
> +	ret = file_check_backing(ns->file, FMODE_READ | FMODE_WRITE, S_IFBLK);
> +	if (ret)
>  		goto err;
> -	}

Can this be built?  nvmet_file_ns_enable() now depends on
file_check_backing() from f66083ed0be9, which does:

fs/read_write.c:file_check_backing() {
    ...
	/* Look through stacking filesystems at the inode with the data. */
	real_inode = d_real_data_inode(file->f_path.dentry);
	if (IS_ERR(real_inode))
    ...
}

d_real_data_inode() is not defined or declared anywhere in the tree, and
no commit up to the end of the series adds it.  Only d_real_inode() exists
in include/linux/dcache.h, so fs/read_write.c looks like it fails with an
implicit function declaration.

If d_real_inode() was intended, it does d_inode(d_real(...)) without any
ERR_PTR handling, so the IS_ERR() check would never trigger the error path
the f66083ed0be9 commit message describes.

Is a prerequisite patch adding d_real_data_inode() missing from the series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43858134663
--===============5220694122544816000==--

