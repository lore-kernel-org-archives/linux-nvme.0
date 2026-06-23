Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FF4CDB46F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZuOCy0Ub9zV1vVbHEmvRKz2G/+khR/RY/v9YB/RFdmI=; b=LpQndADCwWJSOvwWccdPE3E/Yz
	MGSBbJWEo0mLoEUUeJHcBqPT1cOUAfC+F969tCZlbYEMWCrI17VhcHSX/PktvKiSWWYueEbycf1fL
	MQ2loko9OZZ4dsHzWIs7GHhQCf732EnKNUcFmLf5rwdB/Pvu9oXMDDVqefFBcfcjAjlg4qaLATmh+
	CYoLhQBITsSP6Jpr0zebZCWbe5IyRY4DN77d+V11hIrnp0efb5ZV9ks8ndF1XnvtH20SLKhJwhKwB
	+DZom2ZBWeTBGth/ZzN1yX1Ww/1GbbAatXnIuy+sEgwEOyriT8+i7xgW7STLAbmV8g70pDzu155x4
	8jkkAuRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEq-00000005zFX-2UFw;
	Tue, 23 Jun 2026 09:16:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEp-00000005zEv-0HE9
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 09:16:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5CBC1601F5;
	Tue, 23 Jun 2026 09:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFE91F000E9;
	Tue, 23 Jun 2026 09:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206170;
	bh=ZuOCy0Ub9zV1vVbHEmvRKz2G/+khR/RY/v9YB/RFdmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ptl4OIclXbLCb0Y9GjUF9E09X9wvAyOPD5j7/3B8Bz7VD0ZmvLjI5Xuo0ls3fyeBC
	 wYEuGn1JzDDmVhDncy0x3wrS3HYVSrXpBDro/OWa4M5IhL4zep8YzhIDMujxYjnrBP
	 WfAYYRWg8pRTigLeCLGCmFNw1C/DvvMK2yUowdlHrLTOFAYnGAD8L1aYSDddsE0pBS
	 QqLP1Tab9oiWq0fO1lSbHw7wIZkpUWXhgIqZAHlyzGF9bMtf+8e9NRoz2EK3Ttm/Jc
	 TkoQuMqL8sGxjwPAqx07QP1P3h4TEFVNrf/j7H2yU6Cq1A575wGm3Qv31QhX5Tlptl
	 1YHC4XEn7ulAA==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:48 +0200
Subject: [PATCH RFC v3 03/12] fs/configfs: separate out
 configfs_{link,unlink}_root()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-3-841c100fd5dd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=3634;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=AbOvo5csGGhKO8qSenOs73H9nrtomlMUlevoJuGVZH4=;
 b=Q+bp0/DYD3dz8Rx5ZHMxWf54LUeVBbSsj2SPji/DM4S46c2HHnaadOUrkgv9+ShpYSGc2jFKV
 2pQSka5qAZBAK4dE4TPY8xb2a93xuYbDit7ajPFDBv8knGiPjy9RVBB
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

Separate out functions to link and unlink subsystem groups.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/dir.c | 74 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 1e9c82e02741798930b08c96fb59a2767c7e00fc..ffd0e302cff1756f2161bdb58f1d8c1ac0cf893a 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1861,32 +1861,19 @@ void configfs_unregister_default_group(struct config_group *group)
 }
 EXPORT_SYMBOL(configfs_unregister_default_group);
 
-int configfs_register_subsystem(struct configfs_subsystem *subsys)
+static int configfs_link_root(struct configfs_super_info  *info,
+			      struct configfs_subsystem *subsys,
+			      struct dentry *root)
 {
-	struct configfs_super_info *info;
 	struct config_group *group = &subsys->su_group;
 	struct dentry *dentry;
-	struct dentry *root;
 	struct configfs_dirent *sd;
 	struct configfs_fragment *frag;
 	int err;
 
-	info = configfs_get_super_info(&init_net);
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
@@ -1924,33 +1911,48 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
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
 	struct configfs_super_info *info;
+	struct dentry *root;
+	int err;
+
+	info = configfs_get_super_info(&init_net);
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
 
-	info = configfs_get_super_info(&init_net);
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
@@ -1978,6 +1980,22 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	inode_unlock(d_inode(root));
 
 	dput(dentry);
+	return true;
+}
+
+void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
+{
+	struct configfs_super_info *info;
+	struct config_group *group = &subsys->su_group;
+
+	info = configfs_get_super_info(&init_net);
+	if (WARN_ON(IS_ERR(info)))
+		return;
+
+	if (!configfs_unlink_root(subsys)) {
+		configfs_put_super_info(info);
+		return;
+	}
 
 	mutex_lock(&info->subsys_mutex);
 	unlink_group(group);

-- 
2.51.0


