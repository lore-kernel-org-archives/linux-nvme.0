Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95506CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dsI+pHEENnVSPRRn/9X8duGm2aaLb2NpgWh8jim+CPM=; b=dn+WTqnYiwnW2q0OQULhllGRoP
	yhSi1h3T+cDzasCHueaUlvpA0GQ11A5pDEYlCrs4T7P46RlxUtul8VThsJXsnczDpb3nwBqz7yst7
	w+zq6VSplMq/T4/v7NDERqmPx1KPy0WzFvHfGkQSX+0NkZLtEUBKsbjC+E63wZSOzSmjgjqUYFxV9
	iz5x2ZB9ZR9jLsc0rmvCQXEaRBoIAflQd8Jg3hMmUUE/gGzv4uD5CI1Ok171gJ99JH7YtjiJYrasM
	sHvBS948ntE39IiObB7Ru43WuAYOcgtj0M6/p8fnpXbl9wwbPnfgzzyNDJrIFicmb7CGLCEgxiqaq
	R60PbmCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUj2-00000002AjW-3a1c;
	Fri, 19 Jun 2026 08:37:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUj1-00000002AhH-0o8M
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 08:37:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A2048601F0;
	Fri, 19 Jun 2026 08:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04941F000E9;
	Fri, 19 Jun 2026 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858238;
	bh=dsI+pHEENnVSPRRn/9X8duGm2aaLb2NpgWh8jim+CPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nBnLcrwNGdfgsyY+shY2f0ROOes+Ir5xTqmWIoJciQMA/kJQ3rDFTnq+aw/XnASda
	 FTbGNTlQXi6VhKE3bMTWYZUr+tuKXAmEAfUaBGbIWMF9I/Ztm9hP35Yg5cPcg5FMa3
	 pa2qEsDDsbIWtEJ5KB6DaEBI45Npsx1XduuD0uw3Hp+nNOhs7IiddWpT6MgbzpkpEo
	 M7CaXBLM2lVeUuYsPhaWpje0r/TIox7s2R0Ps5f2B7VnrotoXu8mF2vhKKGHXMw1pG
	 zmawrK0YQxBYG02SiSt+yV+5SXM5XGsiIl91f3G0qFIkVz45IuB+11P/NqutWT13TH
	 8Yp0L/nRKzsGQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 19 Jun 2026 10:36:48 +0200
Subject: [PATCH RFC v2 08/12] fs/configfs: switch to get_tree_keyed()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-8-82fd7094b8dc@kernel.org>
References: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
In-Reply-To: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=3948;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=Sp1aD6lr0/ruqYg7MacY1Cj2t49FQ3JeRBmcY0Ey7BY=;
 b=lJR/pV9NZBjYZVx+opmNElEJnFBMeV8tk7VEtfXqtvudHiRQenFh94oqRt/sIBHdybZNEjIui
 NtHCYDxhBwbBiKY1QBFSX6s1bYE3ADLfD/OACYtqjZPnKFd/8lQqrye
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
 fs/configfs/dir.c   |  6 ++++--
 fs/configfs/mount.c | 31 ++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index b87b92e3a248dfb091eb52727f06cc4551143f7b..4caf040a909115ac1997a99a81ba38ffac065449 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1968,8 +1968,10 @@ void configfs_link_subsystems(struct super_block *sb,
 
 	if (WARN_ON(IS_ERR(parent)))
 		return;
-	if ((info->net_ns == &init_net) || WARN_ON(parent == info))
+	if ((info->net_ns == &init_net) || WARN_ON(parent == info)) {
+		configfs_put_super_info(parent);
 		return;
+	}
 	mutex_lock(&parent->subsys_mutex);
 	list_splice_init(&parent->subsys_list, &subsys_list);
 	mutex_unlock(&parent->subsys_mutex);
@@ -2080,7 +2082,7 @@ void configfs_unlink_subsystems(struct super_block *sb,
 
 void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 {
-	struct configfs_super_info *info = configfs_get_super_info(0);
+	struct configfs_super_info *info = configfs_get_super_info(&init_net);
 	struct config_group *group = &subsys->su_group;
 
 	if (WARN_ON(IS_ERR(info)))
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d36fc4a6f6439bea645e62b8423b518a5d7d51c1..36f275aaaf871f748dfcb011b782c22abe19d9d5 100644
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
+	struct net *net_ns = get_net_ns_by_pid(current->pid);
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


