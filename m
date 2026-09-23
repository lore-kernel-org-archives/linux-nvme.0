Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A2DC982FA
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 03:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ROA95LQ2XhQVA9V66ILPKJS6dG9LjRpy8RZm4OVovw=; b=03q/8BuFpjO74Ss7g33xWBciYp
	eft6AOoMgMwjRMzttVj+de8BYG2o5dCQikvnm/acVGwxwOri9ThBNGLn89gqxE018ltZ+hk8BqggQ
	eEsXw2fXbM45odZ9XbkzCx4pB4m+zJ0TQ1fvTgcSJ0Y+DLWIJQdwPx/EcZhO/IiIGkRsIfuBKl5HL
	sRP4xEm8bOZ06fUfGgqtlXeT8pbFJO10kC+iDiRkmwpN9Wze4ofe+u5cntGo0EHyxiP57GCeroJBm
	MMvpdJCBCfEC5a3v3uRwiVJTYtoL1XvDAYLs1LuU5wXnc+JY5gNqL11ecKwSKSmk3ixDy+HOybP6b
	Ho515Z7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9DYb-000000071jq-1ItT;
	Wed, 23 Sep 2026 03:22:05 +0000
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9DYY-000000071jH-1gno
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 03:22:03 +0000
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4eceabcf4;
	Wed, 23 Sep 2026 11:16:58 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v5 1/3] fs: configfs: add helpers for opening non-configfs paths
Date: Wed, 23 Sep 2026 11:16:39 +0800
Message-Id: <20260923031641.2016406-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923031641.2016406-1-runyu.xiao@seu.edu.cn>
References: <20260923031641.2016406-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0cc443ab103a1kunmae5dc6a4b63c6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRhIVkkaQk5LHxlDSk8dS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=VWUOSqVUWJn7AS7X0KU29H8wj6nfxmD/w/bBSRlxMQqrqUkqdyx/pYCO2hqPwX7PYq66NWKa7J7w3EXcVnkir1vi8bCabZuGf9S062mmEivUE6WQrIp2ZkeL+pDHQvOVPKjHmQhWcby5lSgLctlLlpnSIgg4/WxxMmd64sPrejU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=7ROA95LQ2XhQVA9V66ILPKJS6dG9LjRpy8RZm4OVovw=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_202202_678807_5198DE43 
X-CRM114-Status: GOOD (  16.25  )
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

Configfs store callbacks run with the fragment semaphore of the item they
belong to held for reading.  A callback that opens a configfs path can
re-enter __configfs_open_file(), which takes that same semaphore again on
a non-recursive rwsem, and deadlock the task.

Add a pair of helpers for such callbacks.  configfs_file_open() resolves a
configured pathname, rejects it if it resolves to configfs, and opens it.
configfs_open_root() rejects a configfs root and opens relative to an
already-resolved root, so a caller can validate a root once and keep
opening files below it.  The helpers compare the actual filesystem type
and use file_open_root(), so the normal open-time permission and security
checks still apply.

Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 fs/configfs/mount.c      | 68 ++++++++++++++++++++++++++++++++++++++++
 include/linux/configfs.h |  5 +++
 2 files changed, 73 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d8cac1cbf3bd5..b2c14cf6a4053 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -118,6 +119,73 @@ static struct file_system_type configfs_fs_type = {
 };
 MODULE_ALIAS_FS("configfs");
 
+/**
+ * configfs_open_root - open a path relative to an already-resolved root
+ * @root: resolved root, which must not be on configfs
+ * @name: path to open relative to @root, or "" to open @root itself
+ * @flags: open flags as per the open(2) second argument
+ * @mode: mode argument passed to file_open_root()
+ *
+ * Open @name relative to @root, refusing a @root on configfs.
+ *
+ * Configfs store callbacks are called with the fragment semaphore of the
+ * item they belong to held for reading.  Opening a configfs path from
+ * such a callback can re-enter __configfs_open_file() and take that same
+ * semaphore again, which is not recursive and deadlocks.  Callers that
+ * open a user-configured path from a configfs store callback must
+ * therefore use this helper instead of filp_open() or a bare
+ * file_open_root().
+ *
+ * Resolving @name relative to @root also lets a caller pin and validate a
+ * root once and keep opening files below it, rather than re-resolving a
+ * pathname that can be retargeted in the meantime.  The normal open-time
+ * permission and security checks still apply to the file being opened.
+ *
+ * Return: the opened file, or an ERR_PTR() value.  -EINVAL is returned if
+ * @root is on configfs.
+ */
+struct file *configfs_open_root(const struct path *root, const char *name,
+				int flags, umode_t mode)
+{
+	if (root->dentry->d_sb->s_type == &configfs_fs_type)
+		return ERR_PTR(-EINVAL);
+
+	return file_open_root(root, name, flags, mode);
+}
+EXPORT_SYMBOL_GPL(configfs_open_root);
+
+/**
+ * configfs_file_open - open a pathname that must not resolve to configfs
+ * @filename: existing pathname to resolve and open
+ * @flags: open flags as per the open(2) second argument
+ * @mode: mode argument passed to file_open_root()
+ *
+ * Resolve @filename and open the resulting file, refusing to open it if it
+ * resolves to configfs.  @filename must already exist; this helper cannot
+ * create a missing path.  Use this from configfs store callbacks that open
+ * a path configured by the user, in place of filp_open().  See
+ * configfs_open_root() for why opening configfs again from such a callback
+ * deadlocks.
+ *
+ * Return: the opened file, or an ERR_PTR() value.  -EINVAL is returned if
+ * @filename resolves to configfs.
+ */
+struct file *configfs_file_open(const char *filename, int flags, umode_t mode)
+{
+	struct file *file;
+	struct path path;
+	int ret;
+
+	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	file = configfs_open_root(&path, "", flags, mode);
+	path_put(&path);
+	return file;
+}
+EXPORT_SYMBOL_GPL(configfs_file_open);
+
 struct dentry *configfs_pin_fs(void)
 {
 	int err = simple_pin_fs(&configfs_fs_type, &configfs_mount,
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index ef65c75beeaad..2a803bb836b4d 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -34,6 +34,8 @@ struct configfs_group_operations;
 struct configfs_attribute;
 struct configfs_bin_attribute;
 struct configfs_subsystem;
+struct file;
+struct path;
 
 struct config_item {
 	char			*ci_name;
@@ -243,6 +245,9 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys);
 int configfs_register_group(struct config_group *parent_group,
 			    struct config_group *group);
 void configfs_unregister_group(struct config_group *group);
+struct file *configfs_open_root(const struct path *root, const char *name,
+				int flags, umode_t mode);
+struct file *configfs_file_open(const char *filename, int flags, umode_t mode);
 
 void configfs_remove_default_groups(struct config_group *group);
 
-- 
2.34.1

