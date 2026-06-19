Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE6ECDB466
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0DubRTU6Iz/Ro7e394EwWw2nggdKXXszNCIb49yLvpw=; b=WsnhM4AgUchjQ9tKKeYoAf9ntQ
	+80cJ9C6VoY9dUVo5LB//o9pQVGclWy1qJ4ONWcvFN3MxcEBPs013IchPuF+UAc+oYiU/bq0iFM4f
	s6wGrRbmJWFbDDpGPbb1GaFGhya9NA1A7lJHREXILbichdiDsXdXLL2GQYt1Ptcs0LEy3U2SGgxS5
	6HlSBrQKz69oJVGOO55az9s4coRXizNcNdw0TMbIxyoFGuu3ygDlg+F7ErDGw/WHvuRrcW9PHMqSw
	kwgLHXpCjG3n+ub6Wq4gZRc9h9zkcEO3lF7vlHXqwq4DdVq+cYJAyADOwkVqpiAMNtOlGVBqYmeMY
	3aZLDJIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUin-00000002AX8-00Es;
	Fri, 19 Jun 2026 08:37:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUim-00000002AWp-2Tym
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 08:37:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0F338601F1;
	Fri, 19 Jun 2026 08:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8591F00A3D;
	Fri, 19 Jun 2026 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858223;
	bh=0DubRTU6Iz/Ro7e394EwWw2nggdKXXszNCIb49yLvpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KcyZ5XGJugPQr28ihVd68Mex1S8XV0jnx19U8HCmRULdGYVbxFD4IgVuhGaGgUudM
	 W+ZH/1VxVW3ij2l2aCAZaqsEus2PY70nsGK8QXuRvcYJZGr9AeYjua8P7YINDgi4/Q
	 HeF45lUTw+9iHguoVfAVSUg3u1/5kofwGv6A5SYaEiNulbMXMw/TSqyQDsX/6BTjca
	 fxm2gVCR1kw84CqPQE7xlgg9fEqxElRg/+rVfeO7qtDREyyS2cQxrtJURjB1kJpyFU
	 p/Zywlk5YfXZH0UQ6I1GjnFIlGZ32+LagbB63p8UAoz9rJU1fZtLXDL7x9y4Ehaja6
	 bTvrC+Wm8+eUg==
From: hare@kernel.org
Date: Fri, 19 Jun 2026 10:36:43 +0200
Subject: [PATCH RFC v2 03/12] fs/configfs: separate out
 configfs_{link,unlink}_root()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-3-82fd7094b8dc@kernel.org>
References: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
In-Reply-To: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=3492;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=yHAhB9e1/FR+axXJqTRcqWkjtSmawCZhBgvgAWNFAhA=;
 b=T8B1redzS1+XhYlL1Oibl9F9RL4WrP+6ueh2IM1ucsBM42ITWELCTpWMmmRI/NpByqf3Lnb6S
 su4hpfhEweQDI1CSIf78RapRIQFpk+VEdK8KL3uAg0ExHwg3Nwuyb6t
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

From: Hannes Reinecke <hare@suse.de>

Separate out functions to link and unlink subsystem groups.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/configfs/dir.c | 68 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 2cd64c13538699683487b0669e8950f5c7bedd54..c9e1ae47fb0d7796121fa6b45aeb10a832a69cff 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1861,31 +1861,19 @@ void configfs_unregister_default_group(struct config_group *group)
 }
 EXPORT_SYMBOL(configfs_unregister_default_group);
 
-int configfs_register_subsystem(struct configfs_subsystem *subsys)
+static int configfs_link_root(struct configfs_super_info  *info,
+			      struct configfs_subsystem *subsys,
+			      struct dentry *root)
 {
-	struct configfs_super_info *info = configfs_get_super_info(0);
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry;
-	struct dentry *root;
 	struct configfs_dirent *sd;
 	struct configfs_fragment *frag;
 	int err;
 
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
 	frag = new_fragment();
-	if (!frag) {
-		configfs_put_super_info(info);
+	if (!frag)
 		return -ENOMEM;
-	}
-
-	root = configfs_pin_fs();
-	if (IS_ERR(root)) {
-		put_fragment(frag);
-		configfs_put_super_info(info);
-		return PTR_ERR(root);
-	}
 
 	if (!group->cg_item.ci_name)
 		group->cg_item.ci_name = group->cg_item.ci_namebuf;
@@ -1923,32 +1911,47 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		mutex_lock(&info->subsys_mutex);
 		unlink_group(group);
 		mutex_unlock(&info->subsys_mutex);
-		configfs_release_fs();
 	}
 	put_fragment(frag);
-	configfs_put_super_info(info);
 	return err;
 }
 
-void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
+int configfs_register_subsystem(struct configfs_subsystem *subsys)
 {
 	struct configfs_super_info *info = configfs_get_super_info(0);
+	struct dentry *root;
+	int err;
+
+	if (WARN_ON(IS_ERR(info)))
+		return PTR_ERR(info);
+
+	root = configfs_pin_fs();
+	if (IS_ERR(root)) {
+		err = PTR_ERR(root);
+		goto out_put;
+	}
+
+	err = configfs_link_root(info, subsys, root);
+	if (err)
+		configfs_release_fs();
+
+out_put:
+	configfs_put_super_info(info);
+	return err;
+}
+
+static bool configfs_unlink_root(struct configfs_subsystem *subsys)
+{
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *root = dentry->d_sb->s_root;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
 
-	if (WARN_ON(IS_ERR(info))) {
-		dput(dentry);
-		return;
-	}
-
 	if (dentry->d_parent != root) {
 		pr_err("Tried to unregister non-subsystem!\n");
 		dput(dentry);
-		configfs_put_super_info(info);
-		return;
+		return false;
 	}
 
 	down_write(&frag->frag_sem);
@@ -1976,6 +1979,19 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	inode_unlock(d_inode(root));
 
 	dput(dentry);
+	return true;
+}
+
+void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
+{
+	struct configfs_super_info *info = configfs_get_super_info(0);
+	struct config_group *group = &subsys->su_group;
+
+	if (WARN_ON(IS_ERR(info)))
+		return;
+
+	if (!configfs_unlink_root(subsys))
+		return;
 
 	mutex_lock(&info->subsys_mutex);
 	unlink_group(group);

-- 
2.51.0


