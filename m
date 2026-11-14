Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CCA606A33A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OeRcz9cB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zsg1yBCD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CZfWByojIILKVZ4K9YT1Vj6xfFon+RCsS6XQhj1o2C8=; b=OeRcz9cBqyWn5u93quFZDGPqn+
	GKVyCLTJxPggAmKk+SaVG2t/ZAMi3q2rkQj83W+UpOC51YrB8Cz4iEXdZ8kp1WE8/PRZWZA8NJofI
	M0f6qtyZRF6oa/bzP6Usw28NaxuZWGWr77MSJmz+jVak1twugIthisCrvQ/MlXXtSsDfJBrBV8Utg
	k/5NRSl1rmhoOlM8qAhqh3t4UZ1r4eKStpjfeyYtGDazwF2YUnqb5ice5hBYutk+lcAShr0gUornM
	qCIY+SSP6TA86H41yrnGyYls8fw+H7R6K4l/s3tJ30uRo+lZTOHI4prF56E+3wTewfFpXSjJTlFYL
	FGjMikZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSCuq-0000000G0aR-3NwE;
	Sat, 14 Nov 2026 12:31:32 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSCuo-0000000G0a4-3DTy
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 12:31:32 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-c4d30639709so313503066b.0
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 04:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794659489; x=1795264289; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CZfWByojIILKVZ4K9YT1Vj6xfFon+RCsS6XQhj1o2C8=;
        b=zsg1yBCD9mC/deiKBiowvzneSgWmlFzHzcpLk0YxmQcK4LpJ7/rFtsqvrcyeJYXRUp
         XKtVwb03E7afgoAEBP/3HhRerSqPt05yyh/Be4TDqQsb5VrV8mlUiim7fECgKUinMMpt
         PtlpqJkHQjsW5i0jrgzto1aEv1RXZpRzHbqXYtNsHmCPxWNxwL01tpy5NguAIFV183MJ
         HAAhnfKMkbvIG8pZ4Qfpn6xM30P/GjBOSqnolkaSvsy4skTjW+IYd7OdC3+lnO7R0qUS
         agTaR23+tRzBxyBWHb8BAk4Pv2xxz07HaqXvBkIltRrKjAlh3Xi1k9juZeLNrKFiQrLe
         bghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794659489; x=1795264289;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZfWByojIILKVZ4K9YT1Vj6xfFon+RCsS6XQhj1o2C8=;
        b=rC5Cdqo0R7vmnv2B+6GuadLbjbQyRYH7AogiBj670J/AP/EtWUDm1FL6KNM3lzZf2h
         DckeSo03HgpZd9udVDxI+fcfZ0O9MBOB5tRktjb3JfWni5UG1Tyu5O3qDs2v3wax44so
         6kyWqn0WHXg1A5liHpbqrrjTz4p96WpGgI3lWoWclfcc8F992Pj15CVA1oblXeNe2y2N
         +VeRMBTHpsYK/25Iibs8ZzsvUUMvdDBefNLXxL/ifK3CgDoi5FJ9auVKjNFcW//3VeIm
         aRkSbmTDYG+NiZQx8xuhN5UyQnC9KAOyDia+AUdfZQYoJ/FuCPpF5kizV5jBGUkFzN2i
         tnLA==
X-Forwarded-Encrypted: i=1; AL+hErGGirMTWS62c78kngouZQvr8EPHwcsizcvU2QRmjlwTjrQv4aXCktBn2U2XuRwzbjWebjka+qTQuhHO@lists.infradead.org
X-Gm-Message-State: APuU4Z9rkex6LuN620IMZrrMTMUBWDN/Yexxzc15Zc04mUVbKrIaoDKU
	dXOXUh32keWvJZ9ZB5ksQwiYmQsBE7xkNy9B3+Gc5kgW+E/Ao2MEkVml
