Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FC9CD98D2
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Jun 2026 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7I8kTbXt7+An8cmONBh9uXWN9T0EQQ78/PGWAs08Ho=; b=28G8QnbEaQLCvSKQcgDBZPjx1N
	ooeXRHK6gd0kQUUu+iBkOeP4m/GuGCeEaoPmv74ZEa+nCLyvB8X98zxeSE11hbSQQBvd1mb7sXT7V
	fKWGCHesw0rOEmNy67eI+1vU1bsdWzrgR+qIEy6AuGPONwPlpr0tP8U9Fx/H1Wlk+I+qVL9Fv0ujH
	edq7fKz9oY32zq4w4q+2z628LCpGY4GLfXS4JKC2NalNx9TF3eW7CpQZBb3wRHa90XeMvuxjCfWOD
	nBQYzDMTGmTrAngNwPOHJ57s+lgw8bTtRZRBg1QmNdESRrqh4s79nOOYiYLZuuXLDKbLuWpJD4di+
	32nIPmfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKJ-0000000CE4R-4175;
	Sat, 13 Jun 2026 11:14:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKI-0000000CE3o-41t5
	for linux-nvme@lists.infradead.org;
	Sat, 13 Jun 2026 11:14:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B672F43D0E;
	Sat, 13 Jun 2026 11:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBBC1F000E9;
	Sat, 13 Jun 2026 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349298;
	bh=F7I8kTbXt7+An8cmONBh9uXWN9T0EQQ78/PGWAs08Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekQqlJskaVyLWdoGi/4v5+yBA7AlM0EWwmx4CJ6dba0E3ZVfrf+AIYq0Yel3YINKV
	 qikl1sW8AOd2OY82S/Q/HOVcTufcyBhUQnh61HxED8BtIrSNCTkUq92P5vvKNRkO3U
	 mDI1MiWHuZAktXGLSTpQDo2zFsv7X58JA6c/JXYK3Gsd7yVtvyFM4zFNhFMWlDPZr+
	 KlHO5ZjF4lGJfmfnx6tMDaFdqNOTCf6kqHsA7jN8IVSd9hyBiDkDSLoP5P01Am0ijL
	 NQZvrRmFYue7vx1B0wDsM9PWu/XQ92ZbCsK8oNKhUFMAy6ch0bA4kzVV+KBaHyJfBw
	 swxB7GLDxOapw==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/8] fs/configfs: add 'fill_subsystem' and 'clear_subsystem' callbacks
Date: Sat, 13 Jun 2026 13:14:35 +0200
Message-ID: <20260613111437.101763-7-hare@kernel.org>
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

When creating a new per-namespace filesystem static initialisation
doesn't work, so implement a 'fill_subsystem' and 'clear_subsystem'
callbacks to 'struct configfs_subsystem' to allow for every driver
to populate the subsystem structure dynamicall.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/configfs_internal.h |  4 ++
 fs/configfs/dir.c               | 90 ++++++++++++++++++++++++++++++++-
 fs/configfs/mount.c             |  6 +++
 include/linux/configfs.h        |  5 ++
 4 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index a91e97194c3d..7992a7da3de6 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -94,6 +94,10 @@ extern struct dentry *configfs_pin_fs(struct super_block *sb);
 extern void configfs_release_fs(struct super_block *sb);
 extern struct configfs_super_info *configfs_get_super_info(u64 ns_id);
 extern void configfs_put_super_info(struct configfs_super_info *info);
+extern void configfs_link_subsystems(struct super_block *sb,
+				     struct configfs_super_info *info);
+extern void configfs_unlink_subsystems(struct super_block *sb,
+				       struct configfs_super_info *info);
 
 extern const struct file_operations configfs_dir_operations;
 extern const struct file_operations configfs_file_operations;
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 6e111e3fd0e0..bf59165acec7 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1902,15 +1902,81 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		goto out_put;
 	}
 
+	if (subsys->fill_subsystem) {
+		err = subsys->fill_subsystem(subsys, info->ns_id);
+		if (err)
+			goto out_release;
+	}
+
 	err = configfs_link_root(info, subsys, root);
+	if (err) {
+		subsys->clear_subsystem(subsys, info->ns_id);
+		goto out_put;
+	}
+
+	mutex_lock(&info->subsys_mutex);
+	list_add(&subsys->su_link, &info->subsys_list);
+	mutex_unlock(&info->subsys_mutex);
+
+out_release:
 	if (err)
 		configfs_release_fs(NULL);
-
 out_put:
 	configfs_put_super_info(info);
 	return err;
 }
 
