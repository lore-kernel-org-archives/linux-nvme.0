Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1BCCDB466
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 08:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KDiwLGU+odzbmD9GZSL5//LByb2p+7bHG/tzyfspCIQ=; b=16HxDpiT5pJiP/OZNpPaSnVtFZ
	WjDSH63hZD9hZetuZoZdVyMv5NA77IjCDIWgVxYSTaTgAoryAzRlb0jHiu7qprFRjlbfD99CkRFhX
	/GKtb0NLBYhKxdMEJi20FOjQbCKhH1jtC16YoVr9CGsIhLJP7VX+IfnK9HS+BpBroGgYn+DEJ9h8B
	3wn2n49V2CUrRNuDUIeJNnqQPmOPjg9HC9EaSZqpDyYOqznVlaU/IDyX/02fYU1QYEyX+Vdq2Un6J
	diVw7DuDtAOo4ueEutDRRDb1K1KEE/YtyYGNxuY1ijP/tTdvtiKC1baRZlxkgosSnHv5e+mJqdzi3
	EGI6aZIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUj4-00000002AlK-1vob;
	Fri, 19 Jun 2026 08:37:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUj3-00000002AkK-2bXJ
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 08:37:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 611DC44556;
	Fri, 19 Jun 2026 08:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC63B1F00A3A;
	Fri, 19 Jun 2026 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858241;
	bh=KDiwLGU+odzbmD9GZSL5//LByb2p+7bHG/tzyfspCIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cyFIgQKkywXArtsxvVjycromWIk9d6/aDNJN2QZ6WFJstDdixKOWpEvBaWONZ67vF
	 MkRB2C3UIB3n2yNXkEFlk3h0bU4CDZ16rq/Z37KJu4AkRiNbevy0IG6vlUyU1TBDAc
	 lv6DsUBajPpOgppCZt8rVjzyrhyL6cvUnWNosnTXDcagHydhYzjkK58gaDRejeYjbd
	 +fXkV62rqu/I3N5Z/1xRULJcFspc184F6nOIBSYGZ12eo8+aoDK69Vlr1ToGR7T98K
	 V6I5bm7lIiDJPOIGO9qisJ+4bcsCixu9akB060njQS/ddrK17/3yCOZAlRoGUMXCj9
	 BxFkxy3AxfkTg==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 19 Jun 2026 10:36:49 +0200
Subject: [PATCH RFC v2 09/12] fs/configfs: open-code simple_pin_fs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-9-82fd7094b8dc@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=2713;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=ch4bHGgbRPURj2zO9pNW/tcTcK3a5KTWkscKkwzKVR4=;
 b=dAEuGgEFfSWlO+kzPLmI6jFBHDmp3qCxSxyaWT1G8mrtUs748LMG0jLYZpsqZsQxgRfT+OLhL
 fOzY43JU4fmDD9df6SyMPX4/di+82WY1Bla5HfPzcpgWOTK1BPopi7O
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

simple_pin_fs() is protected by an internal spin lock, to
protect against concurrent use of simple_release_fs().
But as we also need to clone the mountpoint we cannot
easily expand the scope of the lock as it's internal to
fs/libfs. So open-code simple_pin_fs() and simple_release_fs()
to be able to use a lock covering all use-cases.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/configfs/mount.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 36f275aaaf871f748dfcb011b782c22abe19d9d5..1f61bc1efe6e2644985c6b90777fa8ddcbb4b742 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -25,6 +25,7 @@
 struct kmem_cache *configfs_dir_cachep;
 static DEFINE_XARRAY(configfs_super_xa);
 static struct configfs_super_info *configfs_root;
+static DEFINE_SPINLOCK(configfs_pin_lock);
 
 static u64 configfs_ns_id(struct net *net_ns)
 {
@@ -219,21 +220,60 @@ MODULE_ALIAS_FS("configfs");
 
 struct dentry *configfs_pin_fs(struct super_block *sb)
 {
-	struct configfs_super_info *info = configfs_root;
-	int err;
-
-	err = simple_pin_fs(&configfs_fs_type, &info->mnt, &info->mnt_count);
-	if (err)
-		return ERR_PTR(err);
+	struct configfs_super_info *info;
 
+	spin_lock(&configfs_pin_lock);
+	if (sb) {
+		struct configfs_super_info *root = configfs_root;
+		struct dentry *dentry = sb->s_root;
+
+		info = sb->s_fs_info;
+		if (!info->mnt) {
+			struct vfsmount *mnt;
+
+			spin_unlock(&configfs_pin_lock);
+			mnt = mnt_clone_direct(root->mnt, dentry);
+			if (IS_ERR(mnt))
+				return ERR_CAST(mnt);
+			spin_lock(&configfs_pin_lock);
+			info->mnt = mnt;
+		} else {
+			mntget(info->mnt);
+		}
+	} else {
+		info = configfs_root;
+		if (!info->mnt) {
+			struct vfsmount *mnt;
+
+			spin_unlock(&configfs_pin_lock);
+			mnt = vfs_kern_mount(&configfs_fs_type, SB_KERNMOUNT,
+					     configfs_fs_type.name, NULL);
+			if (IS_ERR(mnt))
+				return ERR_CAST(mnt);
+			spin_lock(&configfs_pin_lock);
+			info->mnt = mnt;
+		} else {
+			mntget(info->mnt);
+		}
+	}
+	info->mnt_count++;
+	spin_unlock(&configfs_pin_lock);
 	return info->mnt->mnt_root;
 }
 
 void configfs_release_fs(struct super_block *sb)
 {
 	struct configfs_super_info *info = configfs_root;
-
-	simple_release_fs(&info->mnt, &info->mnt_count);
+	struct vfsmount *mnt;
+
+	spin_lock(&configfs_pin_lock);
+	if (sb)
+		info = sb->s_fs_info;
+	mnt = info->mnt;
+	if (--info->mnt_count)
+		info->mnt = NULL;
+	spin_unlock(&configfs_pin_lock);
+	mntput(mnt);
 }
 
 static int __init configfs_init(void)

-- 
2.51.0


