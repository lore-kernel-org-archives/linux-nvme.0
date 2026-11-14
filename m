Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F722606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rPZxT1Ar;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGIR5RMy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ujAYX702mc5Sy0ms/mnvtMDStt7ZaMRxVBxVaGnEd2E=; b=rPZxT1AryWeiW4ULkDpzq/Fx8p
	mluJsgajszbMbbqzfQocCC8ExmOHUBhKHza/FAp0Xt3o62X0oKfxGWOZJyGa0WRutJiUpAQVUfRmQ
	aOnc6f8NUSffcqJAPQgQw7aoUiE8EHmBCXoOgNN+tnI3sNzG24S06ny+/W5WY5iIwaOcf6FvqHukA
	Ed+Z3Y8NQKbUVEqWqztyTcbj9a2KN3ksnQkhrT/k6Ye80Foav+EGbUpWnDMbtI3p4dRz6z0dM2n8j
	ESpHO7lzyoeqzDmBog3XVbxfZOPkfZsqBLi+YlY3KZeecfG4k5YoR6iK+ss0b/VfTKSAUGv5w535H
	UcylOB9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSC4t-0000000FuUe-1dfg;
	Sat, 14 Nov 2026 11:37:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSC4s-0000000FuUY-0RII
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 11:37:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 538BA62414
	for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 11:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B39E1F000C5;
	Sat, 14 Nov 2026 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794656269;
	bh=ujAYX702mc5Sy0ms/mnvtMDStt7ZaMRxVBxVaGnEd2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aGIR5RMyAniR1rioEnJ7wtm6ltifCa1wJvlOysTnWPrqtPcoxI1w6HRvLT+JMvwXm
	 BITtkj1JGs0lpbwvw+km0zmFlMKCEXh+G6OHSm/En0yztUACFPrWB4b8iU4UeWRdBW
	 OVAA2UutC5e92DlloctcNIHsJYwokm0tFmf4i944ahqWDBCBv60QgiI5qnUaMKEAvQ
	 6cJPtGkNbfvToNbdhPoL2hvf3QPRtA9C/ldo0XoFINex1RyfDwvdXkYz+192DXCZIg
	 GxIGgQ2J4AZ2QjIqRjeQu3QBnPOr4jOKzElg6D3cGlLJDA0nFkS8+ucQAdypG8WEdy
	 52gKC4uBSK8Vw==
Date: Sat, 14 Nov 2026 12:37:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, bpf@vger.kernel.org, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH 11/12] bpf: fs/xattr: take freeze protection in the xattr
 kfuncs
Message-ID: <20261114-raumfahrt-bioprodukte-ersatzlos-e6b9f19a6e1b@brauner>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-11-f5ae61c898b1@kernel.org>
 <sashiko-outbox-214394@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-214394@kernel.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 11:11:36AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] bpf: deadlock in bpf_set_dentry_xattr() via
>   bpf_lsm_inode_need_killpriv() [1]
> --
> 
> commit 486e046b7935f74b8ef238345d31e9322cf39132
> Author: Christian Brauner <brauner@kernel.org>
> 
> bpf: fs/xattr: take freeze protection in the xattr kfuncs
> 
> This commit takes superblock freeze protection via
> sb_start_write_trylock() in bpf_set_dentry_xattr() and
> bpf_remove_dentry_xattr() so that BPF LSM programs cannot modify a frozen
> filesystem.
> 
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 35ccd98a4de64..7f61e2efa08ba 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -295,9 +295,13 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__st
> >  	if (!inode)
> >  		return -EINVAL;
> >  
> > +	/* The hook may hold locks or freeze protection already. */
> > +	if (!sb_start_write_trylock(inode->i_sb))
> > +		return -EBUSY;
> >  	inode_lock(inode);
> >  	ret = bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);
> >  	inode_unlock(inode);
> > +	sb_end_write(inode->i_sb);
> >  	return ret;
> >  }
> 
> [Severity: High]
> This problem wasn't introduced by this patch, but can calling
> bpf_set_dentry_xattr() or bpf_remove_dentry_xattr() from
> bpf_lsm_inode_need_killpriv() deadlock on inode_lock(inode) [1]?

Yes, I've been pointing that out quite a few times already.
This needs bpf infrastructure changes to be able to automatically track
the locking context a function can be called from (or something
similar).

