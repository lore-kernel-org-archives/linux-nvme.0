Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5922CCD4F26
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kl69Acos4aSFZW4g2mj7Q0KbVM7JvpfOKb3J/6r7fdY=; b=DinMIyRFXPY1MQ43ScYPgr4AYw
	IPJgllyuHepcWAnWR2wwfvZMu2d7PLeQOVcxpPN79wkSLBD/p0RCNcOuD+3IqUtQs1VDyqq185tUX
	OQ8Zj2zg/UNT1zHyx2GGXCIZN5csZOgF7o4FKe7GS7jf4se1YcJ+DdlM8HRk+qPHr/2q0iyrVJBrw
	q4MOmAsedZpNtRQ4fadoKNCXfob2icIhZUEtsg9fKcoRhPrFGFRtodwkiQ1fLq7mST5pTzMYHd6Lz
	PL6fNc+9IUcjHlImMRNbkJv2VHX2GfT5awW7erGJTi90PdVM7ZiJyLvzS6X8lcIsUzhMFaLrZGTYd
	9vxEOmsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEv-00000005zKT-3zei;
	Tue, 23 Jun 2026 09:16:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEu-00000005zJ8-3A8Z
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 09:16:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 365A460052;
	Tue, 23 Jun 2026 09:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746CE1F000E9;
	Tue, 23 Jun 2026 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206175;
	bh=Kl69Acos4aSFZW4g2mj7Q0KbVM7JvpfOKb3J/6r7fdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xb/uqtCIXM39JVsESNv0ex2uM//E7DHD5CzeTOVzyOsznzeuQSYzdaS+bEgeRdU9d
	 ZS1oFE/+s8pteYKCro0skFHGr+OUWQ4cvllWMT8e4eUQgQc97oWzNVFPpWlhu4Haax
	 tlnXNlx0BA2B5ZvREFIINScdc8a3Li/jHtDuOVBUSXt69k4/wUlkz6eHcPuhEyB6eN
	 mveGsCphRBuYSex4GCam3utds/Q0kF0/4MtkhT7x7Vyl8FUEN7VyRiFMK2lydhpJNN
	 33GcY+tP4hDr5tLo+WWuYWJNXgJYEUgj7vEhJE1faOYiB4EL3nccycP9qw62yeTjy+
	 aPLtnNAi0AtuQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:50 +0200
Subject: [PATCH RFC v3 05/12] fs/configfs: add 'fill_subsystem' and
 'clear_subsystem' callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-5-841c100fd5dd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=7032;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=mNNVobvs7hVD8uC8x3LhVAOH1D1V3YLWa2lQULFjfxE=;
 b=UTkgYc5+fJhEfP0gSeKq05zG/FnS4eOGPC4Q56VPhD5h+44VlqLep48yBR+KTWXPWDbaQT4bU
 WXrQrYtQ4QlC56rjSABKm7QeKGhf/t9+uo321d40y5V1zJYEIhGoASt
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

When creating a new per-namespace filesystem static initialisation
doesn't work, so implement a 'fill_subsystem' and 'clear_subsystem'
callbacks to 'struct configfs_subsystem' to allow for every driver
to populate the subsystem structure dynamicall.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/configfs_internal.h |   4 ++
 fs/configfs/dir.c               | 104 +++++++++++++++++++++++++++++++++++++++-
 fs/configfs/mount.c             |   4 ++
 include/linux/configfs.h        |   5 ++
 4 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index a4f10dd8ce0f46873d2053860a9fd25f3ee4c809..35eddc274b88796442c080fe4fe8a6ea68762185 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -94,6 +94,10 @@ extern struct dentry *configfs_pin_fs(struct super_block *sb);
 extern void configfs_release_fs(struct super_block *sb);
 extern struct configfs_super_info *configfs_get_super_info(struct net *net_ns);
 extern void configfs_put_super_info(struct configfs_super_info *info);
+extern void configfs_link_subsystems(struct super_block *sb,
+				     struct configfs_super_info *info);
+extern void configfs_unlink_subsystems(struct super_block *sb,
+				       struct configfs_super_info *info);
 
 extern const struct file_operations configfs_dir_operations;
 extern const struct file_operations configfs_file_operations;
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 64635c58c0f33ec2d722b0555d3a9153f28bb200..3d39a6c1a4163632c9acdc8cf831add40c9b430e 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1932,15 +1932,95 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		goto out_put;
 	}
 
+	if (subsys->fill_subsystem) {
+		INIT_LIST_HEAD(&subsys->su_link);
+		mutex_init(&subsys->su_mutex);
+		config_group_init(&subsys->su_group);
+		err = subsys->fill_subsystem(subsys, info->net_ns);
+		if (err)
+			goto out_release;
+	}
+
 	err = configfs_link_root(info, subsys, root);
