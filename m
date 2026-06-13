Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8FFCD98C5
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Jun 2026 11:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DvZMR1QUrz7VX4kmekzbTADtQ0s3VvgIG6KjNNubZk0=; b=qPHVaO6mE8t4MQaVJemq7wt5ZK
	xJg5JooeeA5AxhkDfkrZrkgnX3FOkqTiZE90fZCGGzN16cAm+SnZt/qsmKKkkdXzv6pO6QKtgEc+Y
	pfOjnyhxgXleuqxgdivw0o4Xh8+0WBwdf7269WwODS40v12sEE7xNsPfoqjI7BHEsoKoRqXs7x9My
	ltIhd0xoNchpmQVt6FxVcJllNvvqGNHsbfuonWx+BcxQnE1PvfB6xcUgqZeq1zs/+9ab8Uarnha/m
	kgL/+53jrMWh/Pdk5SdS0PsM+hRWITgjZSKpHpyJ5lpvuZt4ENopt6yuEaJcYgm5jxvoqrVNMw2h2
	7pZk5QTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKN-0000000CE6a-0rzz;
	Sat, 13 Jun 2026 11:15:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKL-0000000CE5V-2hrL
	for linux-nvme@lists.infradead.org;
	Sat, 13 Jun 2026 11:15:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1F8F3601FA;
	Sat, 13 Jun 2026 11:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169081F00A3A;
	Sat, 13 Jun 2026 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349300;
	bh=DvZMR1QUrz7VX4kmekzbTADtQ0s3VvgIG6KjNNubZk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zw3wXCGSt9teXVf9DzRa3sXQKoawhpXn+huiTyZorYsfkctuETL7aV5RSxt4gpxhx
	 ssTt8rxgcJWzb0uc4+kFCfkgb7U0pdjwg+ASznLBNmOHu92Xe0SiMlXoZqBilOKm72
	 jdiIkrkWu7A2AbpNzN+q6aE2ApHJsTN79UnBM72GDeilYfQihO7b2IFzVv/GmoG+A6
	 hThfW/nNGi5Ty/LHMDD/EZ9gzX+8ows5NUixSRs5vvI0thKNnYCiefevH/Tu+tb7am
	 71NqyG/2MRgeVxzvnG6j0zpX9FPLvbMpPQBKaNH57jcZxi1ePovV83xTnU0CCqpv4k
	 z4HnImMe/XFRQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/8] fs/configfs: switch to get_tree_keyed()
Date: Sat, 13 Jun 2026 13:14:36 +0200
Message-ID: <20260613111437.101763-8-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613111437.101763-1-hare@kernel.org>
References: <20260613111437.101763-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/configfs/mount.c | 49 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 8de3ae0cb6dd..197f5a13a62d 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
+#include <linux/mnt_namespace.h>
 #include <linux/configfs.h>
 #include "configfs_internal.h"
 
@@ -26,6 +27,13 @@ struct kmem_cache *configfs_dir_cachep;
 static DEFINE_XARRAY(configfs_super_xa);
 static struct configfs_super_info *configfs_root = NULL;
 
+static u64 configfs_ns_id(struct ns_common *ns)
+{
+	if (!ns || is_ns_init_id(ns))
+		return 0;
+	return ns->ns_id;
+}
+
 static void configfs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
@@ -106,9 +114,13 @@ void configfs_put_super_info(struct configfs_super_info *info)
 
 static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct configfs_super_info *info = configfs_get_super_info(0);
+	struct configfs_super_info *info = sb->s_fs_info;
+	struct ns_common *ns = fc->fs_private;
 	struct inode *inode;
 	struct dentry *root;
+	u64 ns_id = configfs_ns_id(ns);
+
+	pr_info("%s: ns %llu\n", __func__, ns_id);
 
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
@@ -125,21 +137,18 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		inc_nlink(inode);
 	} else {
 		pr_debug("could not get root inode\n");
-		configfs_put_super_info(info);
 		return -ENOMEM;
 	}
 
 	root = d_make_root(inode);
 	if (!root) {
 		pr_debug("%s: could not get root dentry!\n",__func__);
-		configfs_put_super_info(info);
 		return -ENOMEM;
 	}
 	config_group_init(&info->group);
 	info->group.cg_item.ci_dentry = root;
 	root->d_fsdata = &info->root;
 	sb->s_root = root;
-	sb->s_fs_info = info;
 	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
 	sb->s_d_flags |= DCACHE_DONTCACHE;
 
@@ -151,15 +160,44 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int configfs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, configfs_fill_super);
+	struct ns_common *ns = fc->fs_private;
+	struct configfs_super_info *info;
+	int err;
+
+	info = configfs_get_super_info(configfs_ns_id(ns));
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
+	struct ns_common *ns = fc->fs_private;
+	u64 ns_id = configfs_ns_id(ns);
+
+	fc->fs_private = NULL;
+	pr_info("%s: ns %llu\n", __func__, ns_id);
+	if (__ns_ref_put(ns))
+		pr_debug("%s: drop ns\n", __func__);
 }
 
 static const struct fs_context_operations configfs_context_ops = {
 	.get_tree	= configfs_get_tree,
+	.free		= configfs_fs_context_free,
 };
 
 static int configfs_init_fs_context(struct fs_context *fc)
 {
+	struct ns_common *ns = from_mnt_ns(current->nsproxy->mnt_ns);
+
+	if (!__ns_ref_get(ns))
+		return -EAGAIN;
+
+	fc->fs_private = ns;
 	fc->ops = &configfs_context_ops;
 	return 0;
 }
@@ -180,6 +218,7 @@ static struct file_system_type configfs_fs_type = {
 	.name		= "configfs",
 	.init_fs_context = configfs_init_fs_context,
 	.kill_sb	= configfs_kill_sb,
+	.fs_flags	= FS_USERNS_MOUNT,
 };
 MODULE_ALIAS_FS("configfs");
 
-- 
2.51.0


