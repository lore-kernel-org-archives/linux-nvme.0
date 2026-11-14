Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B8C606A32E
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GTvkY7jq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ozu7z0Kj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=f0g6P6hsNAkBmmk1dhVL/yqmLVxvhNEJRF73P8Hffz8=; b=GTvkY7jqTUVBjneiyJfpMtAes7
	H8OTuHiCJ6BjZov5ba5XEQT4XvFWMoUEhJHErfMeYCnUsdZdNq/dbHkrPgCEH+tQkj8MlRkN7ouQU
	fOuhcFNAq3Bi5ur/rR138UqN3ZMXO/85Mk6ynD+NGC6+f6ZYoYUP4E+Iplbh1iI5TKJo3dhDe2U8s
	T+vYqHxG7hWgaeGttDGoZKFWt/7nzkdxUo5qalHsJruhhhZtbEEGnjrsQDFX0D2QVqipenmu0AEy2
	4tE8KCZXsDLv3MLqD4vLAYSPNbyaU5l8ODzYQB76Kba9zcksSonS9FxzXen/B/UcMKKI2QjEJJPp1
	tlMgIKMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFG-0000000GBDF-1TAr;
	Sat, 14 Nov 2026 13:56:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSB9h-0000000FmF0-0cZH
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:38:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 967DE413E2;
	Sat, 14 Nov 2026 10:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE541F000C4;
	Sat, 14 Nov 2026 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794652724;
	bh=f0g6P6hsNAkBmmk1dhVL/yqmLVxvhNEJRF73P8Hffz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ozu7z0Kj1tHIOD24bkiz6twDQ59H2LG047bnoA597yeAQD+7loV9AVNQq6/EfNxmA
	 RAV43n2Xp3rFswhwCvrdVPjCv2twIaBECTwXwjSyPBKOEecSJccYi16iPUffdcy+kX
	 2KsSYHa0TM5q3kVm9Et0sKjXOYpfJER4fjfggVZYik+Tlk8iLg4VYcTfwPq6hSWTb+
	 FqNtagBKrLecsr9nZyvU/RGWRSqwrFdabGVO12uSaA2rrQgzv6ROpsZEsD9jdN00pG
	 9AVp7r2bVcIF0aGX9qNUD3D/9g7VuGmG+jesekdRYeqNRWWlH0zjJp4ZwQJyQCg3y0
	 VLaLdAkJXNuOg==
Date: Sat, 14 Nov 2026 11:38:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, driver-core@lists.linux.dev, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, 
	ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
Message-ID: <20261114-erfrieren-vorher-taktieren-ef10b08e210f@brauner>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
 <20261111145555.GA9996@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111145555.GA9996@lst.de>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:55:55PM +0100, Christoph Hellwig wrote:
> But i wonder if we want a thin wrapper around ->read_iter/_write_iter
> to do this check so that it matches the normal read/write path?

Yes, I had thought about that as well. We could use
vfs_iocb_iter_{read,write}() for that but it's not thin at all and
brings in the LSM into these codepaths where they shouldn't meddle.

So maybe as a follow-up series with a new
vfs_iocb_iter_{read,write}_raw() or whatever. Feel free to make a
suggestion.

