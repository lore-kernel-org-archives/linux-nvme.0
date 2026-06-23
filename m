Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F69FCD4F26
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 09:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wpAp/KZC49c8kFrudIwCYrutlIBdMZ0fdUwXtidR8Dg=; b=trz79g0ogFqalAfOTbvj6PulcU
	DkjXJWc8lJNJPNUofv1h7OXthR1uXiaFe7LGPMKrblPPM4UANUwa7a4z/yix4EOM+9sdb9vodqXo7
	tKZzBlobtCjelubsS8WfMJm4L6DqPu6HBxbDMXgByed2SHt/t1r19S+CJcm5i4YPAKtLclcMIaNy2
	NL22CoDukAfNgMTUGPBI1QvinNUnDLx9Mr4898xdvSva5xDmbXJMLKzyYWOGRWt+TbKZEzTHki4gR
	gts48YbgKktYGLJOzx8/iY6lbZb835e+jtTyIuuRaXuEyu8xdYBchOjSbkrBt2VM19Yrh8KjwXX6n
	3kKproAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEs-00000005zHa-3YMx;
	Tue, 23 Jun 2026 09:16:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEr-00000005zGM-3Uy0
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 09:16:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 49D6F60207;
	Tue, 23 Jun 2026 09:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877071F00A3A;
	Tue, 23 Jun 2026 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206173;
	bh=wpAp/KZC49c8kFrudIwCYrutlIBdMZ0fdUwXtidR8Dg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qdnze3LBkpE2yPLr+MdG7rHzOIR3SZYXMJ0KU5ruOJ3i9EB7tCgISxawV9Yfrgg1o
	 C/o4a6VBOE7fhHu13dXXU8eafj9GNZIFU/jJ853jKfSkrrEAcB7Lc6JT6XVW6f7QnT
	 JiW5o+pcJ58JUIxDymhMw29thKnDcXA9z1etOnNPdHqCkJNATkaVC7Q/uKLd2vEG2/
	 N3fB3LlPFmoO/SJUrEdrnM0/P1L+m5FO4c3/hWqlYuzMr9U1pTtSEUbwKt29fBzAyZ
	 P42K9UHvflO0WKerO+jJ5C5h8OKhgpSZq8diUigD5vV9Uok9JHOVWLJgsN/KIwyxDu
	 ClcVLRMFItPjg==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:49 +0200
Subject: [PATCH RFC v3 04/12] fs/configfs: add superblock as attribute to
 configfs_pin_fs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-4-841c100fd5dd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=4037;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=zUpx+94NDxKVX6LvFJ3flbPP+BGcIFXXRg+eAJdt+bQ=;
 b=wTmfwy2RjcY+l1qLtrc5imI1PGeGOKV8nD4Sf9ccBSU5G9MVzktHtGjVzVES7bTxX7n7UFceF
 JXwju+f0tBdBUWGcTYomuzDmeTSxBudR/yCN1MT3GeUIhn4v+6X3t+x
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

Each namspace might have its own superblock, so add it as an argument
to configfs_pin_fs() to ensure that the correct filesystem instance
will be pinned.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/configfs_internal.h |  4 ++--
 fs/configfs/dir.c               | 10 +++++-----
 fs/configfs/mount.c             | 20 +++++++++++++-------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 94b9e306709150e7a123c46bb359077c6dc917ad..a4f10dd8ce0f46873d2053860a9fd25f3ee4c809 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -90,8 +90,8 @@ extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
 extern int configfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *iattr);
 
-extern struct dentry *configfs_pin_fs(void);
-extern void configfs_release_fs(void);
+extern struct dentry *configfs_pin_fs(struct super_block *sb);
+extern void configfs_release_fs(struct super_block *sb);
 extern struct configfs_super_info *configfs_get_super_info(struct net *net_ns);
 extern void configfs_put_super_info(struct configfs_super_info *info);
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ffd0e302cff1756f2161bdb58f1d8c1ac0cf893a..64635c58c0f33ec2d722b0555d3a9153f28bb200 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1144,7 +1144,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	 * Pin the configfs filesystem.  This means we can safely access
 	 * the root of the configfs filesystem.
 	 */
-	root = configfs_pin_fs();
+	root = configfs_pin_fs(NULL);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 
@@ -1171,7 +1171,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	 * If we succeeded, the fs is pinned via other methods.  If not,
 	 * we're done with it anyway.  So release_fs() is always right.
 	 */
-	configfs_release_fs();
+	configfs_release_fs(NULL);
 
 	return ret;
 }
@@ -1926,7 +1926,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	if (WARN_ON(IS_ERR(info)))
 		return PTR_ERR(info);
 
-	root = configfs_pin_fs();
+	root = configfs_pin_fs(NULL);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
 		goto out_put;
@@ -1934,7 +1934,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 
 	err = configfs_link_root(info, subsys, root);
 	if (err)
-		configfs_release_fs();
+		configfs_release_fs(NULL);
 
 out_put:
 	configfs_put_super_info(info);
@@ -2000,7 +2000,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	mutex_lock(&info->subsys_mutex);
 	unlink_group(group);
 	mutex_unlock(&info->subsys_mutex);
-	configfs_release_fs();
+	configfs_release_fs(NULL);
 	configfs_put_super_info(info);
 }
 
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 067bb1099a52ca2216d1b2881429a3fd1811c706..8b26ceb7b0d4a03a17c251de42902aaabef5a652 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -192,18 +192,24 @@ static struct file_system_type configfs_fs_type = {
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
 
+	simple_release_fs(&info->mnt, &info->mnt_count);
+}
 
 static int __init configfs_init(void)
 {

-- 
2.51.0


