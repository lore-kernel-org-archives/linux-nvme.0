Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7186CCD4F26
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 09:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cTu6x6XxRI5vzWe/MWN740NA2s7n0Z9WiTKtNaIwedM=; b=t1mSLs7c06UAS2f7tJ12EVh7n4
	054X3hDw6xgTf5wISERUL+su7obhKB/t4fbSY5Bb4tQKWVYqRuu3QQQiZ2iRwsIw3FSWUEJaH7lRH
	L13kGEoEdtfA8mxz0xAbJ6naUrS5TAB+OzRS0FgWRWJfQEXceyMJWYiAnr8RHUQBwIdrFmQ/z5ahz
	HLfVHeU2wOWjaVuXOHMEQwFix02Xag5XvrE2kxFhekvlzzKKeLdGi6q0Ee7/w+Qa4WDhQO2JEoK40
	QjrGOL+B88LWElxaqSEKv43+JuOGruBefcbA4t7SsrGTJpPIBRgqAaEau3BDNsj7UsnwkYf+0Z838
	6/vvJJRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxF2-00000005zQY-0nzr;
	Tue, 23 Jun 2026 09:16:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxF0-00000005zOa-2Vys
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 09:16:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D3C460052;
	Tue, 23 Jun 2026 09:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5981F00A3D;
	Tue, 23 Jun 2026 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206181;
	bh=cTu6x6XxRI5vzWe/MWN740NA2s7n0Z9WiTKtNaIwedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qz1N5Ce0e66067aoO61H349OhKtAtb804mnwRcQ8wbhDjbm7qoH1FZNVKCLeTklEJ
	 lTOO2UcnNN4BnrNNl6n4XD6TLcZE/qDgRM3QYzds+2wwbKSGKPuIevN19mHYuq8ZOa
	 LuZjWlHk4AXhQ+IzRjnNj+ifZagYRqlqBl9HrgQxdHd0c8fXE8X8ucH9/i0QvjPq6v
	 QAgI6vrYawbB9Pip9VgRDb99MhjBiWHcnTv09PFcumChLwCyYRvRuAT4uKTNjfjUlI
	 59PEIJXEvt4k7QbCyonHikTfFSIivO+BHivo9bmW9AiYYLafI1+Kwicl+0K9uYMqVK
	 +a77oyR2thYGg==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:52 +0200
Subject: [PATCH RFC v3 07/12] fs/configfs: switch to get_tree_keyed()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-7-841c100fd5dd@kernel.org>
References: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
In-Reply-To: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=2892;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=FJV4Qtadh95tNUoGTBfTx4N6VClvPDUcz3P43AJFQLc=;
 b=F7pBShUXZ875Ba2ORmmZ30mK3V91nwhxZYI1QftOCGqDTMxjDZUrP6p4woUTKd+7hpfi6HQqp
 RaHl/4ov/KBAX5bPCGRAxIdNq+9fGfm7ka7CWpnHcgM6GLoDw18QGnv
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Switch to get_tree_keyed() to instatiate a new superblock whenever
the mount namespace changed.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/mount.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d36fc4a6f6439bea645e62b8423b518a5d7d51c1..bcc403f96d25d8385f6c903d40fa752da2610979 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -123,11 +123,10 @@ void configfs_put_super_info(struct configfs_super_info *info)
 
 static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct configfs_super_info *info = configfs_get_super_info(&init_net);
+	struct configfs_super_info *info = sb->s_fs_info;
 	struct inode *inode;
 	struct dentry *root;
 
-	sb->s_fs_info = info;
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = CONFIGFS_MAGIC;
@@ -138,7 +137,6 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 				   &info->root, sb);
 	if (IS_ERR(inode)) {
 		pr_debug("could not get root inode\n");
-		configfs_put_super_info(info);
 		return PTR_ERR(inode);
 	}
 	inode->i_op = &configfs_root_inode_operations;
@@ -149,7 +147,6 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	root = d_make_root(inode);
 	if (!root) {
 		pr_debug("%s: could not get root dentry!\n",__func__);
-		configfs_put_super_info(info);
 		return -ENOMEM;
 	}
 	info->group.cg_item.ci_dentry = root;
@@ -165,15 +162,38 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int configfs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, configfs_fill_super);
+	struct net *net_ns = fc->fs_private;
+	struct configfs_super_info *info;
+	int err;
+
+	info = configfs_get_super_info(net_ns);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	err = get_tree_keyed(fc, configfs_fill_super, info);
+	if (err && fc->s_fs_info)
+		configfs_put_super_info(info);
+	return err;
+}
+
+static void configfs_fs_context_free(struct fs_context *fc)
+{
+	struct net *net_ns = fc->fs_private;
+
+	fc->fs_private = NULL;
+	put_net(net_ns);
 }
 
 static const struct fs_context_operations configfs_context_ops = {
 	.get_tree	= configfs_get_tree,
+	.free		= configfs_fs_context_free,
 };
 
 static int configfs_init_fs_context(struct fs_context *fc)
 {
+	struct net *net_ns = get_net(current->nsproxy->net_ns);
+
+	fc->fs_private = net_ns;
 	fc->ops = &configfs_context_ops;
 	return 0;
 }
@@ -193,6 +213,7 @@ static struct file_system_type configfs_fs_type = {
 	.name		= "configfs",
 	.init_fs_context = configfs_init_fs_context,
 	.kill_sb	= configfs_kill_sb,
+	.fs_flags	= FS_USERNS_MOUNT,
 };
 MODULE_ALIAS_FS("configfs");
 

-- 
2.51.0