X-Gm-Gg: AYBFou06xjDZj8KVsw11iR3H37Y7fS0lqF3olYJf4rmWJ+RrjulNiQBkjXTbhXY9oZ4
	8NIlXvtr7OMu+e8Fmd9i1BmSfA6Si6+26Ov9oQaZH9FFhkRgk/Ah7oA/6v56A+nzfNDXfuK3O4r
	xyzc5mfiTQCMeNeT3OVPvvVBetfh08Juyiav1S0e8yNgWG6d3P6TbDzwxXRrLz0tbdhjs4VQJnS
	zqJGIK6Syzc146jvvWJTndGjtAijww5oc7HgW/qJmVo4BcJUaz/CdS/6GB8Q5KZTWKVb9tY39LV
	QgQhRyOngPUo5VM/ZP51sDLW1Z2gTFfdDB41VrvbhQpCtN9qwL4K5vO0mNoij+1o9E+i7niwjq0
	Z7FDrc3J7cIT9f8rrR1Zo/vIyacahZ487OwFuOVfvNAgnlVnpc+B4MYhlBVz55DZTnO398Z0brd
	iQr8/4AdNzNDisVSX+jXxlWQD8Stoh3YeilRC4vRr+aLUX7b8dqQc1gauCNDl8ix0y78rVehmY/
	EhkbkLCUcDd27eCTpcjI14anh2fS0C+YMCsjfrlW3NHVgG7MXo0Pr4yu9A3ptFsyyhII2r8PdqI
	9Lq7fNs/aYCwOjaLg7lH2zlxUA3E3hoQ9Pyk/X27KDxBXLRd5ba6ZlAzeSjk2GtJx78ehWcpXM8
	+iDDskbSou6sI
X-Received: by 2002:a17:907:3d0d:b0:c46:7fa4:922b with SMTP id a640c23a62f3a-c509643babcmr407431366b.33.1794659488691;
        Sat, 14 Nov 2026 04:31:28 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm213162066b.0.2026.11.14.04.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:31:28 -0800 (PST)
Date: Sat, 14 Nov 2026 13:31:27 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 00/12] fs: take freeze protection for writes to backing
 files
Message-ID: <avhUn1Hb5iT6zBZp@amir-ThinkPad-T480>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_043130_858456_C570C7AB 
X-CRM114-Status: GOOD (  21.14  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 11:47:07AM +0100, Christian Brauner wrote:
> While testing the pseudo filesystem series I noticed that zloop, the
> nvme target's file backend and the fileio backend of the scsi target
> with fd_async_io=1 call ->write_iter() of their backing files without
> taking freeze protection. So their writes go straight through to a
> frozen filesystem. ext4 complains loudly:
> 
>     WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0
> 
> Loop doesn't get it right for discard and write zeroes. Those end up
> calling ->fallocate() of the backing file directly. The fileio backend
> does the same for UNMAP. And zloop records its write pointers on flush
> with vfs_setxattr() which leaves freeze protection to the caller. So all
> of them modify a frozen filesystem just the same. Fix them too.
> 
> Looking for more of the same turned up a few simple ones. coredump
> truncates the core file, overlayfs stores its uuid xattr on mount, nfsd
> truncates on OPEN and the BPF xattr kfuncs modify xattrs, all without
> freeze protection. Fix those as well. The ones that need more work in
> their subsystems I have reported separately.
> 
> The fileio backend also frees its aio command in the completion handler
> while the filesystem may still be using the kiocb. KASAN catches ext4
> doing that for direct reads on v7.4-rc1. ext4 gets its own fix (cf. [1])
> but fileio should hold a reference across the submission like loop,
> zloop and fs/backing-file.c do.
> 
> [1]: https://lore.kernel.org/r/20261113-work-ext4-dio_read_kiocb-v1-1-172a88be803c@kernel.org
> 

Claude says you missed another one.
nfs_local_write_iocb_done() does not end_write
its ended too early right after submission.

Thanks,
Amir.

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Christian Brauner (12):
>       fs: add kiocb_start_write_trylock()
>       zloop: take freeze protection for writes
>       nvmet: take freeze protection for writes to files
>       target: fileio: don't free the aio command under the filesystem
>       target: fileio: take freeze protection for aio writes
>       loop: take freeze protection for discard and write zeroes
>       zloop: take freeze protection when recording write pointers
>       target: fileio: take freeze protection for unmap
>       coredump: take freeze protection for the truncate
>       ovl: take freeze protection when storing the uuid
>       bpf: fs/xattr: take freeze protection in the xattr kfuncs
>       nfsd: take freeze protection for the truncate on open
> 
>  drivers/block/loop.c              |  2 ++
>  drivers/block/zloop.c             | 31 ++++++++++++++++++++-------
>  drivers/nvme/target/io-cmd-file.c | 37 +++++++++++++++++++++++++-------
>  drivers/target/target_core_file.c | 44 ++++++++++++++++++++++++++++++++-------
>  fs/bpf_fs_kfuncs.c                |  8 +++++++
>  fs/coredump.c                     |  6 ++++--
>  fs/nfsd/nfs4state.c               | 10 ++++++++-
>  fs/overlayfs/util.c               |  8 +++++--
>  include/linux/fs.h                | 22 ++++++++++++++++++++
>  io_uring/rw.c                     |  9 +-------
>  10 files changed, 142 insertions(+), 35 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261113-work-fs-frozen_writes-042ca762bfb8
> 

