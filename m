Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB6606A331
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=grI9kXfw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uq//O83y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jmFaSxEkxznu2joKRb4CtLIuI9acOjlBj4phgIO6eYw=; b=grI9kXfw9H1esOsCFtCMgs1RRR
	B2vSOzONFhMuaMvscaSTbgrI2hM0d9t/vxjqEcfPw9x9yMdV0XzKsf8sfa4hfzuU6SkLwb7u+brzU
	whauKG1mx9ZA6hgzv1ct8nG2yMi1AR55gessDdbII39cXSz/UyS7jIxyupLVzRDnzllDS4TAW0B6q
	5ZpTl2bNpXYsegJeocovxDkZHpa86FDU4f/W00RLfOnUKOh+VFKHaSCdNFkEti5a7tULa9r0MmzxT
	4QZEPSXSmuM4HK2DyJPlO9rvKeK/cVWqPfHN6Djed7Yz0RgfoiZ8e8LAp645ciJICHB/xYndoFe+f
	Et+mpzGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDQP-0000000G3J2-0gY4;
	Sat, 14 Nov 2026 13:04:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDQN-0000000G3IU-3Zp7
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:04:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4785B60F01;
	Sat, 14 Nov 2026 13:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B7F1F000C4;
	Sat, 14 Nov 2026 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661447;
	bh=jmFaSxEkxznu2joKRb4CtLIuI9acOjlBj4phgIO6eYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uq//O83yckPl8vOXt6Bc5q+ZyVZY4qQBBhRv1J9JLebKgNU5ceZzhurztTOW5DrAd
	 zfzs4HQmFb9YGJjmDtcxKBj7yu1B1/Rt+kAnsgqrjbYGXQx/6WZu5oZBMA4a47YM6E
	 vANzyXh4CyCnG/3GxhlzD2mhbxERzTvUGvtsCtyOUEHdyooDZuvmgQoyOeD6JPloVc
	 jNCzylTQJ6BzxJ80Al9idnTCEUSUVZuZlaHUd3eAe4MQJDf5bdSw+ufDSFi8ELd0hw
	 vRjMIenjc/xng+l2uPAiI9tepuJgl1TxCOqH8MuZFjr46jl/c7HFGZYfzbP3V0RlnJ
	 mxXAEvyBWx8nQ==
Date: Sat, 14 Nov 2026 14:04:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 00/12] fs: take freeze protection for writes to backing
 files
Message-ID: <20261114-tragen-joghurt-wucher-ad0ccbd68f25@brauner>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <avhUn1Hb5iT6zBZp@amir-ThinkPad-T480>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avhUn1Hb5iT6zBZp@amir-ThinkPad-T480>
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

On Sat, Nov 14, 2026 at 01:31:27PM +0100, Amir Goldstein wrote:
> On Sat, Nov 14, 2026 at 11:47:07AM +0100, Christian Brauner wrote:
> > While testing the pseudo filesystem series I noticed that zloop, the
> > nvme target's file backend and the fileio backend of the scsi target
> > with fd_async_io=1 call ->write_iter() of their backing files without
> > taking freeze protection. So their writes go straight through to a
> > frozen filesystem. ext4 complains loudly:
> > 
> >     WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0
> > 
> > Loop doesn't get it right for discard and write zeroes. Those end up
> > calling ->fallocate() of the backing file directly. The fileio backend
> > does the same for UNMAP. And zloop records its write pointers on flush
> > with vfs_setxattr() which leaves freeze protection to the caller. So all
> > of them modify a frozen filesystem just the same. Fix them too.
> > 
> > Looking for more of the same turned up a few simple ones. coredump
> > truncates the core file, overlayfs stores its uuid xattr on mount, nfsd
> > truncates on OPEN and the BPF xattr kfuncs modify xattrs, all without
> > freeze protection. Fix those as well. The ones that need more work in
> > their subsystems I have reported separately.
> > 
> > The fileio backend also frees its aio command in the completion handler
> > while the filesystem may still be using the kiocb. KASAN catches ext4
> > doing that for direct reads on v7.4-rc1. ext4 gets its own fix (cf. [1])
> > but fileio should hold a reference across the submission like loop,
> > zloop and fs/backing-file.c do.
> > 
> > [1]: https://lore.kernel.org/r/20261113-work-ext4-dio_read_kiocb-v1-1-172a88be803c@kernel.org
> > 
> 
> Claude says you missed another one.
> nfs_local_write_iocb_done() does not end_write
> its ended too early right after submission.

I know. There's a bunch more. These are the easy ones.
I sent individual bug reports to susbystems that need larger changes.
NFS is one of them, so is ksmbd, ecryptfs, ima and so on. :)

