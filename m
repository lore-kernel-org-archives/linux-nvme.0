Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D8606B97A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GzBGgZcK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyzSjZUO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iQwkLUdwk9b1HJi0bdxPWAy3VpDyPS0j6oQB4RnL5Xk=; b=GzBGgZcKmcbvBn
	g5n7cFg1vv4RFnmKEvf8UbRLNx0Lw605RL0/sgg0oMEuZTfq68BwTyipZJik0rGLYSFFdDlP8Mkh/
	ecuwDLeH75mRQpoNe7SKoXWtnOaYdiG5f/wYdS0mCbufoatNlqe74FMzPoB7sA5R58zrOKn7coVZS
	kqTSv12YERRazyT+/4pzsVgsN4SbIeuM7VaYQejwNfAZTSyVaTE94iIp6Pww92bY4X7YLFrvIsP+k
	rIIIiRYtaEtoiJBTE/3CbAQ2K+RyhcSrT3lyHg+Xn3TemBUkVL9/XmFv7PJRZIziHWTJkKKyHiDky
	0tICIfcG/dU661AumZSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBJB-0000000FpNT-40BD;
	Sat, 14 Nov 2026 10:48:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBJ8-0000000FpKs-0Hwx
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:48:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7DD6B61DB2;
	Sat, 14 Nov 2026 10:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA93F1F000CA;
	Sat, 14 Nov 2026 10:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653309;
	bh=iQwkLUdwk9b1HJi0bdxPWAy3VpDyPS0j6oQB4RnL5Xk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MyzSjZUOCkMqwxukt7VaN8gXMiyrREHVgk7OzhnKZrckM70GdKU0qKv0ZdSIzFibC
	 yNcLtgXFEvmLUsACo8/r+ztOlzJz8cPTG/DCDh937l1neOIu2FA9j+VHULxaGnCtHg
	 0T9ACOHXxLignGRROXSQjTsvGu0Qb1iGpVIubsBdkySUjzk8XrPTog/rAj/PC6UB+J
	 xG43+/AfvXWWOICfcVJzbfCPpDTg5CJBRutpyyA/rPh6x2ZxNwApnq6erC/obarzbS
	 jHSE/28xzSlM6Wt6gJiej9FY4WsX2tKG/6XvI+Cj3E/5fiCfP4MZQ6royiIq4JfkMp
	 BEvUvjlVOkAOA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 11:47:18 +0100
Subject: [PATCH 11/12] bpf: fs/xattr: take freeze protection in the xattr
 kfuncs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-fs-frozen_writes-v1-11-f5ae61c898b1@kernel.org>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
In-Reply-To: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NJMGFUseCC73mMaQQ+G2n/tqmaWyJnxTdoOaGvDxcf8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9sPHs5s9Yy7JGu+PbiikBc887ptxsqtO8JJWkmljwK
 tz/8zLPjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInoGzD8T935Qvmx/6oghZhf
 19yWiKhOsDtolrNzK8vuHbziS35fl2P4p5k9W/TL4pTyC1w+mnf19U/cb9Y+b2iuenxBT+bLb3f
 F+AE=
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

bpf_set_dentry_xattr() and bpf_remove_dentry_xattr() go through
__vfs_setxattr() and __vfs_removexattr() which leave freeze protection
to the caller. BPF LSM programs call them from sleepable hooks such as
file_open where nobody holds it. So a program can modify a frozen
filesystem.

The hook may already hold freeze protection or locks a frozen
filesystem would make us wait under. So don't wait for a thaw. Fail
with -EBUSY if the filesystem is frozen.

The _locked variants are only used from hooks that run inside setattr,
setxattr, removexattr, unlink and rmdir. Their callers hold freeze
protection already.

Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 35ccd98a4de64..7f61e2efa08ba 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -295,9 +295,13 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__st
 	if (!inode)
 		return -EINVAL;
 
+	/* The hook may hold locks or freeze protection already. */
+	if (!sb_start_write_trylock(inode->i_sb))
+		return -EBUSY;
 	inode_lock(inode);
 	ret = bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);
 	inode_unlock(inode);
+	sb_end_write(inode->i_sb);
 	return ret;
 }
 
@@ -323,9 +327,13 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
 	if (!inode)
 		return -EINVAL;
 
+	/* The hook may hold locks or freeze protection already. */
+	if (!sb_start_write_trylock(inode->i_sb))
+		return -EBUSY;
 	inode_lock(inode);
 	ret = bpf_remove_dentry_xattr_locked(dentry, name__str);
 	inode_unlock(inode);
+	sb_end_write(inode->i_sb);
 	return ret;
 }
 

-- 
2.53.0