+	if (err) {
+		if (subsys->clear_subsystem)
+			subsys->clear_subsystem(subsys, info->net_ns);
+		goto out_release;
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
+	struct configfs_super_info *parent = configfs_get_super_info(&init_net);
+	LIST_HEAD(subsys_list);
+
+	if (WARN_ON(IS_ERR(parent)))
+		return;
+	if ((info->net_ns == &init_net) || WARN_ON(parent == info)) {
+		configfs_put_super_info(parent);
+		return;
+	}
+	mutex_lock(&parent->subsys_mutex);
+	list_splice_init(&parent->subsys_list, &subsys_list);
+	mutex_unlock(&parent->subsys_mutex);
+	list_for_each_entry(s, &subsys_list, su_link) {
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
+		config_group_init(&subsys->su_group);
+		err = subsys->fill_subsystem(subsys, info->net_ns);
+		if (err) {
+			kfree(subsys);
+			continue;
+		}
+		root = configfs_pin_fs(sb);
+		if (IS_ERR(root)) {
+			if (subsys->clear_subsystem)
+				subsys->clear_subsystem(subsys, info->net_ns);
+			kfree(subsys);
+			continue;
+		}
+		err = configfs_link_root(info, subsys, root);
+		if (err) {
+			configfs_release_fs(sb);
+			if (subsys->clear_subsystem)
+				subsys->clear_subsystem(subsys, info->net_ns);
+			kfree(subsys);
+			continue;
+		}
+		mutex_lock(&info->subsys_mutex);
+		list_add(&subsys->su_link, &info->subsys_list);
+		mutex_unlock(&info->subsys_mutex);
+	}
+	mutex_lock(&parent->subsys_mutex);
+	list_splice(&subsys_list, &parent->subsys_list);
+	mutex_unlock(&parent->subsys_mutex);
+	configfs_put_super_info(parent);
+}
+
 static bool configfs_unlink_root(struct configfs_subsystem *subsys)
 {
 	struct config_group *group = &subsys->su_group;
@@ -1983,6 +2063,25 @@ static bool configfs_unlink_root(struct configfs_subsystem *subsys)
 	return true;
 }
 
+void configfs_unlink_subsystems(struct super_block *sb,
+				struct configfs_super_info *info)
+{
+	struct configfs_subsystem *subsys, *s;
+
+	mutex_lock(&info->subsys_mutex);
+	list_for_each_entry_safe(subsys, s, &info->subsys_list, su_link) {
+		list_del_init(&subsys->su_link);
+		if (!configfs_unlink_root(subsys))
+			continue;
+		if (subsys->clear_subsystem)
+			subsys->clear_subsystem(subsys, info->net_ns);
+		unlink_group(&subsys->su_group);
+		configfs_release_fs(sb);
+		kfree(subsys);
+	}
+	mutex_unlock(&info->subsys_mutex);
+}
+
 void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 {
 	struct configfs_super_info *info;
@@ -1998,6 +2097,9 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	}
 
 	mutex_lock(&info->subsys_mutex);
+	list_del_init(&subsys->su_link);
+	if (subsys->clear_subsystem)
+		subsys->clear_subsystem(subsys, info->net_ns);
 	unlink_group(group);
 	mutex_unlock(&info->subsys_mutex);
 	configfs_release_fs(NULL);
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 8b26ceb7b0d4a03a17c251de42902aaabef5a652..d36fc4a6f6439bea645e62b8423b518a5d7d51c1 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -157,6 +157,9 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = root;
 	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
 	sb->s_d_flags |= DCACHE_DONTCACHE;
+
+	configfs_link_subsystems(sb, info);
+
 	return 0;
 }
 
@@ -179,6 +182,7 @@ static void configfs_kill_sb(struct super_block *sb)
 {
 	struct configfs_super_info *info = sb->s_fs_info;
 
+	configfs_unlink_subsystems(sb, info);
 	kill_anon_super(sb);
 	configfs_put_super_info(info);
 	sb->s_fs_info = NULL;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 19165e36da810c75500bb584702ae3a594c3510d..893ae778585fb8be60026c661cb1ef63980ff0e3 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -227,8 +227,13 @@ struct configfs_group_operations {
 };
 
 struct configfs_subsystem {
+	struct list_head	su_link;
 	struct config_group	su_group;
 	struct mutex		su_mutex;
+	int (*fill_subsystem)(struct configfs_subsystem *subsys,
+			      struct net *net_ns);
+	void (*clear_subsystem)(struct configfs_subsystem *subsys,
+				struct net *net_ns);
 };
 
 static inline struct configfs_subsystem *to_configfs_subsystem(struct config_group *group)

-- 
2.51.0


