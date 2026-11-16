Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD86606A33E
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ca/rl815;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzkbn6tP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hXng9hYJH3diUcfIm+3EkeLNi/DrI5XwE9hJbmJZ9MI=; b=Ca/rl815KMWrWoUh1Orz/RgobI
	0hktY7VW262cOMc7agvvB9ZDZXvf6qv2ftMFzVOuh7os652j8UyD6nft/7H5yIfS/9wHJGs2mRELL
	Y8sDqy7DPQz6NK0D8siCI0b9f52JoAIPoYU9AK+rBY7zEesY/AGVS98GJjJO/C/ropKTnOc98Uv5a
	OD49N0XcEY5fTN8i1N3RPVe8QeWR/61TDxghTv1eAwuXmIz6Tu6lMZxIZ+9Onp2IpEZPxJ5uOvWjN
	+lZVtu+LzEPnG1e0rHSZCosfEj85Yxrujw3KIz4p3KvJSqgtziaD/JXGV/LWkXV7u7hh6SIw0ZKRE
	xvuX3Ryg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStDq-00000001ocG-0uKh;
	Mon, 16 Nov 2026 09:41:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xStDo-00000001obM-2Jxq
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 09:41:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 29AC44341D;
	Mon, 16 Nov 2026 09:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A231F000C5;
	Mon, 16 Nov 2026 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822116;
	bh=hXng9hYJH3diUcfIm+3EkeLNi/DrI5XwE9hJbmJZ9MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kzkbn6tPB2bS/Zn/Pn5gXJRXwYUjckO+3EyZRv12Tme1m2pQkOlyS27Q2NJx0bLjq
	 iAF35/8jh5WK0aPjealgqEWqPtYQ2eIjwus2l7uEA6Rw6F/DzFARz9BZlmZeeRX4IA
	 a8T9Xm8NCDxJP3dX2atLlDz9ZBm8mqYBsqZVK7vDVaxJ/ohv+LFKZYXH6eS5lGqyub
	 cuo0dCjJOQ9Cm7L88ZJ23RQ4pRGG9KOeHzD56rkH8lmKmPt3M3ylorww7aaA+S2CPt
	 kiO/myHptFlIERKjXIXwXpMeNSX+FLQjdkTiW70P+l/3Lf4R8ggQC98SE8Kxc70N4V
	 A+Zhh9qKrjqLA==
Date: Mon, 16 Nov 2026 10:41:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 07/12] zloop: take freeze protection when recording write
 pointers
Message-ID: <20261116-biegen-flaute-flanke-cebddae97444@brauner>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-7-f5ae61c898b1@kernel.org>
 <20261116064820.GB2964@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116064820.GB2964@lst.de>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 07:48:20AM +0100, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can we get some kind of debug check into vfs_setxattr to enforce
> callers have taken the write protection?

I considered that and decided against it becuase it will mean everyone
starts splatting which means everyone needs to get their act together by
7.5.

You might not have seen it but I sent out a bunch of bug reports for
subsystems that suffer from the same bug class but that need way more
invasive fixes than anything I'm doing here.

But I guess we can do it if we use the VFS_* macros which are compiled
out unless CONFIG_DEBUG_FS is set. This will still mean that syzbot will
start splatting at these subsystems. If we're fine with that I'm good to
go with this.

Fwiw, the check can't go into __vfs_setxattr(), __vfs_setxattr_noperm()
or __vfs_removexattr(). cap_inode_killpriv(), IMA and EVM call those
from ->write_iter() via file_remove_privs() and kiocb_start_write()
hides the freeze protection from lockdep for aio and io_uring. I have
not bothered to figure out why. Maybe you already know? In any case,
until that's fixed we can't place it there which means this doesn't
catch IMA/EVM at which point this patch becomes pointless.

So that kiocb_start_write() stuff needs to be sorted first by someone.
I'm about 300+ patches or more deep into various tree-wide cleanups. I'm
going to defer this as this seems minor to all the other sh*it that's
waiting to be cleaned up.

-- >8 --
Subject: [PATCH] fs: assert freeze protection for xattr and acl writes

Writing an xattr or a POSIX ACL modifies the filesystem but
vfs_setxattr() and friends leave freeze protection to the caller. Most
callers get it from mnt_want_write(). Some in-kernel callers forgot
about it. zloop and overlayfs are fixed earlier in this series and
ecryptfs and ksmbd have been reported. Christoph asked for a debug check
to catch the next one (cf. [1]).

So warn in __vfs_setxattr_locked(), __vfs_removexattr_locked(),
vfs_set_acl(), vfs_remove_acl() and set_posix_acl() if SB_FREEZE_WRITE
isn't held. This only does something with CONFIG_DEBUG_VFS and lockdep.
Without lockdep sb_write_started() can't tell and claims it's held.
Until ecryptfs and ksmbd are fixed this will warn for them.

Note that __vfs_setxattr(), __vfs_setxattr_noperm() and
__vfs_removexattr() don't get the check. They're also called from
->write_iter() via file_remove_privs() -> notify_change() for
security.capability and by IMA and EVM. aio, io_uring and the in-kernel
async writers call kiocb_start_write() which hides the freeze protection
from lockdep before ->write_iter() is called. So the check would fire
for writes that are perfectly fine.

[1]: https://lore.kernel.org/r/20261116064820.GB2964@lst.de

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/posix_acl.c | 6 ++++++
 fs/xattr.c     | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index fe77934ea8f20..61de6f105ff4f 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -942,6 +942,8 @@ set_posix_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 
+	VFS_WARN_ON_ONCE(!sb_write_started(inode->i_sb));
+
 	if (!IS_POSIXACL(inode))
 		return -EOPNOTSUPP;
 	if (!inode->i_op->set_acl)
@@ -1099,6 +1101,8 @@ int vfs_set_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct delegated_inode delegated_inode = { };
 
+	VFS_WARN_ON_ONCE(!sb_write_started(inode->i_sb));
+
 	acl_type = posix_acl_type(acl_name);
 	if (acl_type < 0)
 		return -EINVAL;
@@ -1220,6 +1224,8 @@ int vfs_remove_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct delegated_inode delegated_inode = { };
 
+	VFS_WARN_ON_ONCE(!sb_write_started(inode->i_sb));
+
 	acl_type = posix_acl_type(acl_name);
 	if (acl_type < 0)
 		return -EINVAL;
diff --git a/fs/xattr.c b/fs/xattr.c
index 0705801a62cc5..715d04111c274 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -302,6 +302,8 @@ __vfs_setxattr_locked(const struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = dentry->d_inode;
 	int error;
 
+	VFS_WARN_ON_ONCE(!sb_write_started(inode->i_sb));
+
 	error = xattr_permission(idmap, inode, name, MAY_WRITE);
 	if (error)
 		return error;
@@ -564,6 +566,8 @@ __vfs_removexattr_locked(const struct mnt_idmap *idmap,
 	struct inode *inode = dentry->d_inode;
 	int error;
 
+	VFS_WARN_ON_ONCE(!sb_write_started(inode->i_sb));
+
 	error = xattr_permission(idmap, inode, name, MAY_WRITE);
 	if (error)
 		return error;

-- 

