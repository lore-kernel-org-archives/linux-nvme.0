Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61A606A327
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d8UlbMvw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfkXAKnv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Xi+Jp34UVw8n6rWUcn3QcZPlSKYiPMqX7yCNJrzL8oU=; b=d8UlbMvww7KF3olPVIHaOFRJJ3
	Hkbxg0Vig4iQUXcdvGgbROrL2blX5rNXIscx+XCRWmOoOJP3GBlXsT2DFZdt3WYVe0Ug4auO1+owc
	FHxYDbBxtEvf/fMWyO/cQt58MhDqJzin2MUp6xNH4inoRQepWiFSBuCr2khrRZfcN6hHfFxKVWQBs
	VAhnXbI8uoYzTAo4ok5bgs0Y8iaBEaSDrXDzlAJ6WToJ34FKqn3f9jJRTzdGfGBH66fCHI1lqbdtz
	uY3XpuLGfIgTEFbEagsUCMQoFV3QK0G7rEl/GuESrw8WKx6v8WeR/j04PpDJOp1lDjlOhosSsu6qV
	Iau8VLww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFo-0000000GCkJ-3XIc;
	Sat, 14 Nov 2026 13:57:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEDd-0000000GAy5-3KbS
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:55:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4EE0E448C9;
	Sat, 14 Nov 2026 13:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36F01F000C6;
	Sat, 14 Nov 2026 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794664501;
	bh=Xi+Jp34UVw8n6rWUcn3QcZPlSKYiPMqX7yCNJrzL8oU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bfkXAKnvyN3NrzfYhrVigeGIKvr/8evEe0tQ8KwSyEafhDf3+AXVoqojleCZ7/Qdh
	 2b013ZilynaxVntPTxgtS9Fyq3b+7yXhPeXkFfQ9ONM2J9MEOM/JQ3B/znTjkCUpqc
	 r0tlhXctgE98kfAt1ITbmi9H0tApXPCL2XTcrVOM5qnz/NrX0rxwji+SmXMUOe8YHy
	 kRbhgqC/kLnhpgS61Qu7Lfu7BuXDWJsHjF+zOY5u5KKN5rR5uvcX/zOV7QTiz8dq9Z
	 GTd5PKapaf6tpFoOvo6qdgngRWS5W1FIZVvnJWAJ8F5DAYQTkJUN/Wbu5kFv6IHajV
	 XPu1vrQEYpCgg==
Content-Type: multipart/mixed; boundary="===============1687560790659556623=="
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <df03e637354be695652a787563af21ac77b4c61f813ae4491a3397a91df7688e@mail.kernel.org>
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
From: bot+bpf-ci@kernel.org
To: brauner@kernel.org,linux-fsdevel@vger.kernel.org
Cc: jannh@google.com,mason@kernel.org,josef@toxicpanda.com,hch@lst.de,linux-block@vger.kernel.org,linux-kernel@vger.kernel.org,linux-nvme@lists.infradead.org,viro@zeniv.linux.org.uk,jack@suse.cz,linux-scsi@vger.kernel.org,target-devel@vger.kernel.org,driver-core@lists.linux.dev,linux-mm@kvack.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,selinux@vger.kernel.org,apparmor@lists.ubuntu.com,linux-nfs@vger.kernel.org,netdev@vger.kernel.org,fuse-devel@lists.linux.dev,linux-efi@vger.kernel.org,xen-devel@lists.xenproject.org,ocfs2-devel@lists.linux.dev,linux-s390@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-usb@vger.kernel.org,amir73il@gmail.com,linux-erofs@lists.ozlabs.org,linux-kselftest@vger.kernel.org,brauner@kernel.org,alex@amutable.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 14 Nov 2026 13:54:57 +0000 (UTC)
X-Mailman-Approved-At: Sat, 14 Nov 2026 05:56:41 -0800
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

--===============1687560790659556623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> securityfs: use fc_init_pseudo()

TL;DR: Setting SB_I_NODEV on securityfs may make reopening AppArmor's
inherited .null fd (e.g. open("/dev/stderr")) fail with -EACCES, which used to
work; the commit message may also be inaccurate about device nodes.

> diff --git a/security/inode.c b/security/inode.c
> --- a/security/inode.c
> +++ b/security/inode.c

[ ... ]

> @@ -64,6 +65,7 @@ static const struct fs_context_operations securityfs_context_ops = {
>
>  static int securityfs_init_fs_context(struct fs_context *fc)
>  {
> +	fc_init_pseudo(fc);
>  	fc->ops = &securityfs_context_ops;
>  	return 0;
>  }

The commit message says "AppArmor puts a .null device node into securityfs
but only ever opens it via dentry_open() which doesn't care about
SB_I_NODEV."  Is that the whole picture?

aa_inherit_files() installs that dentry_open()ed file into the task's fd
table:

    devnull = dentry_open(&aa_null, O_RDWR, cred);
    ...
    replace_fd(n - 1, devnull, 0);

The fd is not O_CLOEXEC, and its f_path.mnt is the internal mount from
simple_pin_fs() in aa_mk_null_file(), which never has MNT_NODEV.

Opening /proc/<pid>/fd/N, or /dev/stdout or /dev/stderr, resolves to that
same path and goes through the normal open path:

    do_open() -> may_open()
        case S_IFCHR:
            if (!may_open_dev(path))
                return -EACCES;

may_open_dev() checks path->mnt->mnt_sb->s_iflags & SB_I_NODEV.  That bit
was clear on the securityfs superblock before this patch and is set now.

Can this make open("/dev/stderr") fail with -EACCES for an unconfined task
that inherited the .null fd, for example a helper exec'd through a ux/Ux
transition from a confined task?  That open used to succeed.

Should the commit message say that this reopen path is intended to fail, or
does .null need separate handling?  The statement that "securityfs never
holds ... device nodes" also seems to conflict with the .null node described
in the next paragraph.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43599461726
--===============1687560790659556623==--