+void configfs_link_subsystems(struct super_block *sb,
+			      struct configfs_super_info *info)
+{
+	struct configfs_subsystem *s;
+	struct configfs_super_info *parent = configfs_get_super_info(0);
+
+	if (WARN_ON(IS_ERR(parent)))
+		return;
+	if (WARN_ON(parent == info))
+		return;
+	mutex_lock(&parent->subsys_mutex);
+	list_for_each_entry(s, &parent->subsys_list, su_link) {
+		struct configfs_subsystem *subsys;
+		struct dentry *root;
+		int err;
+
+		if (!s->fill_subsystem)
+			continue;
+		subsys = kzalloc_obj(*subsys);
+		if (!subsys)
+			continue;
+		subsys->fill_subsystem = s->fill_subsystem;
+		subsys->clear_subsystem = s->clear_subsystem;
+		INIT_LIST_HEAD(&subsys->su_link);
+		mutex_init(&subsys->su_mutex);
+		err = subsys->fill_subsystem(subsys, info->ns_id);
+		if (err) {
+			kfree(subsys);
+			continue;
+		}
+		root = configfs_pin_fs(sb);
+		if (IS_ERR(root)) {
+			subsys->clear_subsystem(subsys, info->ns_id);
+			kfree(subsys);
+			continue;
+		}
+		err = configfs_link_root(info, subsys, root);
+		if (err) {
+			configfs_release_fs(sb);
+			subsys->clear_subsystem(subsys, info->ns_id);
+			kfree(subsys);
+			continue;
+		}
+		mutex_lock(&info->subsys_mutex);
+		list_add(&subsys->su_link, &info->subsys_list);
+		mutex_unlock(&info->subsys_mutex);
+	}
+	mutex_unlock(&parent->subsys_mutex);
+	configfs_put_super_info(parent);
+}
+
 static void configfs_unlink_root(struct configfs_subsystem *subsys)
 {
 	struct config_group *group = &subsys->su_group;
@@ -1952,6 +2018,24 @@ static void configfs_unlink_root(struct configfs_subsystem *subsys)
 	dput(dentry);
 }
 
+void configfs_unlink_subsystems(struct super_block *sb,
+				struct configfs_super_info *info)
+{
+	struct configfs_subsystem *subsys, *s;
+
+	mutex_lock(&info->subsys_mutex);
+	list_for_each_entry_safe(subsys, s, &info->subsys_list, su_link) {
+		list_del_init(&subsys->su_link);
+		configfs_unlink_root(subsys);
+		if (subsys->clear_subsystem)
+			subsys->clear_subsystem(subsys, info->ns_id);
+		unlink_group(&subsys->su_group);
+		configfs_release_fs(sb);
+		kfree(subsys);
+	}
+	mutex_unlock(&info->subsys_mutex);
+}
+
 void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 {
 	struct configfs_super_info *info = configfs_get_super_info(0);
@@ -1959,9 +2043,11 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 
 	if (WARN_ON(IS_ERR(info)))
 		return;
-
 	mutex_lock(&info->subsys_mutex);
+	list_del_init(&subsys->su_link);
 	configfs_unlink_root(subsys);
+	if (subsys->clear_subsystem)
+		subsys->clear_subsystem(subsys, info->ns_id);
 	unlink_group(group);
 	mutex_unlock(&info->subsys_mutex);
 	configfs_release_fs(NULL);
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 8cf4bda14bec..8de3ae0cb6dd 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -142,6 +142,10 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_fs_info = info;
 	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
 	sb->s_d_flags |= DCACHE_DONTCACHE;
+
+	pr_info("%s: ns %llu\n", __func__, info->ns_id);
+	configfs_link_subsystems(sb, info);
+
 	return 0;
 }
 
@@ -164,6 +168,8 @@ static void configfs_kill_sb(struct super_block *sb)
 {
 	struct configfs_super_info *info = sb->s_fs_info;
 
+	pr_info("%s: ns %llu\n", __func__, info->ns_id);
+	configfs_unlink_subsystems(sb, info);
 	kill_anon_super(sb);
 	configfs_put_super_info(info);
 	sb->s_fs_info = NULL;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index ef65c75beeaa..ce88da5bdcec 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -226,8 +226,13 @@ struct configfs_group_operations {
 };
 
 struct configfs_subsystem {
+	struct list_head	su_link;
 	struct config_group	su_group;
 	struct mutex		su_mutex;
+	int (*fill_subsystem)(struct configfs_subsystem *subsys,
+			      u64 ns_id);
+	void (*clear_subsystem)(struct configfs_subsystem *subsys,
+				u64 ns_id);
 };
 
 static inline struct configfs_subsystem *to_configfs_subsystem(struct config_group *group)
-- 
2.51.0


