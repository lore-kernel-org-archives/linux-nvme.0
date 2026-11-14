Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2131606A89C
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wyVkI34d;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvNkoJDi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=MQkMYpMW6c9dbXl0kUtYm0qMWUey+Dbbncjy0mbm15w=; b=wyVkI34d4sGNsn6slcGg9Ah35V
	VMvQVYwYpkKzGNw1jc9ssR+HjrD/jcVsHByaDzJEvfIYT4HQzobvl2N9J7HkylWY80a1C8d0opdAf
	WUeJAkve3t1D/pjL1kjhOiT6AiIn5qFwmmLBdYwyc3zUvhj+J/wY/DvihQiTTJ+uAPc7z0VSWNr0w
	xxFCPAZz0gh8wIqK2Kg70Uvfsdhywx74s4amLnwZz1nNyp8h5Yzs+qLulMHIVQRvYPOD0XoZbjxSh
	NC81DY3dIeu1DN817sN1tkGmcBDg3sUEQxM2cdNJ2cKLm0nWUcVdxIHD+csKkuLmjlnnBzE4oWrGt
	BixNKWVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBIR-0000000FomE-3J1Y;
	Sat, 14 Nov 2026 10:47:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBIQ-0000000Folt-1YQ7
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:47:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA41F4249B;
	Sat, 14 Nov 2026 10:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC5B1F000C4;
	Sat, 14 Nov 2026 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653265;
	bh=MQkMYpMW6c9dbXl0kUtYm0qMWUey+Dbbncjy0mbm15w=;
	h=From:Subject:Date:To:Cc;
	b=CvNkoJDiE35EFSDc8g0xEAhwcQfoyoBvSdVQ8uGD4VeiHEw6rERFnX+DK0Fbwmzp/
	 zyVVbirh1X/d0oNUC+8XXfP9HEsn3DWR4u30tnDkIrxNvnwkG745QFKgtZHfpbh+uc
	 Lqj+43Lb/bY+jK2EGU6kqfFn8cuflksc/VaA8obg/msYeRgb3xAqmWKSEMYZd7vmwQ
	 qK3CDxNjLU5ZoAmvOKzZ8Zpf4WXoO8AfH2HvQwLbAbNhaniuwhlc9U3F4qC/HIptoq
	 Sx6onCIZn5vmlBi9Sm85k9i3gzAw3NbvKKvb8K6yTHKw9YIGCjV56vHWz0vg1WHgsu
	 xxP+8nPL/I0ZQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/12] fs: take freeze protection for writes to backing
 files
Date: Sat, 14 Nov 2026 11:47:07 +0100
Message-Id: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMQQrCMBBFr1Jm7ZQmShWvIiJJnNhRSGSmWrH07
 ia6cvk+778ZlIRJYd/MIPRk5ZwKmFUDYXDpQsjnwmA72xtj1jhluWFUjJLflE6T8EiK3cYGt+2
 tj34H5XsXivz6dg/HH+vDXymMNVYN75TQi0thqFPNtlHbv2xbJViWDwd/hFymAAAA
X-Change-ID: 20261113-work-fs-frozen_writes-042ca762bfb8
To: Jan Kara <jack@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
 linux-nfs@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3062; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eh7GvZ6DLWmxHAd9BvErC5zF8vVRkJFT707D3W+n3qQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9sLFpvyzxoU3qgPvm31Pv6uzjay3U7fOZUaB4id3QN
 X/G+XvmHSUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpT2P4MWmevfWCdaGzE3yD
 jNM384f58Dkcyw38dk1I0XY/E08dI8OOL9Ir+1PjdeOP/U3/ztokqMonbv9+84dMp+RHGV4VPKw A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While testing the pseudo filesystem series I noticed that zloop, the
nvme target's file backend and the fileio backend of the scsi target
with fd_async_io=1 call ->write_iter() of their backing files without
taking freeze protection. So their writes go straight through to a
frozen filesystem. ext4 complains loudly:

    WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0

Loop doesn't get it right for discard and write zeroes. Those end up
calling ->fallocate() of the backing file directly. The fileio backend
does the same for UNMAP. And zloop records its write pointers on flush
with vfs_setxattr() which leaves freeze protection to the caller. So all
of them modify a frozen filesystem just the same. Fix them too.

Looking for more of the same turned up a few simple ones. coredump
truncates the core file, overlayfs stores its uuid xattr on mount, nfsd
truncates on OPEN and the BPF xattr kfuncs modify xattrs, all without
freeze protection. Fix those as well. The ones that need more work in
their subsystems I have reported separately.

The fileio backend also frees its aio command in the completion handler
while the filesystem may still be using the kiocb. KASAN catches ext4
doing that for direct reads on v7.4-rc1. ext4 gets its own fix (cf. [1])
but fileio should hold a reference across the submission like loop,
zloop and fs/backing-file.c do.

[1]: https://lore.kernel.org/r/20261113-work-ext4-dio_read_kiocb-v1-1-172a88be803c@kernel.org

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (12):
      fs: add kiocb_start_write_trylock()
      zloop: take freeze protection for writes
      nvmet: take freeze protection for writes to files
      target: fileio: don't free the aio command under the filesystem
      target: fileio: take freeze protection for aio writes
      loop: take freeze protection for discard and write zeroes
      zloop: take freeze protection when recording write pointers
      target: fileio: take freeze protection for unmap
      coredump: take freeze protection for the truncate
      ovl: take freeze protection when storing the uuid
      bpf: fs/xattr: take freeze protection in the xattr kfuncs
      nfsd: take freeze protection for the truncate on open

 drivers/block/loop.c              |  2 ++
 drivers/block/zloop.c             | 31 ++++++++++++++++++++-------
 drivers/nvme/target/io-cmd-file.c | 37 +++++++++++++++++++++++++-------
 drivers/target/target_core_file.c | 44 ++++++++++++++++++++++++++++++++-------
 fs/bpf_fs_kfuncs.c                |  8 +++++++
 fs/coredump.c                     |  6 ++++--
 fs/nfsd/nfs4state.c               | 10 ++++++++-
 fs/overlayfs/util.c               |  8 +++++--
 include/linux/fs.h                | 22 ++++++++++++++++++++
 io_uring/rw.c                     |  9 +-------
 10 files changed, 142 insertions(+), 35 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261113-work-fs-frozen_writes-042ca762bfb8


