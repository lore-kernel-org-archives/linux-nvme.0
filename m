Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51098CD98C5
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Jun 2026 11:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iu6rBvjoOvKNSLxUBR2DOeDWWTvyfxrhpfZm8j2G/EA=; b=iBOYc0eFXFp3hntr9jitY+AE/u
	P6zUHfAtyGyjfBvzHu4U0raGBcddFnGTUmPYoXVN/atSe7tkozZ8qDGUF21kDnoIJmBlL//yHtxp6
	5welu87pC7STHsiWToB1UR7aTETXjo4np0YTUHd1BoyhG90X1aCnC8yrZddvuw3WTBwR042siMDoy
	cYeCBoR/XsZEZ5lZNqcmnqasvGbgStHT0nD1PF/heYDbP9hvqktUTlWHbxQglzsl7UVIDn/k16+1p
	zsBDkFIW9WOcJr5czDBMwKdjNbN59SW8vsM0NADGGQ1OGxcUDOUIEL3oLVLycjimsnEQXdVk00jAv
	0OF59J9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKI-0000000CE3s-3Yfa;
	Sat, 13 Jun 2026 11:14:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKH-0000000CE2e-1pwV
	for linux-nvme@lists.infradead.org;
	Sat, 13 Jun 2026 11:14:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BB47F43D3C;
	Sat, 13 Jun 2026 11:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A021F00A3A;
	Sat, 13 Jun 2026 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349296;
	bh=iu6rBvjoOvKNSLxUBR2DOeDWWTvyfxrhpfZm8j2G/EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e6tWoE2soNdNngx+ebFBwQ29/VqDMitXwAc4bcAljbPSEhbJc3ut/yHHyj8XcvRUR
	 GJ5V0tjAXt2pyKyAfLr5k4IRRTeuXD7N8vFBKZDKaJGB/dyjM69HaSgG/Zi9lvofpM
	 s9b/FnO3U5HKGFf36CFUrIFCyfYL5uL1o0qRHlZ/UdjdDWJl2iae1DAjWacFX2OON3
	 W/42Si+T4DP1eNAMinZh9E5VfgKoGKrKH7H2mbC0kqWZqrfs39o3XQxlS2qiK9ekb7
	 CHAYPd3Kwh9VO9SvBUenCPRaH+53RS3DyJAy9wZNDg7kLkrONWMA6nrkC/XYi9dCHF
	 mxAt1O0MlB3iQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/8] fs/configfs: add superblock as attribute to configfs_pin_fs()
Date: Sat, 13 Jun 2026 13:14:34 +0200
Message-ID: <20260613111437.101763-6-hare@kernel.org>
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

Each namspace might have its own superblock, so add it as an argument
to configfs_pin_fs() to ensure that the correct filesystem instance
will be pinned.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/configfs_internal.h |  4 +--
 fs/configfs/dir.c               | 10 ++++----
 fs/configfs/mount.c             | 44 +++++++++++++++++++++++++++------
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index e91f4249b83a..a91e97194c3d 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -90,8 +90,8 @@ extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
 extern int configfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *iattr);
 
-extern struct dentry *configfs_pin_fs(void);
-extern void configfs_release_fs(void);
+extern struct dentry *configfs_pin_fs(struct super_block *sb);
+extern void configfs_release_fs(struct super_block *sb);
 extern struct configfs_super_info *configfs_get_super_info(u64 ns_id);
 extern void configfs_put_super_info(struct configfs_super_info *info);
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index cf89c76ea7e6..6e111e3fd0e0 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1114,7 +1114,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	 * Pin the configfs filesystem.  This means we can safely access
 	 * the root of the configfs filesystem.
 	 */
-	root = configfs_pin_fs();
+	root = configfs_pin_fs(NULL);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 
@@ -1141,7 +1141,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	 * If we succeeded, the fs is pinned via other methods.  If not,
 	 * we're done with it anyway.  So release_fs() is always right.
 	 */
-	configfs_release_fs();
+	configfs_release_fs(NULL);
 
 	return ret;
 }
@@ -1896,7 +1896,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	if (WARN_ON(IS_ERR(info)))
 		return PTR_ERR(info);
 
-	root = configfs_pin_fs();
+	root = configfs_pin_fs(NULL);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
 		goto out_put;
@@ -1904,7 +1904,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 
 	err = configfs_link_root(info, subsys, root);
 	if (err)
-		configfs_release_fs();
+		configfs_release_fs(NULL);
 
 out_put:
 	configfs_put_super_info(info);
@@ -1964,7 +1964,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	configfs_unlink_root(subsys);
 	unlink_group(group);
 	mutex_unlock(&info->subsys_mutex);
-	configfs_release_fs();
+	configfs_release_fs(NULL);
 	configfs_put_super_info(info);
 }
 
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index f49c8636eccb..8cf4bda14bec 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -177,18 +177,48 @@ static struct file_system_type configfs_fs_type = {
 };
 MODULE_ALIAS_FS("configfs");
 
-struct dentry *configfs_pin_fs(void)
+struct dentry *configfs_pin_fs(struct super_block *sb)
 {
-	int err = simple_pin_fs(&configfs_fs_type, &configfs_root->mnt,
-			     &configfs_root->mnt_count);
-	return err ? ERR_PTR(err) : configfs_root->mnt->mnt_root;
+	struct configfs_super_info *info = configfs_root;
+	int err;
+
+	if (sb) {
+		struct configfs_super_info *root = info;
+		struct dentry *dentry = sb->s_root;
+		struct vfsmount *mnt;
+
+		info = sb->s_fs_info;
+		if (!info->mnt) {
+			mnt = mnt_clone_direct(root->mnt, dentry);
+			if (IS_ERR(mnt))
+				return ERR_CAST(mnt);
+			info->mnt = mnt;
+		}
+		dget(dentry);
+		mntget(info->mnt);
+		info->mnt_count++;
+		return info->mnt->mnt_root;
+	}
+
+	err = simple_pin_fs(&configfs_fs_type, &info->mnt, &info->mnt_count);
+	if (err)
+		return ERR_PTR(err);
+
+	return info->mnt->mnt_root;
 }
 
-void configfs_release_fs(void)
+void configfs_release_fs(struct super_block *sb)
 {
-	simple_release_fs(&configfs_root->mnt, &configfs_root->mnt_count);
-}
+	struct configfs_super_info *info = configfs_root;
 
+	if (sb) {
+		info = sb->s_fs_info;
+		dput(sb->s_root);
+	}
+
+	pr_debug("release ns %llu\n", info->ns_id);
+	simple_release_fs(&info->mnt, &info->mnt_count);
+}
 
 static int __init configfs_init(void)
 {
-- 
2.51.0


